-- ====================================================================
-- Project: YPF S.A. Financial & Market Performance Analysis
-- Description: Unification of financial statements, official exchange 
--              rate (ARS/USD), and global Brent Crude benchmark.
-- ====================================================================

CREATE OR REPLACE TABLE `proyecto-ypf-493613.datos_ypf.ypf_consolidado_analisis` AS

WITH financieros_transformados AS (
  SELECT
    CAST(anio AS INT64) AS anio,
    CAST(anio AS STRING) AS anio_txt,
    SAFE_CAST(revenue AS NUMERIC) AS revenue,
    SAFE_CAST(ebitda AS NUMERIC) AS ebitda,
    SAFE_CAST(net_income AS NUMERIC) AS net_income
  FROM
    `proyecto-ypf-493613.datos_ypf.ypf_financiero`
),

tipo_cambio_anual AS (
  SELECT
    CAST(anio AS INT64) AS anio,
    AVG(SAFE_CAST(tipo_cambio AS NUMERIC)) AS tipo_cambio_promedio
  FROM
    `proyecto-ypf-493613.datos_ypf.tipo_cambio_ars`
  GROUP BY
    1
),

brent_anual AS (
  SELECT
    CAST(anio AS INT64) AS anio,
    AVG(SAFE_CAST(brent_precio AS NUMERIC)) AS brent_promedio
  FROM
    `proyecto-ypf-493613.datos_ypf.brent_precio`
  GROUP BY
    1
),

produccion_anual AS (
  SELECT
    CAST(anio AS INT64) AS anio,
    SUM(SAFE_CAST(produccion_total AS NUMERIC)) AS produccion_total_anual
  FROM
    `proyecto-ypf-493613.datos_ypf.produccion_historica`
  GROUP BY
    1
)

SELECT
  f.anio_txt,
  f.anio,
  f.revenue,
  f.ebitda,
  f.net_income,
  p.produccion_total_anual,
  ROUND(b.brent_promedio, 2) AS brent_promedio,
  ROUND(tc.tipo_cambio_promedio, 2) AS tipo_cambio_promedio,
  -- Foreign exchange conversion (ARS to USD Billions)
  ROUND(SAFE_DIVIDE(f.revenue, tc.tipo_cambio_promedio), 2) AS revenue_usd,
  ROUND(SAFE_DIVIDE(f.ebitda, tc.tipo_cambio_promedio), 2) AS ebitda_usd,
  -- Relative EBITDA Margin calculation (%)
  ROUND(SAFE_DIVIDE(f.ebitda, f.revenue) * 100, 2) AS margen_ebitda_pct
FROM
  financieros_transformados f
LEFT JOIN
  tipo_cambio_anual tc ON f.anio = tc.anio
LEFT JOIN
  brent_anual b ON f.anio = b.anio
LEFT JOIN
  produccion_anual p ON f.anio = p.anio
ORDER BY
  f.anio ASC;
