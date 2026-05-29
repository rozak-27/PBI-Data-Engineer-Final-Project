-- =========================================
-- STORED PROCEDURE: DailyTransaction
-- =========================================

CREATE OR REPLACE PROCEDURE DWH.DailyTransaction(
    start_date DATE,
    end_date DATE
)
BEGIN

SELECT
    DATE(TransactionDate) AS Date,
    COUNT(TransactionID) AS TotalTransactions,
    SUM(Amount) AS TotalAmount

FROM DWH.FactTransaction

WHERE DATE(TransactionDate)
BETWEEN start_date AND end_date

GROUP BY Date
ORDER BY Date;

END;


-- =========================================
-- STORED PROCEDURE: BalancePerCustomer
-- =========================================

CREATE OR REPLACE PROCEDURE DWH.BalancePerCustomer(name STRING)
BEGIN

SELECT
    dc.CustomerName,
    da.AccountType,
    da.Balance,

    da.Balance +
    SUM(
        CASE
            WHEN UPPER(TRIM(ft.TransactionType)) = 'DEPOSIT'
            THEN ft.Amount
            ELSE -ft.Amount
        END
    ) AS CurrentBalance

FROM DWH.FactTransaction ft

JOIN DWH.DimAccount da
ON ft.AccountID = da.AccountID

JOIN DWH.DimCustomer dc
ON da.CustomerID = dc.CustomerID

WHERE UPPER(TRIM(dc.CustomerName))
LIKE CONCAT('%', UPPER(TRIM(name)), '%')

AND UPPER(TRIM(da.Status)) = 'ACTIVE'

GROUP BY
    dc.CustomerName,
    da.AccountType,
    da.Balance

ORDER BY CurrentBalance DESC;

END;
