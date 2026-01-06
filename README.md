# 🧀 Cheese Production Analysis (SQL + Tableau)

## 📌 Project Overview

This project analyzes **U.S. cheese production trends** using SQL for data preparation and Tableau for visualization.  
The goal is to transform raw production data into clear, actionable insights through a complete **end-to-end analytics workflow**, from data cleaning to storytelling.

The project is designed as a **portfolio-ready case study**, demonstrating practical data analytics skills applicable to real-world business and policy contexts.

📄 **Executive summary and final conclusions** are available in the [`/docs`](./docs) folder for a high-level overview of findings and takeaways.

------------------------------------------------------------------------

## 🎯 Business Problem

Cheese production is a key component of the U.S. dairy industry, yet production trends, geographic concentration, and long-term growth patterns are not always immediately clear from raw datasets.

This project aims to answer:

- How has U.S. cheese production evolved over time?
- Which states dominate U.S. cheese production?
- Is growth consistent across periods or concentrated in recent years?

------------------------------------------------------------------------

## ❓ Analytical Questions

1. What is the overall trend of U.S. cheese production over time?
2. How is cheese production distributed across states?
3. Which states are the top producers?
4. How does total production compare between different multi-year periods?

------------------------------------------------------------------------

## 🛠️ Tools & Technologies

- **SQL (SQLite / DBeaver)** – data cleaning, validation, joins, aggregations  
- **Tableau** – data visualization and dashboard creation  
- **CSV** – final analytics-ready dataset  
- **GitHub** – project versioning and documentation  

------------------------------------------------------------------------

## 🔄 Data Preparation & Cleaning

Key data processing steps performed in SQL:

- Removed formatting issues (e.g. commas in numeric values)
- Converted data types for accurate aggregation
- Joined production data with `state_lookup` table to obtain full state names
- Filtered invalid or incomplete year rows
- Validated aggregates using SQL validation checks

The final output is a **single consolidated dataset** optimized for Tableau analysis.

The SQL pipeline is designed to be reproducible and includes **post-creation validation checks** to ensure data integrity.

The SQL workflow is intentionally split into two scripts:

- `cheese_cleaning.sql`  
  Reproducible data preparation pipeline that:
  - Cleans and standardizes raw production values
  - Creates analysis-ready tables
  - Applies business logic filters
  - Performs core data validation checks

- `cheese_exploratory_analysis.sql`  
  Exploratory and analytical SQL queries used to:
  - Validate assumptions
  - Answer the project’s core analytical questions
  - Support insights later visualized in Tableau

This separation reflects real-world analytics workflows, where reproducible pipelines are kept separate from exploratory analysis.

------------------------------------------------------------------------

## 📊 Key Findings

### 1. Long-term Growth

U.S. cheese production shows a **clear upward trend** over time.

- **2015–2018:** ~49.69 billion lbs  
- **2019–2022:** ~54.22 billion lbs  

This indicates sustained growth rather than short-term fluctuation.

### 2. Geographic Concentration

Production is highly concentrated in a small number of states, which consistently dominate national output.

### 3. Stability Over Time

While seasonal variation exists, overall production remains stable, making the sector suitable for long-term forecasting and planning.

### 4. Data Reliability

After cleaning and validation, the dataset supports reliable and reproducible analysis.

------------------------------------------------------------------------

## ⚠️ Data Limitations & Considerations

While the dataset supports meaningful trend and comparative analysis, several limitations should be considered:

### 1. Change in Time Granularity (Pre-1990 vs Post-1990)

From **1970 to 1989**, cheese production was reported as a **single annual record** per state.  
Starting in **1990**, the reporting methodology changed to include **monthly records (JAN–DEC)** in addition to an annual `YEAR` record.

Without adjustment, this results in **duplicate production values** for post-1990 years.

**Mitigation:**  
For years 1990 and onward, annual (`YEAR`) records were excluded and only monthly data was used in aggregation.

---

### 2. Missing State Identifiers

Some production records did not contain a valid `state_ANSI` code and therefore could not be linked to a specific U.S. state.

**Mitigation:**  
These records were retained and grouped under **`Other/Unknown States`** to preserve total production volume and avoid data loss.

---

### 3. External State Lookup Dependency

State names were not available in the main dataset and were obtained by joining an external `state_lookup` table.

**Mitigation:**  
A `LEFT JOIN` strategy and `COALESCE` logic were used to handle missing or unmatched state codes.

---

### 4. Limited Contextual Variables

The dataset focuses exclusively on **total production volume** and does not include:
- number of production facilities
- population or consumption data
- efficiency or productivity metrics
- regulatory or economic factors

As a result, the analysis describes **what changed**, but not **why it changed**.

------------------------------------------------------------------------

## 📈 Tableau Dashboard

The Tableau dashboard presents:

- Total production KPIs  
- Production trends over time  
- State-level rankings  
- Comparative analysis between multi-year periods  

📌 Tableau Public Dashboard: *https://public.tableau.com/app/profile/franco.palomeque/viz/U_S_CheeseProductionHistoricalTrendsCOVIDComparison/ImpactofCOVID-19onU_S_CheeseProduction#1*

------------------------------------------------------------------------

## 🚀 Next Steps

Potential extensions of this project include:

- Year-over-year growth analysis by state  
- Time-series forecasting  
- Efficiency metrics (production per capita or per facility)  
- Enhanced interactivity in Tableau (filters, dynamic rankings)  

------------------------------------------------------------------------

## 📁 Project Structure

The repository is organized to reflect a clear end-to-end analytics workflow:
```text
cheese-production-sql-project/
├── data/
│   ├── raw/
│   └── processed/
├── docs/
│   ├── executive_summary.md
│   └── conclusion.md
├── sql/
│   ├── cheese_cleaning.sql
│   └── cheese_exploratory_analysis.sql
├── tableau/
│   ├── dashboard/
│   └── visualizations/
└── README.md
```

------------------------------------------------------------------------

## ✨ Key Skills Demonstrated

- Data cleaning & validation  
- SQL joins and aggregations  
- Analytical thinking & business framing  
- Data visualization & storytelling  
- End-to-end project documentation  

------------------------------------------------------------------------

👤 Author

**Franco Palomeque**  
Data Analyst — SQL | Business & Product Analytics

------------------------------------------------------------------------

*This project is part of a personal analytics portfolio and is intended for educational and professional demonstration purposes.*
