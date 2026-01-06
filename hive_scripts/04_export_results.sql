-- 04_export_results.sql
-- Export statistics results to CSV (no header)

USE healthcare_dw;

-- 1) By age group
INSERT OVERWRITE LOCAL DIRECTORY '/tmp/age_group_export'
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
SELECT age_group, total, heart_cases, heart_rate_pct
FROM age_group_stats
ORDER BY age_group;

-- 2) By sex
INSERT OVERWRITE LOCAL DIRECTORY '/tmp/sex_export'
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
SELECT sex, total, heart_cases, heart_rate_pct
FROM sex_stats
ORDER BY sex;

-- 3) By risk level
INSERT OVERWRITE LOCAL DIRECTORY '/tmp/risk_level_export'
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
SELECT risk_level, total
FROM risk_level_stats
ORDER BY risk_level;

-- 4) Age × Sex
INSERT OVERWRITE LOCAL DIRECTORY '/tmp/age_sex_export'
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
SELECT age_group, sex, total, heart_cases, heart_rate_pct
FROM age_sex_stats
ORDER BY age_group, sex;
