WITH aux AS (
SELECT
  svc_name
  ,region
  ,latency
  ,RANK() OVER (PARTITION BY region ORDER BY latency ASC)  AS rank_low
  ,RANK() OVER (PARTITION BY region ORDER BY latency DESC) AS rank_high
FROM 
  svc_health
WHERE 
  1 = 1
  AND UPPER(region) LIKE 'US-%'
  AND latency IS NOT NULL
)
SELECT
  svc_name
  ,region
  ,latency
  ,CASE
    WHEN rank_low = 1 THEN 'lowest'
    WHEN rank_high = 1 THEN 'highest'
  END AS latency_type
FROM 
  aux
WHERE 
  1 = 1
  and (rank_low = 1 OR rank_high = 1);
