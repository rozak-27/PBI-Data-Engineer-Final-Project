CREATE OR REPLACE TABLE DWH.DimAccount AS
SELECT DISTINCT
    account_id AS AccountID,
    customer_id AS CustomerID,
    UPPER(account_type) AS AccountType,
    balance AS Balance,
    date_opened AS DateOpened,
    status AS Status
FROM Staging.account;

CREATE OR REPLACE TABLE DWH.DimCustomer AS
SELECT DISTINCT
    customer_id AS CustomerID,
    UPPER(customer_name) AS CustomerName,
    address AS Address,
    city_id AS CityID,
    age AS Age,
    gender AS Gender,
    email AS Email
FROM Staging.customer;

CREATE OR REPLACE TABLE DWH.DimBranch AS
SELECT DISTINCT
    branch_id AS BranchID,
    UPPER(branch_name) AS BranchName,
    UPPER(branch_location) AS BranchLocation
FROM Staging.branch;
