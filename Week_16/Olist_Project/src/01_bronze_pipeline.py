# Databricks notebook source
# Bronze — clean rebuild with multiLine + escape (handles comment fields with commas/newlines)

# COMMAND ----------
from pyspark.sql.functions import current_timestamp, col

RAW =  "/Volumes/ws_olist_marketplace/bronze/olist_raw/"
CAT = "ws_olist_marketplace"

# Force a clean rebuild so any previously mis-parsed tables are wiped
# spark.sql(f"DROP SCHEMA IF EXISTS {CAT}.bronze CASCADE")
# spark.sql(f"CREATE SCHEMA {CAT}.bronze")

tables = {
    "orders": "olist_orders_dataset.csv",
    "order_items": "olist_order_items_dataset.csv",
    "order_payments": "olist_order_payments_dataset.csv",
    "order_reviews": "olist_order_reviews_dataset.csv",
    "products": "olist_products_dataset.csv",
    "sellers": "olist_sellers_dataset.csv",
    "customers": "olist_customers_dataset.csv",
    "geolocation": "olist_geolocation_dataset.csv",
    "category_translation": "product_category_name_translation.csv",
}

for name, file in tables.items():
    df = (spark.read
          .option("header", True)
          .option("inferSchema", True)
          .option("multiLine", True)
          .option("escape", '"')
          .csv(RAW + file)
          .withColumn("_ingest_ts", current_timestamp())
          .withColumn("_source_file", col("_metadata.file_path")))
    df.write.mode("overwrite").saveAsTable(f"{CAT}.bronze.{name}")
    print(f"bronze.{name}: {df.count()} rows")

# COMMAND ----------
# Quick data-quality check — review_score should be clean 1-5 only
display(spark.sql(f"""
    SELECT review_score, COUNT(*) AS n
    FROM {CAT}.bronze.order_reviews
    GROUP BY review_score ORDER BY n DESC
"""))