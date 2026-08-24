# YPF S.A. Financial & Operational Analysis (2011–2023)

![YPF Executive Dashboard](ypf_executive_dashboard.png)

## 📌 Executive Summary
This project provides a comprehensive financial and operational performance analysis of **YPF S.A.** (Argentina's state-owned energy company) between **2011 and 2023**. 

By consolidating historical macroeconomic data, international crude benchmark prices (Brent), domestic exchange rates, and YPF's annual financial statements, the objective was to analyze how external commodity price volatility and macroeconomic shifts impacted the company's revenue, EBITDA margin, and operational efficiency.

---

## 🛠️ Tech Stack & Workflow
* **Data Lakehouse & Warehouse:** Google BigQuery (SQL)
* **Data Visualization & BI:** Google Looker Studio
* **Data Transformation:** SQL (`CREATE VIEW`, Window Functions, `LEFT JOIN`, `COALESCE`, Aggregations)
* **Documentation & Version Control:** GitHub

---

## 📊 Key Business Insights
1. **Commodity Price Sensitivity:** YPF's revenue closely tracks international Brent crude prices, showing high vulnerability to global oil cycles.
2. **EBITDA Margin Resilience:** Despite price fluctuations, YPF maintained an average EBITDA margin of **29.06%**, driven by operational adjustments during low-price periods.
3. **Macroeconomic Impact:** Exchange rate shifts and domestic price controls created significant divergence between USD-denominated revenues and local currency operational costs.

---

## 📂 Project Structure
```text
├── sql/
│   └── 01_consolidated_view.sql    # BigQuery SQL code for data consolidation
├── README.md                       # Project documentation & overview
├── ypf_executive_dashboard.png     # Dashboard screenshot for preview
└── ypf_financial_analysis_dashboard.pdf # Full executive report in PDF format
