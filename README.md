# 🛒 Retail Analytics Dashboard

An end-to-end Retail Analytics project that transforms raw retail transaction data into meaningful business insights using **Python**, **MySQL**, and **Power BI**.

This project demonstrates the complete data analytics workflow—from data cleaning and exploratory analysis to SQL-based business analysis and interactive dashboard development.

---

# 📌 Project Overview

The objective of this project is to analyze an online retail dataset to uncover sales trends, customer purchasing behavior, product performance, and country-wise revenue.

The project includes:

- Data Cleaning using Python
- Exploratory Data Analysis (EDA)
- Customer Segmentation using RFM Analysis
- SQL Business Analysis
- Interactive Power BI Dashboard

---

# 📂 Dataset

**Dataset:** Online Retail Dataset

The original dataset is not included because of its size.

Download the Online Retail II dataset and place it in this folder before running the project.

The dataset contains transactional information such as:

- Invoice Number
- Product Code
- Product Description
- Quantity
- Invoice Date
- Unit Price
- Customer ID
- Country

Additional columns created during preprocessing:

- Total Price
- Month
- Day Name

---

# 🛠️ Tools & Technologies

| Tool | Purpose |
|------|---------|
| Python | Data Cleaning & Analysis |
| Pandas | Data Manipulation |
| NumPy | Numerical Operations |
| Matplotlib | Data Visualization |
| Seaborn | Exploratory Visualization |
| MySQL | Business Analysis |
| Power BI | Dashboard Development |
| DAX | Measures & KPIs |
| Power Query | Data Transformation |

---

# 🐍 Python Analysis

Performed data preprocessing and exploratory analysis using Python.

### Data Cleaning

- Removed duplicate records
- Removed cancelled transactions
- Handled missing values
- Converted data types
- Created TotalPrice column
- Extracted Month and Day Name

### Exploratory Data Analysis

- Revenue Trends
- Monthly Sales Analysis
- Country-wise Revenue
- Product Performance
- Customer Purchase Behavior

### RFM Analysis

Customers were segmented using:

- **Recency**
- **Frequency**
- **Monetary**

Customer Segments:

- Champions
- Loyal Customers
- Potential Loyalists
- Needs Attention
- At Risk
- Lost Customers

---

# 🗄️ SQL Analysis

Business analysis was performed using MySQL.

### Dataset Overview

- Total Records
- Unique Customers
- Unique Products
- Dataset Date Range

### Data Quality Checks

- Missing Customer IDs
- Missing Product Descriptions
- Returned Orders
- Duplicate Invoice Numbers

### Sales Analysis

- Total Revenue
- Average Transaction Value
- Highest & Lowest Transactions
- Total Quantity Sold

### Business Analysis

- Monthly Revenue
- Weekday Revenue
- Country-wise Revenue
- Top Customers
- Top Products
- Invoice Analysis
- Window Functions
- Business Questions

---

# 📊 Power BI Dashboard

The project contains **2 interactive dashboard pages**.

## 📈 Page 1 – Retail Sales Analytics

Features:

- KPI Cards
- Monthly Revenue Trend
- Revenue by Country
- Revenue by Weekday
- Top Products
- Top Customers
- Interactive Filters

---

## 👥 Page 2 – Customer Analytics

Features:

- Customer Segment Distribution
- Revenue by Customer Segment
- Customer Value Distribution
- Customer Segment Summary
- KPI Cards
- Interactive Navigation

---

# 📸 Dashboard Preview

## Retail Sales Dashboard

> Replace with screenshot

```
![Retail Sales Dashboard](dashboard/Sales_Dashboard.png)
```

---

## Customer Analytics Dashboard

> Replace with screenshot

```
![Customer Analytics Dashboard](dashboard/Customer_Dashboard.png)
```

---

# 📈 Key Insights

### Sales Insights

- The United Kingdom generated the highest revenue.
- Sales showed clear monthly trends.
- A small number of products contributed significantly to total sales.

### Customer Insights

- Champions generated the highest revenue.
- Loyal Customers formed the second most valuable customer group.
- Lost Customers contributed the least revenue.
- High-frequency customers produced significantly greater revenue.

---

# 📁 Project Structure

```
Retail-Analytics-Project
│
├── dashboard/
│   ├── Sales_Dashboard.png
│   ├── Customer_Dashboard.png
│   
│
├── powerbi/
│   └── Retail_Analytics.pbix
│
├── python/
│   └── Data_Cleaning.ipynb
│   └── RFM_Analysis.ipynb
│
├── dsql/
│   ├── RetailAnalytics.sql
│
└── README.md
```

---

# 🎯 Skills Demonstrated

- Data Cleaning
- Exploratory Data Analysis
- Customer Segmentation (RFM)
- SQL Querying
- Window Functions
- Data Visualization
- Dashboard Design
- DAX
- Power Query
- Business Analytics

---

⭐ If you found this project helpful, consider giving it a star!
