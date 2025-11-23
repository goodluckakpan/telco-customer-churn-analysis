CREATE DATABASE telco_churn;
USE telco_churn;

create table customers (
customerID varchar(20) primary key,
gender varchar(6),	
SeniorCitizen int,	
Partner	varchar(20),
Dependents varchar (20),	
tenure int,	
PhoneService varchar(20),	
MultipleLines varchar(20),	
InternetService	varchar(30),
OnlineSecurity varchar(30),
OnlineBackup varchar(30),	
DeviceProtection varchar(30),	
TechSupport	varchar(30),
StreamingTV	varchar(30),
StreamingMovies	varchar(30),
Contract varchar(30),	
PaperlessBilling varchar(30),	
PaymentMethod varchar(30),
MonthlyCharges	decimal(15,2),
TotalCharges decimal(15,2),
Churn varchar(20)
);

select * from customers limit 20;

-- total customers
SELECT COUNT(*) AS total_customers FROM customers;

-- overall Churn rate
SELECT 
    Churn, 
    COUNT(*) AS count,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM customers), 2) AS percentage
FROM customers 
GROUP BY Churn;

-- Churn by Contract
SELECT Contract, Churn, COUNT(*) AS count
FROM customers
GROUP BY Contract, Churn
ORDER BY Contract, Churn;

-- Avg tenure by Churn
SELECT Churn, ROUND(AVG(tenure), 1) AS avg_tenure_months
FROM customers
GROUP BY Churn;

-- High-value customers at risk (High charges + short contract)
SELECT customerID, tenure, MonthlyCharges, Contract, Churn
FROM customers
WHERE MonthlyCharges > 70 AND Contract = 'Month-to-month' AND Churn = 'Yes'
LIMIT 10;

-- Top 5 payment methods by churn
SELECT PaymentMethod, COUNT(*) AS churn_count
FROM customers
WHERE Churn = 'Yes'
GROUP BY PaymentMethod
ORDER BY churn_count DESC
LIMIT 5;

-- Senior citizens churn
SELECT SeniorCitizen, Churn, COUNT(*) AS count
FROM customers
GROUP BY SeniorCitizen, Churn;

-- Internet service impact
SELECT InternetService, Churn, COUNT(*) AS count
FROM customers
GROUP BY InternetService, Churn;

-- Monthly charges distribution
SELECT 
    CASE 
        WHEN MonthlyCharges < 30 THEN '< $30'
        WHEN MonthlyCharges < 60 THEN '$30–60'
        WHEN MonthlyCharges < 90 THEN '$60–90'
        ELSE '> $90'
    END AS charge_bucket,
    Churn, COUNT(*) AS count
FROM customers
GROUP BY charge_bucket, Churn;

-- Customers with no TechSupport + Churn
SELECT COUNT(*) AS no_techsupport_churn
FROM customers
WHERE TechSupport = 'No' AND Churn = 'Yes';



