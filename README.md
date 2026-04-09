# 🏠 Sydney Housing Market Analysis
### End-to-End Data Analytics Project | MySQL · Power BI

![Project Banner](https://img.shields.io/badge/Status-Complete-brightgreen?style=for-the-badge)
![SQL](https://img.shields.io/badge/MySQL-8.0-blue?style=for-the-badge&logo=mysql&logoColor=white)
![Power BI](https://img.shields.io/badge/PowerBI-F2C811?style=for-the-badge&logo=powerbi&logoColor=black)
![Domain](https://img.shields.io/badge/Domain-Real%20Estate-red?style=for-the-badge)

---

## 🎯 The Business Question

> **Does Sydney's property market price homes rationally or are buyers paying a premium for reputation over real value?**

Sydney is consistently ranked among the world's least affordable cities. But which metric you use to measure "expensive" changes the answer entirely. Raw median prices favour suburbs with a handful of ultra-luxury sales. Price per square metre rewards density. Affordability ratio exposes structural stress.

This project was built to answer one question: **If you stripped away suburb reputation and looked purely at the data, where does value actually exist in Sydney's property market and what is an illusion?**

---

## 💡 What I Expected vs What Actually Surprised Me

This is where the data got interesting.

### ✅ What I Expected (and the data confirmed)

**CBD proximity drives price. Meaning the closer a place is to CBD the more expensive.** Not surprisingly, the median prices decay almost linearly from **$2.02M** within 10km of the CBD down to approximately **$1.0M** at 50km+. Distance is the single most consistent structural variable in the dataset.

**Prestigious harbour suburbs dominate the top of the price rankings.** Kurraba Point, Darling Point, and Rose Bay all appear near the top of the suburb median price list. Expected.

---

### ⚡ What Surprised Me (where the data challenged assumptions)

**1. The most "expensive" suburb in Sydney is a statistical illusion.**

Kurraba Point sits at a staggering **~$34M median** which is almost 5× higher than its nearest competitors at $6–9M. But when you calculate its affordability ratio (property price ÷ suburb median income), it comes out at **419×** annual income. The next highest suburb, Rose Bay, is 119×. Darling Point is 104×.

That gap between 419× and 119× doesn't suggest Kurraba Point is "more expensive" rather it suggests its median is being distorted by an extremely small number of ultra-premium transactions. It's not a functioning residential market. It's an outlier masquerading as a suburb.

**Recommendation for buyers/investors:** Kurraba Point's headline median should be treated as noise, not signal. Rose Bay and Darling Point represent genuinely high-value markets; Kurraba Point represents statistical distortion.

---

**2. The highest price-per-sqm suburb is not a harbour postcode.**

I expected Kurraba Point or Darling Point to dominate price per square metre. They don't.

**Barangaroo leads at $23K/sqm**, followed by Surry Hills and Woollahra at ~$21K/sqm. The prestigious harbour suburbs, despite their eye-catching medians, fall below these inner-city areas on density-adjusted value.

Why? Barangaroo and Surry Hills are dominated by compact, high-end apartments. Harbour suburbs tend to have larger land parcels — which dilutes the per-sqm figure even at high prices. This means an investor buying on price/sqm is buying a completely different market to one buying on raw median.

**Recommendation:** Raw median price and price/sqm are answering different investment questions. A buyer seeking capital growth per dollar spent should look at Barangaroo and inner-city suburbs. A buyer seeking prestige and a larger landholding should look at the harbour belt but they are paying a different kind of premium.

---

**3. Units are more expensive than houses — the opposite of the "Great Australian Dream."**

The received wisdom in Australian property is that houses command a premium over apartments and units. In this dataset, **Block of Units has the highest median at $2.9M**, while Houses sit at the bottom of the property type rankings at **$1.4M**.

This likely reflects geography: the most expensive suburbs in Sydney are dominated by apartment and unit stock (Barangaroo, Surry Hills, inner-east). The house market, by volume, is pulled toward outer suburbs where prices are lower. But it directly challenges the assumption that "houses are always worth more."

**Recommendation:** Property type alone is a weak predictor of value without controlling for location. Any analysis comparing house vs unit returns needs to account for the suburb distribution of that stock.

---

**4. The densest suburb in Sydney doesn't appear in any top-price list.**

Chippendale ranks first for suburb density at **18,571 people/km²** — yet it does not appear in the top suburbs by median price, price/sqm, or price/bed. This challenges the assumption that density signals desirability or premium pricing.

High density in Sydney appears to reflect affordable inner-city apartment stock, not premium positioning. Density and desirability are not the same variable.

---

**5. Darling Point has the highest price per bedroom but not the highest price per sqm.**

Darling Point leads on **price per bed at $2.9M/bedroom** but does not lead on price per sqm. This suggests Darling Point properties are large-format, low-density dwellings where you are paying for fewer, more exclusive bedrooms in larger homes. It's a different type of premium to Barangaroo's compact, high-value-per-metre stock.

---

## 📊 Dashboard Overview

The Power BI dashboard is structured across two analytical lenses:

**Page 1 — Suburb & Property Intelligence**
Median price by suburb, price per bed, price per sqm, and property type breakdown. Designed to answer: *which suburbs offer what kind of value, and by which measure?*

**Page 2 — Structural & Macro Drivers**
CBD distance bands, suburb density, median income, affordability ratios, and the RBA cash rate correlation. Designed to answer: *what structural factors are actually driving prices, and which assumptions don't hold up?*

---

## 🛠️ Technical Approach

| Layer | Tool | Decision |
|---|---|---|
| Data Storage | MySQL 8.0 | Source database for raw property records from Domain.com.au |
| Data Cleaning | SQL (TRIM, UPPER, WHERE filters) | Null removal, suburb/type standardisation |
| Feature Engineering | SQL Window Functions | 12+ derived columns: price/bed, price/sqm, distance bands, density, affordability ratio, inflation-adjusted price |
| Median Computation | ROW_NUMBER() OVER PARTITION | Used true statistical median throughout — AVG() is meaningless in a market with Kurraba Point as an outlier |
| Visualisation | Power BI Desktop | 2-page dashboard with cross-filtering slicers |

**Why true median instead of average?**
Kurraba Point's ~$34M median would pull `AVG(price)` significantly for any aggregation including that suburb. Every KPI table in this project uses `ROW_NUMBER() OVER (PARTITION BY ... ORDER BY price)` to compute the statistical midpoint. This is a deliberate methodological choice, not a default.

---
