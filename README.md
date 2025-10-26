# 🛒 E-commerce Sales Analysis (SQL + Power BI)

## 📌 Project Overview
This project focuses on analyzing an E-commerce dataset to uncover key business insights and improve data-driven decision-making.  
Data cleaning, transformation, and analysis were performed using **Microsoft SQL Server**, and an interactive dashboard was built in **Power BI** for visualization.
## 📁 Data Source
This project uses the publicly-available e-commerce dataset from Kaggle:  
[E-Commerce Data on Kaggle](https://www.kaggle.com/datasets/carrie1/ecommerce-data)  
Please download the dataset from Kaggle and place the file in the `Dataset/` folder before running the analysis.

---

## 🧠 Objectives
- Clean and prepare raw transactional data using SQL.  
- Identify key business metrics: Total Revenue, Orders, Profit Margin, and Top Products.  
- Visualize sales trends, customer insights, and regional performance in Power BI.  
- Deliver actionable insights to help improve sales strategy and performance tracking.

---

## 🧩 Tools & Technologies
- **SQL Server Management Studio (SSMS)** – for data cleaning and analysis  
- **Power BI Desktop** – for building dashboards and visual reports  
- **DAX (Data Analysis Expressions)** – for creating KPIs and calculations  
- **Excel** – for initial data exploration and validation  

---

## 🧹 Data Cleaning (SQL)
Steps performed:
1. Removed null and invalid entries for `CustomerID`, `Quantity`, and `UnitPrice`.
2. Filtered out canceled transactions (`InvoiceNo` starting with 'C').
3. Ensured data types were correctly set for `InvoiceDate` and `InvoiceNo`.

```sql
SELECT *
INTO clean_orders
FROM raw_orders
WHERE CustomerID IS NOT NULL


## 📁 Data Source
This project uses the publicly-available e-commerce dataset from Kaggle:  
[E-Commerce Data on Kaggle](https://www.kaggle.com/datasets/carrie1/ecommerce-data)  
Please download the dataset from Kaggle and place the file in the `Dataset/` folder before running the analysis.

  AND Quantity IS NOT NULL AND Quantity > 0
  AND UnitPrice IS NOT NULL AND UnitPrice > 0
  AND InvoiceNo NOT LIKE 'C%';



