# Databricks notebook source
# Silver — clean, conform, dedupe, AI enrichment (try_cast everywhere numeric)

# COMMAND ----------
from pyspark.sql.functions import col, coalesce, row_number, expr
from pyspark.sql.window import Window

CAT = "ws_olist_marketplace"

# COMMAND ----------
# Orders — rename timestamps, drop null keys
orders = (spark.table(f"{CAT}.bronze.orders")
    .withColumnRenamed("order_purchase_timestamp", "order_purchase_ts")
    .withColumnRenamed("order_approved_at", "order_approved_ts")
    .withColumnRenamed("order_delivered_carrier_date", "order_delivered_carrier_ts")
    .withColumnRenamed("order_delivered_customer_date", "order_delivered_customer_ts")
    .withColumnRenamed("order_estimated_delivery_date", "order_estimated_delivery_ts")
    .filter(col("order_id").isNotNull()))
orders.write.mode("overwrite").option("overwriteSchema", "true").saveAsTable(f"{CAT}.silver.orders")
print("silver.orders:", spark.table(f"{CAT}.silver.orders").count())

# COMMAND ----------
# Order items — safe numeric casts
order_items = (spark.table(f"{CAT}.bronze.order_items")
    .withColumn("price", expr("try_cast(price AS decimal(10,2))"))
    .withColumn("freight_value", expr("try_cast(freight_value AS decimal(10,2))"))
    .filter(col("order_id").isNotNull()))
order_items.write.mode("overwrite").option("overwriteSchema", "true").saveAsTable(f"{CAT}.silver.order_items")
print("silver.order_items:", spark.table(f"{CAT}.silver.order_items").count())

# COMMAND ----------
# Products — qualified join, safe weight cast
prod = spark.table(f"{CAT}.bronze.products")
trans = spark.table(f"{CAT}.bronze.category_translation")
products = (prod.join(trans, prod["product_category_name"] == trans["product_category_name"], "left")
    .withColumn("category_en", coalesce(trans["product_category_name_english"], prod["product_category_name"]))
    .select(prod["product_id"], col("category_en"),
            expr("try_cast(product_weight_g AS int)").alias("product_weight_g")))
products.write.mode("overwrite").option("overwriteSchema", "true").saveAsTable(f"{CAT}.silver.products")
print("silver.products:", spark.table(f"{CAT}.silver.products").count())

# COMMAND ----------
# Customers & sellers — pass-through clean
(spark.table(f"{CAT}.bronze.customers")
 .withColumnRenamed("customer_zip_code_prefix", "customer_zip_prefix")
 .write.mode("overwrite").option("overwriteSchema", "true").saveAsTable(f"{CAT}.silver.customers"))
(spark.table(f"{CAT}.bronze.sellers")
 .withColumnRenamed("seller_zip_code_prefix", "seller_zip_prefix")
 .write.mode("overwrite").option("overwriteSchema", "true").saveAsTable(f"{CAT}.silver.sellers"))
print("silver.customers:", spark.table(f"{CAT}.silver.customers").count())
print("silver.sellers:", spark.table(f"{CAT}.silver.sellers").count())

# COMMAND ----------
# Geolocation — dedupe to one row per zip prefix
w = Window.partitionBy("geolocation_zip_code_prefix").orderBy("geolocation_lat")
geo = (spark.table(f"{CAT}.bronze.geolocation")
    .withColumn("rn", row_number().over(w)).filter(col("rn") == 1).drop("rn"))
geo.write.mode("overwrite").option("overwriteSchema", "true").saveAsTable(f"{CAT}.silver.geolocation")
print("silver.geolocation:", spark.table(f"{CAT}.silver.geolocation").count())

# COMMAND ----------
# Reviews — AI sentiment + issue classification (safe score cast, LIMIT 500)
# spark.sql(f"""
# CREATE OR REPLACE TABLE {CAT}.silver.reviews_enriched AS
# SELECT
#     review_id, order_id,
#     try_cast(review_score AS int) AS review_score,
#     review_comment_message,
#     ai_analyze_sentiment(review_comment_message) AS sentiment,
#     ai_classify(review_comment_message,
#         ARRAY('delivery','product_quality','price','customer_service','other')
#     ) AS issue_category
# FROM {CAT}.bronze.order_reviews
# WHERE review_comment_message IS NOT NULL
# LIMIT 500
# """)
# print("silver.reviews_enriched:", spark.table(f"{CAT}.silver.reviews_enriched").count())
#
# # COMMAND ----------
# display(spark.sql(f"SELECT * FROM {CAT}.silver.reviews_enriched LIMIT 10"))