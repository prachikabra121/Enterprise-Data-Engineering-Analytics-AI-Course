# Databricks notebook source
# Gold — star schema + KPIs (try_cast on all numerics, hardened)

# COMMAND ----------
CAT = "ws_olist_marketplace"

# COMMAND ----------
# Pre-flight — confirm silver inputs have rows
for t in ["orders", "order_items", "products", "customers", "sellers"]:
    n = spark.table(f"{CAT}.silver.{t}").count()
    print(f"silver.{t}: {n} rows")
    assert n > 0, f"silver.{t} is EMPTY — fix silver before gold"

# COMMAND ----------
# Fact — one row per delivered order line (try_cast guards on price/freight)
spark.sql(f"""
CREATE OR REPLACE TABLE {CAT}.gold.fact_sales AS
SELECT
    oi.order_id, oi.order_item_id, oi.product_id, oi.seller_id,
    o.customer_id, o.order_status,
    o.order_purchase_ts,
    try_cast(oi.price AS decimal(10,2))          AS price,
    try_cast(oi.freight_value AS decimal(10,2))  AS freight_value,
    (try_cast(oi.price AS decimal(10,2)) + try_cast(oi.freight_value AS decimal(10,2))) AS gross_value,
    DATEDIFF(o.order_delivered_customer_ts, o.order_purchase_ts) AS delivery_days,
    CASE WHEN o.order_delivered_customer_ts <= o.order_estimated_delivery_ts
         THEN 1 ELSE 0 END AS on_time_flag
FROM {CAT}.silver.order_items oi
JOIN {CAT}.silver.orders o ON oi.order_id = o.order_id
WHERE o.order_status = 'delivered'
""")
fact_n = spark.table(f"{CAT}.gold.fact_sales").count()
print(f"gold.fact_sales: {fact_n} rows")
assert fact_n > 0, "fact_sales EMPTY — check order_status / timestamps in silver.orders"

# COMMAND ----------
# Dimensions
spark.sql(f"""
CREATE OR REPLACE TABLE {CAT}.gold.dim_product AS
SELECT product_id, category_en AS category, product_weight_g
FROM {CAT}.silver.products
""")
spark.sql(f"""
CREATE OR REPLACE TABLE {CAT}.gold.dim_customer AS
SELECT customer_id, customer_unique_id, customer_city, customer_state
FROM {CAT}.silver.customers
""")
spark.sql(f"""
CREATE OR REPLACE TABLE {CAT}.gold.dim_seller AS
SELECT seller_id, seller_city, seller_state
FROM {CAT}.silver.sellers
""")
print("dims created")

# COMMAND ----------
# KPI aggregate for BI
spark.sql(f"""
CREATE OR REPLACE TABLE {CAT}.gold.agg_monthly_kpis AS
SELECT
    DATE_TRUNC('MONTH', order_purchase_ts) AS order_month,
    COUNT(DISTINCT order_id)  AS orders,
    SUM(gross_value)          AS revenue,
    AVG(delivery_days)        AS avg_delivery_days,
    AVG(on_time_flag) * 100   AS on_time_pct
FROM {CAT}.gold.fact_sales
GROUP BY 1
ORDER BY 1
""")
print("gold.agg_monthly_kpis:", spark.table(f"{CAT}.gold.agg_monthly_kpis").count())

# COMMAND ----------
# # Review sentiment KPI — guarded, safe cast on review_score
# cols = spark.table(f"{CAT}.silver.reviews_enriched").columns
# if "sentiment" in cols and "issue_category" in cols:
#     spark.sql(f"""
#     CREATE OR REPLACE TABLE {CAT}.gold.agg_review_sentiment AS
#     SELECT
#         CAST(issue_category AS STRING) AS issue_category,
#         CAST(sentiment AS STRING)      AS sentiment,
#         COUNT(*)                              AS review_count,
#         AVG(try_cast(review_score AS DOUBLE)) AS avg_score
#     FROM {CAT}.silver.reviews_enriched
#     GROUP BY CAST(issue_category AS STRING), CAST(sentiment AS STRING)
#     ORDER BY review_count DESC
#     """)
#     print("gold.agg_review_sentiment:", spark.table(f"{CAT}.gold.agg_review_sentiment").count())
# else:
#     print("SKIP agg_review_sentiment — AI columns not present")

# COMMAND ----------
# Final verification
display(spark.table(f"{CAT}.gold.agg_monthly_kpis").orderBy("order_month"))