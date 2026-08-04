# UrbanCart Retail - Capstone Data Pack

Source data for Final Assessment **EDMDC/FA/01, Part B**.
Generated with seed `42`, scale `1.0`.

This data is synthetic and deliberately imperfect. Identifying and handling the
defects is part of the assessment - do not assume any file is clean.

## Files

| File | Rows | Notes |
|---|---|---|
| `customers.csv` | 25,000 | Customer master. Duplicates, mixed date formats, inconsistent city spellings, invalid emails and phones. |
| `orders.csv` | 120,060 | Order header. `store_id` is null for Web and App channels by design. |
| `order_items.csv` | 380,000 | Line items. Contains negative quantities and price outliers. |
| `products.csv` | 12,540 | Product catalogue. Roughly 30% of rows have no `category` - Task 6 fills these. |
| `stores.csv` | 42 | Store master. Clean. |
| `returns.csv` | 9,800 | Returns with free-text reasons requiring standardisation. |
| `web_events.json` | 195,452 events across 30,000 sessions | Nested clickstream JSON. |

## Column reference

**customers.csv** - customer_id, full_name, email, phone, city, loyalty_tier, signup_date
**orders.csv** - order_id, customer_id, store_id, channel, order_ts, order_status, currency, payment_mode
**order_items.csv** - order_item_id, order_id, sku, quantity, unit_price, discount_amount
**products.csv** - sku, category, sub_category, brand, product_name, cost_price, mrp, launch_date, is_active
**stores.csv** - store_id, store_name, city, state, store_format, floor_area_sqft, open_date
**returns.csv** - return_id, order_id, sku, return_date, return_reason, refund_amount, refund_status
**web_events.json** - array of session objects: session_id, session_start, user{customer_id, is_logged_in, device{type, os, app_version}}, geo{city, country}, utm{source, campaign}, events[{event_id, event_ts, event_type, page, sku?, search_term?}]

## Currency conversion (Task 4)

Around 8% of orders are transacted in USD or SGD and must be converted to INR
before any revenue figure is reported.

Use the Frankfurter API - free, open source, no API key required.

    GET https://api.frankfurter.dev/v1/latest?base=USD&symbols=INR
    GET https://api.frankfurter.dev/v1/2025-06-14?base=USD&symbols=INR
    GET https://api.frankfurter.dev/v1/2025-06-01..2025-06-30?base=USD&symbols=INR

Three things to handle, all of which carry marks:

1. **Convert at the order date, not today's rate.** A revenue figure that moves
   every time the pipeline runs is not auditable.
2. **The API returns nothing for weekends and public holidays** - rates are
   published on business days only. Decide and document your rule (previous
   business day is the usual choice).
3. **An unsupported currency code returns HTTP 404.** Your code must handle a
   non-200 response rather than crash, and should retry transient failures.

Commit a Postman collection evidencing at least one successful call.

## Reproducibility

    python generate_urbancart.py --seed 42

regenerates this pack byte-for-byte. A different seed produces a
structurally identical pack with different values - use one seed per batch.
