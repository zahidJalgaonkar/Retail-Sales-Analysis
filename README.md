# 📊 Retail Sales Analysis

## 💡 Project Overview

This project analyzes retail sales data to understand **customer purchasing behavior** and **business performance**. Using **Python, SQL, and Power BI**, the data is cleaned, analyzed, and visualized to uncover trends, top product categories, key customer segments, and peak sales periods. The insights help support **data-driven decisions** to improve revenue and profitability.

---

## 📁 Repository Structure

```
Retail-Sales-Analysis/
├── Retail_Sales_Analysis.csv            # Cleaned dataset
├── Retail_sale_query.sql                # SQL analysis queries
├── Retail_Sale_Dashboard.pbix           # Power BI dashboard
├── Retail_Sales_Python_Script.docx      # Python data cleaning & EDA
├── Retail_Sales_Business_Problem_Statement.docx  # Project problem statement/report
├── Retail_sale_dashboard_SS.png         # Dashboard screenshot
└── Retail Sale Analysis report.docx     # Final report
```

---

## 📊 Analysis Workflow

### 1. **Data Cleaning & Preparation**

* Loaded sales dataset and explored structure.
* Handled missing data (mean imputation for Age; removed critical missing rows).
* Standardized column names and validated data quality.
* Cleaned dataset exported for SQL and visualization.

### 2. **Exploratory Data Analysis (Python)**

* Used Python (Pandas) for:

  * Data exploration (`df.info()`, `df.describe()`)
  * Identifying patterns and distributions
  * Cleaning & exporting data for further analysis

### 3. **SQL Analysis & Insights**

Performed comprehensive SQL analysis to derive business insights:

#### 🔹 Age Group Analysis

* Analyzed revenue & profit contributions by age bucket.

#### 🔹 Gender & Category Analysis

* Explored revenue distribution of product categories by gender.

#### 🔹 Peak Sales Time Analysis

* Identified peak revenue hours and loss-making periods.

#### 🔹 Monthly Sales Trend

* Assessed month-wise sales and profit trends.

#### 🔹 Category Performance Evaluation

* Calculated total revenue, total profit, and profit margins by category.

#### 🔹 Business KPI Summary

* Measured overall revenue, cost, profit, and profit margin.
* Identified top & bottom product categories.
* Assessed customer retention and repeat customer percentage.
* Ranked top 10 high-value customers.
* Determined month-wise performance and preferred categories by gender.

---

## 📈 Dashboard (Power BI)

The Power BI dashboard visualizes all key insights, including:

* Sales performance charts
* Age group and gender segmentation visuals
* Peak sales time analysis
* Monthly trends
* Profitability by category
  *(Screenshot included in repository)*

---

## 🛠️ Technologies Used

| Tool         | Purpose                             |
| ------------ | ----------------------------------- |
| **Python**   | Data cleaning, EDA                  |
| **SQL**      | Data querying & analytical insights |
| **Power BI** | Dashboard visualization             |
| **CSV**      | Cleaned dataset                     |

---

## 📌 Key Insights & Business Recommendations

* 🎯 Boost subscriptions with exclusive benefits
* 📈 Implement loyalty programs for repeat buyers
* 💰 Balance discount strategy to maintain healthy profit margins
* 🛍️ Highlight and market top-selling categories
* 👥 Target marketing for high-revenue age groups and peak hours

---

## 📝 How to Use This Repository

1. **Download the CSV**
   Load it into Python or SQL tool for exploration.

2. **Run SQL Analysis**
   Execute the queries in `Retail_sale_query.sql` using a SQL client.

3. **Open the Dashboard**
   Open `Retail_Sale_Dashboard.pbix` in Power BI Desktop to view insights.

4. **Explore Scripts & Report**
   Use the provided Python script and project report for deeper understanding.

---

## 📌 License

This project is for **educational and portfolio purposes**.

---

⭐ *Feel free to fork, star, and share!*
