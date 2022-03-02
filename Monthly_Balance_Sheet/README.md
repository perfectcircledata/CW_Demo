# Monthly_Balance_Sheet

## Purpose
The purpose of the Monthly_Balance_Sheet is to recreate the Monthly Balance Sheet in Yardi.  This view omits Current Earnings 3850.0000 from the report (these values are reported in Monthly_Balance_Sheet_CE by request). Amounts are gathered from `fort-operating-system.Data_Warehouse.General_Ledger_Entries`.  General_Ledger_Entries is built using `fort-operating-system.Data_Warehouse_Staging.GLDETAIL`.  Issues in Monthly_Balance_Sheet will need to be checked in these two tables as well.  

## Table View Schema
| table_catalog         | table_schema   | table_name            | column_name                | ordinal_position | is_nullable | data_type  |
|-----------------------|----------------|-----------------------|----------------------------|------------------|-------------|------------|
| fort-operating-system | Data_Warehouse | Monthly_Balance_Sheet | Month                      | 1                | YES         | DATE       |
| fort-operating-system | Data_Warehouse | Monthly_Balance_Sheet | Entity_Code                | 2                | YES         | STRING     |
| fort-operating-system | Data_Warehouse | Monthly_Balance_Sheet | Entity_Name                | 3                | YES         | STRING     |
| fort-operating-system | Data_Warehouse | Monthly_Balance_Sheet | Corporate                  | 4                | YES         | BOOL       |
| fort-operating-system | Data_Warehouse | Monthly_Balance_Sheet | Account_Number             | 5                | YES         | STRING     |
| fort-operating-system | Data_Warehouse | Monthly_Balance_Sheet | Account_Name               | 6                | YES         | STRING     |
| fort-operating-system | Data_Warehouse | Monthly_Balance_Sheet | Account_Type               | 7                | YES         | STRING     |
| fort-operating-system | Data_Warehouse | Monthly_Balance_Sheet | Fixed                      | 8                | YES         | BOOL       |
| fort-operating-system | Data_Warehouse | Monthly_Balance_Sheet | Account_Totals_Description | 9                | YES         | STRING     |
| fort-operating-system | Data_Warehouse | Monthly_Balance_Sheet | Account_Totals_00          | 10               | YES         | STRING     |
| fort-operating-system | Data_Warehouse | Monthly_Balance_Sheet | Account_Totals_01          | 11               | YES         | STRING     |
| fort-operating-system | Data_Warehouse | Monthly_Balance_Sheet | Account_Totals_02          | 12               | YES         | STRING     |
| fort-operating-system | Data_Warehouse | Monthly_Balance_Sheet | Account_Totals_03          | 13               | YES         | STRING     |
| fort-operating-system | Data_Warehouse | Monthly_Balance_Sheet | Account_Totals_04          | 14               | YES         | STRING     |
| fort-operating-system | Data_Warehouse | Monthly_Balance_Sheet | Account_Totals_05          | 15               | YES         | STRING     |
| fort-operating-system | Data_Warehouse | Monthly_Balance_Sheet | Amount                     | 16               | YES         | FLOAT64    |

## Source Table Joins
| join       | table                        | on                             |   |                 |
|------------|------------------------------|--------------------------------|---|-----------------|
| from       | accounts                     |                                |   |                 |
| cross join | months                       |                                |   |                 |
| cross join | entities                     |                                |   |                 |
| left join  | General_Ledger_Entries as gl | cast(gl.Posting_Date as date)  | < | months.Month    |
|            | and                          | gl.Entity_Code                 | = | entities.Code   |
|            | and                          | gl.Account_Number              | = | accounts.Number |

## Indexes
| iType | Pointer       |
|-------|---------------|
| 2     | Check         |
| 3     | Payable       |
| 6     | Receipt       |
| 7     | Charge        |
| 10    | Journal Entry |

## yardi_GLDETAIL
*from Yardi Data Dictionary*

This Expands The Detail Table To Show Both The Debit And Credit Sides Of Each Transaction By Book.

*Additional notes from Dokumen*

- The GLDETAIL table was introduced in Voyager 6.0 to allow for faster report processing of G/L activity.
- When transactions are posted, a GLDETAIL record is created for each Debit/Credit made to the general ledger.
- The GLDETAIL table is indexed to provide optimal searching efficiency, only holding pertinent information.
- While TRANS and DETAIL tables hold raw data, the GLDETAIL table is the expanded result of the TRANS/DETAIL tables, showing the posted transactions impact on the general ledger.
- One TRANS record or one DETAIL record will create multiple GLDETAIL records depending on transaction type
- Key columns for filtering are hProp, hAcct, iBook, and dtPost
- Key columns for selection are dAmount, sTranNum, hPerson, sRef, sNotes, dtDate
- iBook: 0 is Cash, 1 is Accrual
- Other books: only on JE
- No iBook of 1000 in GLDetail table
- Detail table contains the line item details of transactions
- Charges are unusual in that they are stored in only the Trans table. Other transactions (Receipt, Payable, Payment, Journal) have records in the Detail table.
- Primary key is sequential number
- Foreign Key(s) – hInvOrRec / hChkOrChg point to hmy of Trans table

## Common Queries
To view Monthly_Balance_Sheet by Entity and Period:
```
select *
from `fort-operating-system.Data_Warehouse.Monthly_Balance_Sheet`
where Entity_Code = '[ENTITY_CODE]'
and Month = '[LAST_DATE_OF_MONTH]'
order by Account_Number asc
```

To view balance of single account across all months, most recent first:
```
select *
from `fort-operating-system.Data_Warehouse.Monthly_Balance_Sheet`
where Entity_Code = '[ENTITY_CODE]'
and Account_Number = '[ACCOUNT_NUMBER]'
order by Month desc
```
