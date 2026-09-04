CREATE TABLE marketing_campaigns (
    date DATE,
    campaignid VARCHAR(20),
    campaignname VARCHAR(100),
    platform VARCHAR(50),
    targetaudience VARCHAR(50),
    impressions INTEGER,
    clicks INTEGER,
    leads INTEGER,
    applications INTEGER,
    enrollments INTEGER,
    cost NUMERIC(15,2),
    revenue NUMERIC(15,2),
    region VARCHAR(50),
    ctr NUMERIC(10,4),
    cpc NUMERIC(10,4),
    conversion_rate NUMERIC(10,4),
    cpa NUMERIC(10,4),
    roas NUMERIC(10,4)
);

TRUNCATE TABLE marketing_campaigns;

SELECT COUNT(*)
FROM marketing_campaigns

## Data Validation

SELECT COUNT(*)
FROM marketing_campaigns;

SELECT *
FROM marketing_campaigns
LIMIT 10;

## Platfrom Analysis.
## Revenue by Platform

SELECT
    platform,
    ROUND(SUM(revenue),2) AS total_revenue
FROM marketing_campaigns
GROUP BY platform
ORDER BY total_revenue DESC;

## Cost by platform

SELECT
    platform,
    ROUND(SUM(cost),2) AS total_cost
FROM marketing_campaigns
GROUP BY platform
ORDER BY total_cost DESC;


## Averaeg CTR by platform

SELECT
    platform,
    ROUND(AVG(ctr),2) AS avg_ctr
FROM marketing_campaigns
GROUP BY platform
ORDER BY avg_ctr DESC;

## AVerage CPC by platform

SELECT
    platform,
    ROUND(AVG(cpc),2) AS avg_cpc
FROM marketing_campaigns
GROUP BY platform
ORDER BY avg_cpc;

## Average CPA by platfroms

SELECT
    platform,
    ROUND(AVG(cpa),2) AS avg_cpa
FROM marketing_campaigns
GROUP BY platform
ORDER BY avg_cpa;

## Average ROAS by platfrom

SELECT
    platform,
    ROUND(AVG(roas),2) AS avg_roas
FROM marketing_campaigns
GROUP BY platform
ORDER BY avg_roas DESC;

## CAMPAGIN ANALYSIS.

## Revenue by campaign

SELECT
    campaignname,
    ROUND(SUM(revenue),2) AS total_revenue
FROM marketing_campaigns
GROUP BY campaignname
ORDER BY total_revenue DESC;

## Enrollments by Campaign

SELECT
    campaignname,
    SUM(enrollments) AS total_enrollments
FROM marketing_campaigns
GROUP BY campaignname
ORDER BY total_enrollments DESC;

##ROAS by Campaign

SELECT
    campaignname,
    ROUND(AVG(roas),2) AS avg_roas
FROM marketing_campaigns
GROUP BY campaignname
ORDER BY avg_roas DESC;


## Region Analysis

## Revenue by Region

SELECT
    region,
    ROUND(SUM(revenue),2) AS total_revenue
FROM marketing_campaigns
GROUP BY region
ORDER BY total_revenue DESC;

## Enrollments by Region

SELECT
    region,
    SUM(enrollments) AS total_enrollments
FROM marketing_campaigns
GROUP BY region
ORDER BY total_enrollments DESC;

##Audience Analysis

##Revenue by Audience

SELECT
    targetaudience,
    ROUND(SUM(revenue),2) AS total_revenue
FROM marketing_campaigns
GROUP BY targetaudience
ORDER BY total_revenue DESC;

##Enrollments by Audience

SELECT
    targetaudience,
    SUM(enrollments) AS total_enrollments
FROM marketing_campaigns
GROUP BY targetaudience
ORDER BY total_enrollments DESC;

## Advanced SQL
##Rank Campaigns by Revenue

SELECT
    campaignname,
    ROUND(SUM(revenue),2) AS total_revenue,
    RANK() OVER (
        ORDER BY SUM(revenue) DESC
    ) AS revenue_rank
FROM marketing_campaigns
GROUP BY campaignname;

##Rank Platforms by ROAS

SELECT
    platform,
    ROUND(AVG(roas),2) AS avg_roas,
    DENSE_RANK() OVER (
        ORDER BY AVG(roas) DESC
    ) AS roas_rank
FROM marketing_campaigns
GROUP BY platform;

## Top 3 Revenue Platforms

SELECT *
FROM
(
    SELECT
        platform,
        ROUND(SUM(revenue),2) AS revenue,
        ROW_NUMBER() OVER(
            ORDER BY SUM(revenue) DESC
        ) AS rn
    FROM marketing_campaigns
    GROUP BY platform
) x
WHERE rn <= 3;

##Executive KPI Query

SELECT
    ROUND(SUM(revenue),2) AS total_revenue,
    ROUND(SUM(cost),2) AS total_cost,
    SUM(clicks) AS total_clicks,
    SUM(leads) AS total_leads,
    SUM(enrollments) AS total_enrollments,
    ROUND(AVG(ctr),2) AS avg_ctr,
    ROUND(AVG(cpc),2) AS avg_cpc,
    ROUND(AVG(cpa),2) AS avg_cpa,
    ROUND(AVG(roas),2) AS avg_roas
FROM marketing_campaigns;