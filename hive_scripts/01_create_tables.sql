-- 01_create_tables.sql
-- Create database and raw table (heart_raw)

CREATE DATABASE IF NOT EXISTS healthcare_dw;
USE healthcare_dw;

-- External table pointing to heart.csv in HDFS
-- Ensure heart.csv is uploaded to /user/root/healthcare/heart/ directory

CREATE EXTERNAL TABLE IF NOT EXISTS heart_raw (
  age       INT,
  sex       INT,
  cp        INT,
  trestbps  INT,
  chol      INT,
  fbs       INT,
  restecg   INT,
  thalach   INT,
  exang     INT,
  oldpeak   DOUBLE,
  slope     INT,
  ca        INT,
  thal      INT,
  target    INT
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
STORED AS TEXTFILE
LOCATION '/user/root/healthcare/heart/';

-- Test
SELECT * FROM heart_raw LIMIT 10;
