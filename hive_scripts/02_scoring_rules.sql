-- 02_scoring_rules.sql
-- Generate scored table heart_scored based on heart_raw

USE healthcare_dw;

DROP TABLE IF EXISTS heart_scored;

CREATE TABLE heart_scored AS
SELECT
  age,
  sex,
  cp,
  trestbps,
  chol,
  fbs,
  restecg,
  thalach,
  exang,
  oldpeak,
  slope,
  ca,
  thal,
  target,
  -- Age group classification
  CASE
    WHEN age < 40 THEN 'Under 40'
    WHEN age BETWEEN 40 AND 54 THEN '40-54'
    WHEN age BETWEEN 55 AND 64 THEN '55-64'
    ELSE '65+'
  END AS age_group,

  -- Rule-based scoring: 1 point per risk factor, total score 0-5
  (CASE WHEN age > 55 THEN 1 ELSE 0 END +
   CASE WHEN rest_bp > 130 THEN 1 ELSE 0 END +
   CASE WHEN chol > 250 THEN 1 ELSE 0 END +
   CASE WHEN fbs = 1 THEN 1 ELSE 0 END +
   CASE WHEN exang = 1 THEN 1 ELSE 0 END) AS risk_score,

  -- Risk level: 0-1 Low, 2-3 Medium, 4-5 High
  CASE
    WHEN (CASE WHEN age > 55 THEN 1 ELSE 0 END +
          CASE WHEN rest_bp > 130 THEN 1 ELSE 0 END +
          CASE WHEN chol > 250 THEN 1 ELSE 0 END +
          CASE WHEN fbs = 1 THEN 1 ELSE 0 END +
          CASE WHEN exang = 1 THEN 1 ELSE 0 END) <= 1 THEN 'Low'
    WHEN (CASE WHEN age > 55 THEN 1 ELSE 0 END +
          CASE WHEN rest_bp > 130 THEN 1 ELSE 0 END +
          CASE WHEN chol > 250 THEN 1 ELSE 0 END +
          CASE WHEN fbs = 1 THEN 1 ELSE 0 END +
          CASE WHEN exang = 1 THEN 1 ELSE 0 END) <= 3 THEN 'Medium'
    ELSE 'High'
  END AS risk_level

FROM heart_raw;

-- Test
SELECT * FROM heart_scored LIMIT 10;
