-- 03_aggregate_analysis.sql
-- Generate aggregated statistics tables: by age group, sex, risk level, and age × sex

USE healthcare_dw;

-- 1) Calculate disease rate by age group
DROP TABLE IF EXISTS age_group_stats;

CREATE TABLE age_group_stats AS
SELECT
  age_group,
  COUNT(*) AS total,
  SUM(CASE WHEN target = 1 THEN 1 ELSE 0 END) AS heart_cases,
  ROUND(100.0 * SUM(CASE WHEN target = 1 THEN 1 ELSE 0 END) / COUNT(*), 2) AS heart_rate_pct
FROM heart_scored
GROUP BY age_group
ORDER BY age_group;


-- 2) Calculate disease rate by sex (sex: 0 = female, 1 = male)
DROP TABLE IF EXISTS sex_stats;

CREATE TABLE sex_stats AS
SELECT
  sex,
  COUNT(*) AS total,
  SUM(CASE WHEN target = 1 THEN 1 ELSE 0 END) AS heart_cases,
  ROUND(100.0 * SUM(CASE WHEN target = 1 THEN 1 ELSE 0 END) / COUNT(*), 2) AS heart_rate_pct
FROM heart_scored
GROUP BY sex
ORDER BY sex;


-- 3) Count patients by risk level
DROP TABLE IF EXISTS risk_level_stats;

CREATE TABLE risk_level_stats AS
SELECT
  risk_level,
  COUNT(*) AS total
FROM heart_scored
GROUP BY risk_level;


-- 4) Cross-tabulation of age group × sex (for U-shaped and declining trend visualization)
DROP TABLE IF EXISTS age_sex_stats;

CREATE TABLE age_sex_stats AS
SELECT
  age_group,
  sex,
  COUNT(*) AS total,
  SUM(CASE WHEN target = 1 THEN 1 ELSE 0 END) AS heart_cases,
  ROUND(100.0 * SUM(CASE WHEN target = 1 THEN 1 ELSE 0 END) / COUNT(*), 2) AS heart_rate_pct
FROM heart_scored
GROUP BY age_group, sex
ORDER BY age_group, sex;


-- Simple check
SELECT * FROM age_group_stats;
SELECT * FROM sex_stats;
SELECT * FROM risk_level_stats;
SELECT * FROM age_sex_stats;
