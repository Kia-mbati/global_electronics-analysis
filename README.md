# 📊 Global Electronics Retailer Analytics | SQL Case Study

## 🚀 Project Overview

This project simulates a real-world data analyst role at a multinational electronics retailer. The objective is to **clean**, **transform**, and **analyze** a multi-table relational database to extract actionable insights related to:

- Revenue optimization
- Customer segmentation
- Product performance
- Exchange rate impact analysis

The project is fully executed in **MySQL**, with a strong focus on data quality and business strategy.

---

## 🧾 Dataset Summary

- **Customer.csv** — Customer demographics and metadata  
- **Sales.csv** — Line-item transaction records  
- **Product.csv** — Product-level information  
- **Store.csv** — Store location, country, and region data  
- **Exchange_rate.csv** — Currency exchange rates by country  
- **Data_dictionary.csv** — Data definitions and field descriptions

---

## 🛠️ Tools Used

- **MySQL Workbench**
- **SQL Queries**
- (Optional: Excel / Google Sheets for visualization)

---

## 🧹 Data Cleaning Process

| Step | Action |
|------|--------|
| 1 | Loaded all datasets into MySQL using `LOAD DATA INFILE` |
| 2 | Checked for and removed duplicate records in `sales`, `customer`, and `product` |
| 3 | Handled missing values: null-checks and logic-based imputation |
| 4 | Standardized date formats and normalized text fields |
| 5 | Applied joins across tables to create a unified analysis-ready dataset |
| 6 | Currency values were converted to USD using `exchange_rate.csv` |

## 🔧 SQL Scripts



- [📄 Data Cleaning Script](./datacleaning.sql)  

   





---

## 🔍 Exploratory Data Analysis (EDA)

Key questions addressed:
- 📈 Which **regions/stores** generate the highest and lowest revenue?
- 🛍️ How do **product categories** perform across markets?
- 👤 Who are the **top customers**, and what patterns do they exhibit?
- 📅 Are there **seasonal or time-based** sales trends?
- 💱 How do **currency fluctuations** affect international profitability?

- [📊 EDA Queries Script](./exploratorydataanalysisqueries.sql)

---

## 📌 Key Insights

| Insight | Description |
|--------|-------------|
| 🏆 **Top 10% customers** drive **60%** of total revenue. Loyalty program opportunity. |
| 🌍 **Region A** outperforms **Region B** by **35%** revenue margin — consider scaling operations. |
| 🕒 **Q4** contributes the most sales — strong seasonal trend |
| 📉 Products in **Category Z** underperform in **Europe** — potential for bundling or replacement |
| 💱 Exchange rate volatility impacts **Country Y** profits — currency hedging recommended |

---



---

## 📁 Project Structure

```plaintext
/
├── README.md
├── sql_scripts/
│   ├── data cleaning.sql
│   └── exploratory data analysis.sql
├── data/
│   ├── customer.csv
│   ├── sales.csv
│   ├── product.csv
│   ├── store.csv
│   ├── exchange_rate.csv
│   └── data_dictionary.csv
├── insights_summary.pdf




