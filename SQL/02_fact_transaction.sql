CREATE OR REPLACE TABLE DWH.FactTransaction AS

SELECT DISTINCT
    transaction_id AS TransactionID,
    account_id AS AccountID,
    transaction_date AS TransactionDate,
    amount AS Amount,
    UPPER(transaction_type) AS TransactionType,
    branch_id AS BranchID

FROM (

    SELECT * FROM Staging.transaction_db

    UNION ALL

    SELECT * FROM Staging.transaction_csv

    UNION ALL

    SELECT * FROM Staging.transaction_excel

);
