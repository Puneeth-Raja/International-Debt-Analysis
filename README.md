# 🌍 International Debt Analysis System

An end-to-end Data Analytics project that analyzes global debt statistics published by the World Bank. The project involves data collection, preprocessing, exploratory data analysis (EDA), SQL database integration, and interactive dashboards using Power BI.

---

# 📌 Project Overview

International debt data contains information about borrowings, repayments, interest payments, and other financial indicators for countries across the world. Since the data is available in raw CSV format, it requires preprocessing and transformation before meaningful analysis can be performed.

This project builds a complete analytics pipeline to:

- Clean and preprocess international debt data
- Perform exploratory data analysis (EDA)
- Store processed data in MySQL
- Execute SQL analytical queries
- Create interactive dashboards and reports
- Generate meaningful business insights

---

# 🎯 Project Objectives

- Data Collection
- Data Cleaning and Preprocessing
- Exploratory Data Analysis (EDA)
- Database Design and SQL Integration
- Data Visualization and Dashboard Development
- Insight Generation and Reporting

---

# 🛠️ Technologies Used

## Programming
- Python
- Pandas
- NumPy

## Database
- MySQL
- SQL

## Visualization
- Power BI
- Matplotlib
- Seaborn
- Plotly

## Tools
- Jupyter Notebook
- MySQL Workbench
- Git & GitHub

---

# 📂 Project Structure

```text
International Debt Analysis System
│
├── Data
│   ├── Country-Series - Metadata.csv
│   ├── IDS_ALLCountries_Data.csv
│   ├── IDS_CountryMetaData.csv
│   ├── IDS_FootNoteMetaData.csv
│   └── IDS_SeriesMetaData.csv
│
├── Notebooks
│   ├── Data_Collection.ipynb
│   ├── Data_Preprocessing.ipynb
│   └── EDA.ipynb
│
├── SQL
│   ├── database_setup.py
│   └── load.py
│
├── output
│   ├── Cleaned_Data
│   │   ├── Country_Details.xls
│   │   ├── Debt_Data.xls
│   │   └── Indicator_Details.xls
│   ├── Queries.sql
│   ├── International_Debt_Analysis_Dashboard.pbix
│   └── International_Debt_Analysis_Dashboard.pdf
│
├── requirements.txt
└── README.md
```

---

# 📊 Dataset Information

Dataset: World Bank International Debt Statistics

The dataset contains information related to:

- Country-wise debt
- Debt indicators
- Income groups
- Lending categories
- Regional information
- Debt values and financial statistics

---

# 🗄️ Database Design

## Countries Table

| Column |
|---------|
| country_code |
| country_name |
| income_group |
| region |
| lending_category |
| is_hipc |

## Debt Data Table

| Column |
|---------|
| country_code |
| series_code |
| year |
| value |

## Indicators Table

| Column |
|---------|
| series_code |
| indicator_name |

---

# 🔗 Database Relationships

- countries.country_code → debt_data.country_code
- indicators.series_code → debt_data.series_code

---

# 🔍 Exploratory Data Analysis (EDA)

The project performs:

- Country-wise debt distribution
- Top 10 highest debt countries
- Top 10 lowest debt countries
- Indicator-wise debt analysis
- Debt by lending category
- Debt by income group
- Regional debt distribution
- Statistical summaries and comparisons

---

# 📈 Dashboard Features

## Power BI Dashboard

- KPI Cards
- Total Global Debt
- Total Countries
- Total Indicators
- Top 10 Highest Debt Countries
- Top 10 Lowest Debt Countries
- Debt Distribution by Lending Category
- Debt Distribution by Income Group
- Country-wise Debt Analysis
- Interactive Filters and Slicers

---

# 📊 SQL Analysis

The project contains 30 analytical SQL queries covering:

- Basic SQL Queries
- Aggregate Functions
- GROUP BY Analysis
- Window Functions
- Ranking Functions
- Views
- Percentage Analysis
- Country and Indicator Analysis

---

# 📌 Key Insights

- Identified countries with the highest debt burden.
- Identified countries with the lowest debt burden.
- Determined the most significant debt indicators.
- Compared debt across regions and lending categories.
- Generated insights from global debt statistics.

---

# 🚀 How to Run the Project

## Clone Repository

```bash
git clone https://github.com/Puneeth-Raja/International-Debt-Analysis.git
```

## Install Dependencies

```bash
pip install -r requirements.txt
```

## Run Jupyter Notebook

```bash
jupyter notebook
```

---

# 📁 Project Deliverables

✅ Raw Dataset

✅ Cleaned Dataset

✅ EDA Notebooks

✅ MySQL Database Integration

✅ SQL Analytical Queries

✅ Power BI Dashboard

✅ Dashboard PDF

✅ Final Documentation

---

# 🎓 Skills Gained

- Python Programming
- Data Cleaning
- Data Preprocessing
- Exploratory Data Analysis
- SQL & Database Management
- Data Visualization
- Dashboard Development
- Financial Data Analysis
- End-to-End Data Analytics Pipeline

---

# 👨‍💻 Author

**Puneeth K**