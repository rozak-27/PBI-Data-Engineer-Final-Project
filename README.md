# PBI-Data-Engineer-Final-Project

# Banking Data Warehouse using Google BigQuery

## Project Overview

This project was developed as part of the **ID/X Partners Data Engineer Final Task**. The objective of the project is to build a centralized Banking Data Warehouse that integrates transaction data from multiple sources and provides analytical reporting capabilities.

The solution was implemented using **Google BigQuery** as the Data Warehouse platform. Data from Excel files, CSV files, and SQL Server databases were consolidated into a single analytical environment to improve reporting efficiency and support business decision-making.

---

## Business Problem

A banking organization stores data across multiple systems, including Excel files, CSV files, and SQL Server databases. Due to the fragmented data sources, reporting and analytical processes become inefficient and time-consuming.

To address this challenge, a centralized Data Warehouse was designed and implemented to integrate data from different sources into a unified data model.

---

## Data Sources

### File Sources

* transaction_excel.xlsx
* transaction_csv.csv

### SQL Server Sources

* transaction_db
* account
* customer
* branch
* city
* state

---

## Architecture

```text
Excel File
            \
             \
CSV File -----> Staging Layer -----> Data Warehouse -----> Analytics & Reporting
             /
            /
SQL Server
```

---

## Data Warehouse Design

### Staging Layer

The staging layer stores raw data extracted from all source systems:

* account
* customer
* branch
* city
* state
* transaction_db
* transaction_csv
* transaction_excel

### Dimension Tables

#### DimAccount

Stores account-related information.

Columns:

* AccountID
* CustomerID
* AccountType
* Balance
* DateOpened
* Status

#### DimCustomer

Stores customer information.

Columns:

* CustomerID
* CustomerName
* Address
* CityName
* StateName
* Age
* Gender
* Email

#### DimBranch

Stores branch information.

Columns:

* BranchID
* BranchName
* BranchLocation

### Fact Table

#### FactTransaction

Stores all transaction records integrated from multiple sources.

Columns:

* TransactionID
* AccountID
* TransactionDate
* Amount
* TransactionType
* BranchID

---

## ETL Process

### Dimension Table ETL

The ETL process transforms raw data from staging tables into dimension tables.

Transformations performed:

* Data standardization using UPPER()
* Column renaming using PascalCase naming convention
* Duplicate removal using DISTINCT
* Customer dimension enrichment using city and state tables

### Fact Table ETL

Transaction data from three different sources were combined using:

```sql
UNION ALL
```

Duplicate transaction records were removed using:

```sql
DISTINCT
```

The final dataset was loaded into the FactTransaction table.

---

## Stored Procedures

### DailyTransaction

Calculates daily transaction activity within a selected date range.

Parameters:

* start_date
* end_date

Output:

* Date
* TotalTransactions
* TotalAmount

### BalancePerCustomer

Calculates customer balances based on transaction history.

Parameters:

* name

Output:

* CustomerName
* AccountType
* Balance
* CurrentBalance

Business Logic:

* Deposit transactions increase balance.
* Other transaction types decrease balance.
* Only active accounts are included.

---

## Technologies Used

* Google BigQuery
* SQL Server
* SQL Server Management Studio (SSMS)
* SQL
* Microsoft Excel
* GitHub

---

## Project Results

The project successfully delivered:

* Centralized Banking Data Warehouse
* Multi-source data integration
* Data cleansing and transformation
* Duplicate transaction handling
* Dimension and fact table implementation
* Analytical stored procedures
* Business-ready reporting environment

---

## Repository Structure

```text
idx-partners-data-warehouse/
│
├── sql/
│   ├── 01_dimension_tables.sql
│   ├── 02_fact_transaction.sql
│   └── 03_stored_procedures.sql
│
├── presentation/
│
└── README.md
```

---

## Author

Rozak Limbong

Data Engineer Virtual Internship Experience Program (VIX)

ID/X Partners x Rakamin Academy
