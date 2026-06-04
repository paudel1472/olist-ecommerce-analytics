# Olist Brazilian E-Commerce Analytics Pipeline & Warehouse

## 📌 Project Overview
This project implements an end-to-end analytics engineering pipeline designed to ingest, clean, and model complex relational e-commerce data from the Brazilian Public E-Commerce dataset by Olist. The system processes highly fragmented transactional tables, establishes rigid data quality constraints, and structures a high-performance dimensional warehouse using a Star Schema optimization matrix.

## 🛠️ Tech Stack & Libraries
* **Language & Orchestration:** Python, SQL
* **Data Transformation Engine:** dbt (Data Build Tool)
* **Storage & Local Warehousing:** DuckDB
* **Analytics Layer:** Aggregated Business Intelligence KPIs

## ⚙️ Analytics Engineering Pipeline
1. **Data Ingestion:** Loads raw, multi-table relational CSV streams tracking customers, orders, payments, reviews, and geolocation data into an optimized database engine via Python.
2. **Modular Transformations (dbt):** Implements staging layers to isolate raw inputs, strip structural text anomalies, normalize geographic variables, and handle timestamp mismatches across order lifecycles.
3. **Dimensional Modeling:** Converts operational tables into a structured **Star Schema** optimization layer, mapping data arrays into dedicated **Fact** tables (Orders, Financial Items) and **Dimension** tables (Products, Customers, Sellers) to accelerate analytical query speeds.
4. **Data Quality Assertions:** Deploys strict schema tests (uniqueness, non-null assertions, and relational integrity constraints) across primary identifiers to prevent pipeline breakage.

## 📈 Analytical Deliverables
* **Operational Performance:** Built materializations optimizing calculations for core corporate metrics, including customer lifetime value (CLV), delivery transit latencies, geographic sales distributions, and payment method behavior.
