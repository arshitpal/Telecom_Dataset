CREATE DATABASE TelecomData2;
USE TelecomData;
CREATE TABLE Devices (
  PID VARCHAR(10) PRIMARY KEY,
  Blue BOOLEAN,
  Wi_Fi BOOLEAN,
  Tch_Scr BOOLEAN,
  Ext_Mem BOOLEAN,
  Px_h INT,
  Px_w INT,
  Scr_h INT,
  Scr_w INT,
  PC INT,
  FC INT,
  Int_Mem INT,
  Bty_Pwr INT,
  RAM INT,
  Depth INT,
  Weight INT,
  Price INT
);
-- Import the CSV Data 
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Telecom Dataset.csv'
INTO TABLE Devices
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

-- Summary Statistics
SELECT 
  COUNT(*) AS Total_Devices,
  AVG(Price) AS Avg_Price,
  MIN(Price) AS Min_Price,
  MAX(Price) AS Max_Price,
  STDDEV(Price) AS StdDev_Price
FROM Devices;

-- Boolean Feature Counts
SELECT 
  SUM(Blue) AS Blue_Yes,
  COUNT(*) - SUM(Blue) AS Blue_No,
  SUM(Wi_Fi) AS WiFi_Yes,
  COUNT(*) - SUM(Wi_Fi) AS WiFi_No,
  SUM(Tch_Scr) AS Touch_Yes,
  COUNT(*) - SUM(Tch_Scr) AS Touch_No,
  SUM(Ext_Mem) AS ExtMem_Yes,
  COUNT(*) - SUM(Ext_Mem) AS ExtMem_No
FROM Devices;

-- Average Price by RAM
SELECT RAM, COUNT(*) AS Count, AVG(Price) AS Avg_Price
FROM Devices
GROUP BY RAM
ORDER BY RAM;

-- Top 5 Most Expensive Devices
SELECT PID, Price
FROM Devices
ORDER BY Price DESC
LIMIT 5;

-- High RAM and Battery Devices
SELECT PID, RAM, Bty_Pwr, Price
FROM Devices
WHERE RAM >= 8 AND Bty_Pwr >= 4000;

-- Screen Resolution Distribution
SELECT Px_h * Px_w AS Resolution, COUNT(*) AS Count
FROM Devices
GROUP BY Resolution
ORDER BY Resolution DESC;

-- Price Distribution (Grouped Ranges)
SELECT 
  CASE 
    WHEN Price < 10000 THEN 'Under 10K'
    WHEN Price BETWEEN 10000 AND 30000 THEN '10K–30K'
    WHEN Price BETWEEN 30001 AND 60000 THEN '30K–60K'
    ELSE 'Above 60K'
  END AS Price_Range,
  COUNT(*) AS Device_Count
FROM Devices
GROUP BY Price_Range;

-- RAM vs Price Trend
SELECT RAM, AVG(Price) AS Avg_Price, MIN(Price) AS Min_Price, MAX(Price) AS Max_Price
FROM Devices
GROUP BY RAM
ORDER BY RAM;

-- Battery Power vs Price
SELECT Bty_Pwr, AVG(Price) AS Avg_Price
FROM Devices
GROUP BY Bty_Pwr
ORDER BY Bty_Pwr DESC;

-- Device Count by Internal Memory
SELECT Int_Mem, COUNT(*) AS Device_Count
FROM Devices
GROUP BY Int_Mem
ORDER BY Int_Mem;

-- Average Price by Wi-Fi and Bluetooth Support
SELECT Wi_Fi, Blue, AVG(Price) AS Avg_Price
FROM Devices
GROUP BY Wi_Fi, Blue;





