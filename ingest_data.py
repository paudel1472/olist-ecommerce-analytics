import duckdb
import os

print("🚀 Starting Data Ingestion Layer...")

# Connect to the database file (it will be created automatically)
db_conn = duckdb.connect('olist_warehouse.db')
print("✅ Connected to DuckDB")

data_path = "./raw_data"

tables_to_load = {
    "raw_orders": "olist_orders_dataset.csv",
    "raw_order_items": "olist_order_items_dataset.csv",
    "raw_order_payments": "olist_order_payments_dataset.csv"
}

for table_name, csv_file in tables_to_load.items():
    full_path = os.path.join(data_path, csv_file)

    if os.path.exists(full_path):
        print(f"📥 Ingesting {csv_file} into {table_name}...")
        query = f"CREATE OR REPLACE TABLE {table_name} AS SELECT * FROM read_csv_auto('{full_path}')"
        db_conn.execute(query)
    else:
        print(f"⚠️ File not found: {full_path}")

print("\n🔍 Verification:")
tables = db_conn.execute("SHOW TABLES").fetchall()
for t in tables:
    row_count = db_conn.execute(f"SELECT COUNT(*) FROM {t[0]}").fetchone()[0]
    print(f"  ├── Table: {t[0]:<20} | Records: {row_count:,}")

db_conn.close()
print("\n🎉 Raw Ingestion Complete!")