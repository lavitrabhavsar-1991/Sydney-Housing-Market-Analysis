# 🏠 Sydney Housing Market Analysis
### End-to-End Data Analytics Project | MySQL · Power BI

![Project Banner](https://img.shields.io/badge/Status-Complete-brightgreen?style=for-the-badge)
![SQL](https://img.shields.io/badge/MySQL-8.0-blue?style=for-the-badge&logo=mysql&logoColor=white)
![Power BI](https://img.shields.io/badge/PowerBI-F2C811?style=for-the-badge&logo=powerbi&logoColor=black)
![Domain](https://img.shields.io/badge/Domain-Real%20Estate-red?style=for-the-badge)

---

## 📋 Project Overview

A analytics project examining **Sydney's property market** — from raw data transformation through SQL to an interactive Power BI dashboard. The project uncovers pricing patterns, affordability stress points, and the influence of macroeconomic factors like the RBA cash rate on buyer behaviour.

> **Goal:** Identify the key drivers of Sydney property prices and surface actionable insights for buyers, investors, and policymakers.

---

## 🗂️ Repository Structure

```
sydney-housing-analysis/
│
├── 📄 Sydney_House_SQL_Query.sql       # Full data pipeline: cleaning → feature engineering → KPIs
├── 📊 Sydney_House_Visualization.pbix  # Power BI dashboard (3-page interactive report)
└── 📖 README.md
```

---

## 🛠️ Tech Stack & Methodology

| Layer | Tool | Purpose |
|---|---|---|
| Data Storage | MySQL 8.0 | Source database for raw property records |
| Data Cleaning | SQL (CTEs, TRIM, UPPER, WHERE filters) | Removed nulls, standardised suburb/type names |
| Feature Engineering | SQL Window Functions | Derived price/bed, price/sqm, distance bands, suburb density, affordability ratio |
| KPI Computation | SQL Median via ROW_NUMBER() | 12 analytical KPI tables built from scratch |
| Visualisation | Power BI Desktop | 3-page interactive dashboard with slicers and cross-filtering |

---

## 📊 Key Findings

### Suburb & Property Insights

| Insight | Finding |
|---|---|
| 🏆 Most Expensive Suburb (Median) | **Kurraba Point** at ~$34M avg median |
| 💰 Highest Price/Bed | **Darling Point** at $2.9M/bed |
| 🏢 Most Expensive Property Type | **Block of Units** at $2.9M median |
| 📐 Highest Price/sqm | **Barangaroo** at $23K/sqm — outranks prestige harbour suburbs |

> **Insight:** Price per sqm tells a different story to raw median price. Barangaroo and Surry Hills dominate on density-adjusted value — likely driven by apartment-heavy stock and premium inner-city demand. Kurraba Point's headline price is inflated by a small number of ultra-premium sales.

---

### Macro & Structural Drivers

| Insight | Finding |
|---|---|
| 📍 CBD Proximity Premium | 0–10 km: **$2.02M** → 50+ km: ~$1.0M |
| 👥 Densest Suburb | **Chippendale** at 18,571 people/km² |
| 💼 Highest Median Income Suburb | **Barangaroo** at $97,500 |
| ⚠️ Worst Affordability | **Kurraba Point** at ratio **419×** annual income |

> **Insight:** Kurraba Point's affordability ratio of 419× vs the next suburb at 119× (Rose Bay) flags it as an ultra-luxury outlier, not a mainstream market. The RBA cash rate analysis (KPI 11) enables correlation testing between rate hikes and price softening — a valuable macro lens.

---

## 🔍 Analytical Highlights

- **Median via Window Function** — Avoided AVG distortion from outliers by computing true statistical median using `ROW_NUMBER() OVER (PARTITION BY ...)` across all 12 KPI tables
- **Inflation-Adjusted Pricing (KPI 12)** — Real median prices computed by deflating nominal prices against the `property_inflation_index`, enabling time-series comparisons in constant dollar terms
- **Affordability Ratio** — `price / suburb_median_income` surfaces structural stress beyond raw price rankings, identifying which suburbs are genuinely out of reach

---
*Data sourced from Domain.com.au property listings. For educational and portfolio purposes.*
