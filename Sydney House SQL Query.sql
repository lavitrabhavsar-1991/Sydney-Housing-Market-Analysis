show tables;
select * from domain_properties;
select sum(price) as Total_Revenue from domain_properties;
SELECT COUNT(*) FROM domain_properties;
select * from clean_sydney_properties;
select * from sydney_properties; 

CREATE TABLE clean_sydney_properties AS
SELECT
    price,
    date_sold,
    TRIM(UPPER(suburb)) AS suburb,
    TRIM(UPPER(type)) AS type,
    num_bed,
    num_bath,
    num_parking,
    property_size,
    km_from_cbd,
    suburb_population,
    suburb_sqkm,
    suburb_median_income,
    cash_rate,
    property_inflation_index
FROM domain_properties
WHERE
    price IS NOT NULL AND price > 0
    AND date_sold IS NOT NULL
    AND suburb IS NOT NULL
    AND type IS NOT NULL;

CREATE TABLE sydney_properties AS
SELECT *,
    -- Time features
    YEAR(date_sold) AS year_sold,
    MONTH(date_sold) AS month_sold,
    QUARTER(date_sold) AS quarter_sold,
    -- Normalized prices
    CASE 
        WHEN num_bed > 0 THEN price / num_bed 
        ELSE NULL 
    END AS price_per_bed,
    CASE 
        WHEN property_size > 0 THEN price / property_size 
        ELSE NULL 
    END AS price_per_sqm,
    -- Distance bands
    CASE
        WHEN km_from_cbd <= 10 THEN '0–10 km'
        WHEN km_from_cbd <= 20 THEN '10–20 km'
        WHEN km_from_cbd <= 30 THEN '20–30 km'
        WHEN km_from_cbd <= 40 THEN '30–40 km'
        WHEN km_from_cbd <= 50 THEN '40–50 km'
        ELSE '50+ km'
    END AS cbd_distance_band,
    -- Density
    CASE
        WHEN suburb_sqkm > 0 THEN suburb_population / suburb_sqkm
        ELSE NULL
    END AS suburb_density,
    -- Affordability
    CASE
        WHEN suburb_median_income > 0 THEN price / suburb_median_income
        ELSE NULL
    END AS affordability_ratio
FROM clean_sydney_properties;


# KPI 1 - Monthly Median Price
CREATE TABLE kpi_median_price AS
SELECT
    year_sold,
    month_sold,
    AVG(price) AS median_price
FROM (
    SELECT
        year_sold,
        month_sold,
        price,
        ROW_NUMBER() OVER (
            PARTITION BY year_sold, month_sold
            ORDER BY price
        ) AS rn,
        COUNT(*) OVER (
            PARTITION BY year_sold, month_sold
        ) AS cnt
    FROM sydney_properties
) t
WHERE rn IN (FLOOR((cnt + 1) / 2), FLOOR((cnt + 2) / 2))
GROUP BY year_sold, month_sold;


# KPI 2 - Sales Volume
CREATE TABLE kpi_sales_volume AS
SELECT
    year_sold,
    month_sold,
    COUNT(*) AS sales_volume
FROM sydney_properties
GROUP BY year_sold, month_sold
ORDER BY year_sold, month_sold;
select * from kpi_sales_volume;


# Validation CHeck for KPI 1 and 2
SELECT *
FROM kpi_sales_volume
JOIN kpi_median_price
USING (year_sold, month_sold)
LIMIT 10;


# KPI 3 - Median Price by Suburb
CREATE TABLE kpi_suburb_prices AS
SELECT
    suburb,
    AVG(price) AS median_price,
    COUNT(*) AS sales_volume
FROM (
    SELECT
        suburb,
        price,
        ROW_NUMBER() OVER (
            PARTITION BY suburb
            ORDER BY price
        ) AS rn,
        COUNT(*) OVER (
            PARTITION BY suburb
        ) AS cnt
    FROM sydney_properties
) t
WHERE rn IN (FLOOR((cnt + 1) / 2), FLOOR((cnt + 2) / 2))
GROUP BY suburb;


# Validation check for KPI 3
SELECT *
FROM kpi_suburb_prices
ORDER BY median_price DESC
LIMIT 10;


# KPI 4 - Median Price by Property
CREATE TABLE kpi_property_type_prices AS
SELECT
    type,
    AVG(price) AS median_price
FROM (
    SELECT
        type,
        price,
        ROW_NUMBER() OVER (
            PARTITION BY type
            ORDER BY price
        ) AS rn,
        COUNT(*) OVER (
            PARTITION BY type
        ) AS cnt
    FROM sydney_properties
) t
WHERE rn IN (FLOOR((cnt + 1) / 2), FLOOR((cnt + 2) / 2))
GROUP BY type;


# Validation check for KPI 4
SELECT *
FROM kpi_property_type_prices;


# KPI 5 - Price by Bed
CREATE TABLE kpi_price_per_bed AS
SELECT
    suburb,
    AVG(price_per_bed) AS median_price_per_bed
FROM (
    SELECT
        suburb,
        price_per_bed,
        ROW_NUMBER() OVER (PARTITION BY suburb ORDER BY price_per_bed) AS rn,
        COUNT(*) OVER (PARTITION BY suburb) AS cnt
    FROM sydney_properties
    WHERE price_per_bed IS NOT NULL
) t
WHERE rn IN (FLOOR((cnt + 1) / 2), FLOOR((cnt + 2) / 2))
GROUP BY suburb;


# Validation for KPI 5
SELECT *
FROM kpi_price_per_bed
ORDER BY median_price_per_bed DESC
LIMIT 10;


# KPI 6 - Price by Square feet
CREATE TABLE kpi_price_per_sqm AS
SELECT
    suburb,
    AVG(price_per_sqm) AS median_price_per_sqm
FROM (
    SELECT
        suburb,
        price_per_sqm,
        ROW_NUMBER() OVER (PARTITION BY suburb ORDER BY price_per_sqm) AS rn,
        COUNT(*) OVER (PARTITION BY suburb) AS cnt
    FROM sydney_properties
    WHERE price_per_sqm IS NOT NULL
) t
WHERE rn IN (FLOOR((cnt + 1) / 2), FLOOR((cnt + 2) / 2))
GROUP BY suburb;


# Vallidation for KPI 6
SELECT *
FROM kpi_price_per_sqm
ORDER BY median_price_per_sqm DESC
LIMIT 10;


# KPI 7 - Price and DIstance from CBD
CREATE TABLE kpi_price_distance AS
SELECT
    cbd_distance_band,
    AVG(price) AS median_price
FROM (
    SELECT
        cbd_distance_band,
        price,
        ROW_NUMBER() OVER (PARTITION BY cbd_distance_band ORDER BY price) AS rn,
        COUNT(*) OVER (PARTITION BY cbd_distance_band) AS cnt
    FROM sydney_properties
) t
WHERE rn IN (FLOOR((cnt + 1) / 2), FLOOR((cnt + 2) / 2))
GROUP BY cbd_distance_band;


# Validation for KPI 7
SELECT *
FROM kpi_price_distance
ORDER BY cbd_distance_band;


# KPI 8 - Price by Suburb Density
CREATE TABLE kpi_density_price AS
SELECT
    suburb,
    suburb_density,
    AVG(price) AS median_price
FROM (
    SELECT
        suburb,
        suburb_density,
        price,
        ROW_NUMBER() OVER (
            PARTITION BY suburb, suburb_density
            ORDER BY price
        ) AS rn,
        COUNT(*) OVER (
            PARTITION BY suburb, suburb_density
        ) AS cnt
    FROM sydney_properties
    WHERE suburb_density IS NOT NULL
) t
WHERE rn IN (FLOOR((cnt + 1) / 2), FLOOR((cnt + 2) / 2))
GROUP BY suburb, suburb_density;


# Validation for KPI 8
SELECT *
FROM kpi_density_price
ORDER BY suburb_density DESC
LIMIT 10;


# KPI 9 - Prive vs Median Income
CREATE TABLE kpi_income_price AS
SELECT
    suburb,
    suburb_median_income,
    AVG(price) AS median_price
FROM (
    SELECT
        suburb,
        suburb_median_income,
        price,
        ROW_NUMBER() OVER (
            PARTITION BY suburb, suburb_median_income
            ORDER BY price
        ) AS rn,
        COUNT(*) OVER (
            PARTITION BY suburb, suburb_median_income
        ) AS cnt
    FROM sydney_properties
    WHERE suburb_median_income IS NOT NULL
) t
WHERE rn IN (FLOOR((cnt + 1) / 2), FLOOR((cnt + 2) / 2))
GROUP BY suburb, suburb_median_income;


# Validation for KPI 9
SELECT *
FROM kpi_income_price
ORDER BY suburb_median_income DESC
LIMIT 10;


# KPI 10 - Affordability
CREATE TABLE kpi_affordability AS
SELECT
    suburb,
    AVG(affordability_ratio) AS median_affordability_ratio
FROM (
    SELECT
        suburb,
        affordability_ratio,
        ROW_NUMBER() OVER (PARTITION BY suburb ORDER BY affordability_ratio) AS rn,
        COUNT(*) OVER (PARTITION BY suburb) AS cnt
    FROM sydney_properties
    WHERE affordability_ratio IS NOT NULL
) t
WHERE rn IN (FLOOR((cnt + 1) / 2), FLOOR((cnt + 2) / 2))
GROUP BY suburb;


# Validation for KPI 10
SELECT *
FROM kpi_affordability
ORDER BY median_affordability_ratio DESC
LIMIT 10;


# KPI 11 - Price vs Cash
CREATE TABLE kpi_cash_rate AS
SELECT
    year_sold,
    month_sold,
    cash_rate,
    AVG(price) AS median_price
FROM (
    SELECT
        year_sold,
        month_sold,
        cash_rate,
        price,
        ROW_NUMBER() OVER (
            PARTITION BY year_sold, month_sold, cash_rate
            ORDER BY price
        ) AS rn,
        COUNT(*) OVER (
            PARTITION BY year_sold, month_sold, cash_rate
        ) AS cnt
    FROM sydney_properties
) t
WHERE rn IN (FLOOR((cnt + 1) / 2), FLOOR((cnt + 2) / 2))
GROUP BY year_sold, month_sold, cash_rate;


# Validation for KPI 11
SELECT *
FROM kpi_cash_rate
ORDER BY year_sold, month_sold;


# KPI 12 - Inflation Adjusted Price 
CREATE TABLE kpi_real_price AS
SELECT
    year_sold,
    month_sold,
    AVG(real_price) AS real_median_price
FROM (
    SELECT
        year_sold,
        month_sold,
        price / property_inflation_index AS real_price,
        ROW_NUMBER() OVER (
            PARTITION BY year_sold, month_sold
            ORDER BY price / property_inflation_index
        ) AS rn,
        COUNT(*) OVER (
            PARTITION BY year_sold, month_sold
        ) AS cnt
    FROM sydney_properties
    WHERE property_inflation_index IS NOT NULL
) t
WHERE rn IN (FLOOR((cnt + 1) / 2), FLOOR((cnt + 2) / 2))
GROUP BY year_sold, month_sold;


# Validation for KPI 12
SELECT *
FROM kpi_real_price
ORDER BY year_sold, month_sold;






