import duckdb
import pandas as pd

# Connect to the local production warehouse file
conn = duckdb.connect('olist_warehouse.db')

print("\n📊 ==========================================================================")
print("💼              OLIST E-COMMERCE EXECUTIVE PERFORMANCE REPORT               ")
print("==============================================================================")

# 1. Fetch data from your verified dbt production table
query = "SELECT * FROM monthly_revenue_kpis WHERE order_month IS NOT NULL ORDER BY order_month;"
df = conn.execute(query).df()

# 2. Format date column into readable Year-Month text
df['order_month'] = pd.to_datetime(df['order_month']).dt.strftime("%Y-%B")

# 3. Aligned column names to 'mom_growth_pct' to match your dbt model contract
df['mom_growth_pct'] = df['mom_growth_pct'].apply(lambda x: f"{x:+.2f}%" if pd.notnull(x) else "Initial Month")
df['gross_revenue'] = df['gross_revenue'].apply(lambda x: f"${x:,.2f}" if pd.notnull(x) else "$0.00")
df['average_order_value'] = df['average_order_value'].apply(lambda x: f"${x:,.2f}" if pd.notnull(x) else "$0.00")

# 4. Print the clean financial summary matrix using 'mom_growth_pct'
print(df[['order_month', 'total_orders', 'gross_revenue', 'average_order_value', 'mom_growth_pct']].to_string(index=False))
print("==============================================================================\n")

conn.close()