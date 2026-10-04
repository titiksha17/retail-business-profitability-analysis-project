# Retail Business Performance & Profitability Analysis

- Project Phase - Elevate Labs Data Analyst Internship
- Dataset: Retail Store Inventory dataset (Kaggle, 73,100 rows)
- Tools: SQL (via Python/SQLite), Python (Pandas, Seaborn), Power BI

## What's in this repo
- retail_store_inventory_data.csv - the full dataset
- [project].ipynb - SQL analysis (via SQLite) and Python correlation analysis
- retail_analysis_queries.sql - the core SQL queries
- retail_dashboard.pbix - interactive Power BI dashboard
- [retail].png - dashboard screenshot
- Retail_Profitability_Report.pdf - final 1-2 page project report
- README.md - this file

## What I did

I analyzed a 73,100-row retail dataset to find which product categories are actually
profitable, how inventory turnover relates to profit, and whether procurement decisions
track actual demand.

Since the dataset has no cost data, I estimated profit using documented, category-specific
assumed margins (Groceries 20%, Electronics 25%, Furniture 30%, Toys 35%, Clothing 40%).

Using SQL (run via Python/SQLite against the full dataset, not a sample), I calculated
revenue and profit by category, investigated inventory patterns, and found that Units
Ordered runs 19-20% below Units Sold in every category with no real correlation to
demand. In Python, I built a full correlation matrix and a days-of-supply metric,
finding a strong negative relationship between inventory turnover and profit
(Spearman -0.65). I then built an interactive Power BI dashboard (lavender theme) with
KPI cards, Region/Category/Seasonality slicers, and four charts visualizing each finding.

## Key findings
- Revenue is nearly equal across all 5 categories (~Rs. 110M each), but profit ranges
  from Rs. 22M (Groceries) to Rs. 44M (Clothing) - revenue alone is a misleading metric.
- Units Ordered shows ~0 correlation with actual demand, running consistently 19-20%
  below Units Sold across every category - a company-wide procurement issue, not a
  single-category problem.
- Slower-moving inventory (higher days-of-supply) captures significantly less profit,
  a pattern consistent across all five categories.

## Limitations
Profit figures are estimates based on assumed margins, not real cost data. The
days-of-supply/profit relationship is partly mechanical since Units Sold contributes to
both variables. Per-product inventory levels appeared near-randomly distributed, limiting
SKU-level overstock analysis. See the full report PDF for complete details.
