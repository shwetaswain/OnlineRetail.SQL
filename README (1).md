# 🧠 Customer Segmentation using RFM Analysis (SQL)

This project demonstrates how to perform **Customer Segmentation** using the **RFM (Recency, Frequency, Monetary)** model with pure SQL on the [Online Retail II dataset](https://archive.ics.uci.edu/ml/datasets/Online+Retail+II). The goal is to identify different customer personas (e.g., Champions, Loyal Customers, At Risk, etc.) based on their purchasing behavior.

---

## 📌 Objective

To segment customers based on their purchase history by:
- Calculating **Recency**: How recently a customer purchased
- Calculating **Frequency**: How often a customer purchased
- Calculating **Monetary**: How much the customer spent

These metrics are scored and used to assign customer **segments** for targeted marketing or retention strategies.

---

## 🛠 Tools Used

- **SQL (MySQL Workbench)**
- Dataset: `Online Retail II`
- Visualization: (Planned) Power BI

---

## 📊 Steps Performed

1. **Data Cleaning**
   - Removed NULL `CustomerID`s
   - Filtered out canceled orders (negative quantities)
   - Removed rows with invalid prices

2. **RFM Calculation**
   - Chose a reference date (e.g., 2011-12-10)
   - Aggregated Recency, Frequency, and Monetary value per customer

3. **RFM Scoring**
   - Used SQL `NTILE(5)` window function to assign scores from 1 to 5

4. **Customer Segmentation**
   - Used CASE logic to classify customers into segments such as:
     - Champions
     - Loyal Customers
     - Frequent Shoppers
     - Recent Customers
     - Big Spenders
     - At Risk

5. **Analysis Output**
   - Count of customers per segment
   - Sorted segments by population

---

## 📂 Files Included

| File Name               | Description                                |
|------------------------|--------------------------------------------|
| `customer_segmentation.sql` | Contains all SQL queries used for this project |
| `rfm_results.png`       | Screenshot of final segmentation results  |
| `powerbi_visuals.pbix` (planned) | Visualizations of segments (to be added)  |

---

## ✅ Result Summary

Identified key customer segments to help the business:
- Focus retention efforts on “Champions” and “Loyal Customers”
- Target “At Risk” and “Big Spenders” with special offers
- Understand overall customer distribution
