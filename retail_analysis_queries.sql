-- Retail Business Performance & Profitability Analysis
-- SQL queries run via Python (sqlite3) against the full 73,100-row dataset
-- Note: profit figures use assumed category margins (documented in report),
-- since the raw dataset has no cost/COGS column

-- Query 1: Profit margin by category
SELECT
    Category,
    ROUND(SUM(Price * "Units Sold"), 2) AS total_revenue,
    ROUND(SUM(
        Price * "Units Sold" *
        CASE
            WHEN Category = 'Groceries' THEN 0.20
            WHEN Category = 'Clothing' THEN 0.40
            WHEN Category = 'Electronics' THEN 0.25
            WHEN Category = 'Furniture' THEN 0.30
            WHEN Category = 'Toys' THEN 0.35
            ELSE 0.30
        END
    ), 2) AS estimated_profit,
    COUNT(*) AS num_transactions
FROM sales
GROUP BY Category
ORDER BY estimated_profit DESC;

-- Query 2: Product-level inventory check
-- (revealed inventory levels are near-uniformly distributed across products -
--  documented as a data limitation, not used for per-product overstock claims)
SELECT
    "Product ID",
    COUNT(*) AS num_records,
    ROUND(AVG("Inventory Level"), 1) AS avg_inventory,
    ROUND(AVG("Units Sold"), 1) AS avg_units_sold
FROM sales
GROUP BY "Product ID";

-- Query 3: Does Holiday/Promotion affect sales?
SELECT
    "Holiday/Promotion",
    ROUND(AVG("Units Sold"), 1) AS avg_units_sold,
    ROUND(AVG(Discount), 1) AS avg_discount
FROM sales
GROUP BY "Holiday/Promotion";

-- Query 4: Does Seasonality affect sales?
SELECT
    Seasonality,
    ROUND(AVG("Units Sold"), 1) AS avg_units_sold,
    ROUND(SUM(Price * "Units Sold"), 0) AS total_revenue
FROM sales
GROUP BY Seasonality
ORDER BY avg_units_sold DESC;

-- Query 5: Ordering gap by category
-- Core finding: units ordered consistently ~19-20% below units sold across
-- every category, with ~0 correlation between Units Ordered and demand -
-- procurement is not demand-driven
SELECT
    Category,
    ROUND(AVG("Units Ordered"), 1) AS avg_units_ordered,
    ROUND(AVG("Units Sold"), 1) AS avg_units_sold,
    ROUND(AVG("Units Ordered") - AVG("Units Sold"), 1) AS ordering_gap
FROM sales
GROUP BY Category
ORDER BY ordering_gap DESC;