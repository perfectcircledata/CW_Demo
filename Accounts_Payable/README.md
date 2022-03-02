# Accounts_Payable

## Purpose
The purpose of this query to evaluate Accounts Payable.  This done by creating a table of invoices and then performing a union with a table of payments.  Entries without matching payments to invoices are open and thus Accounts Payable.

## Table View Schema
| table_catalog         | table_schema   | table_name       | column_name        | ordinal_position | is_nullable | data_type  |
|-----------------------|----------------|------------------|--------------------|------------------|-------------|------------|
| fort-operating-system | Data_Warehouse | Accounts_Payable | CTRL_No            | 1                | YES         | INT64      |
| fort-operating-system | Data_Warehouse | Accounts_Payable | Entity_Code        | 2                | YES         | STRING     |
| fort-operating-system | Data_Warehouse | Accounts_Payable | Entity_Name        | 3                | YES         | STRING     |
| fort-operating-system | Data_Warehouse | Accounts_Payable | Transaction_Type   | 4                | YES         | STRING     |
| fort-operating-system | Data_Warehouse | Accounts_Payable | Invoice_Id         | 5                | YES         | INT64      |
| fort-operating-system | Data_Warehouse | Accounts_Payable | Invoice_Number     | 6                | YES         | STRING     |
| fort-operating-system | Data_Warehouse | Accounts_Payable | Invoice_Date       | 7                | YES         | TIMESTAMP  |
| fort-operating-system | Data_Warehouse | Accounts_Payable | Posting_Date       | 8                | YES         | TIMESTAMP  |
| fort-operating-system | Data_Warehouse | Accounts_Payable | Transaction_Amount | 9                | YES         | FLOAT64    |

## Source Table Joins
| join      | table                   | on                     |   |                        |
|-----------|-------------------------|------------------------|---|------------------------|
| from      | yardi_TRANS             |                        |   |                        |
| left join | yardi_DETAIL            | yardi_DETAIL.HINVORREC | = | yardi_Trans.HMY        |
| left join | yardi_PERSON            | yardi_PERSON.HMY       | = | yardi_TRANS.HPERSON    |
| left join | yardi_PROPERTY          | yardi_PROPERY.HMY      | = | yardi_DETAIL.HPROP     |
| where     |                         | yardi_TRANS.iType      | = | 3                      |
| union all |                         |                        |   |                        |
| from      | yardi_TRANS             |                        |   |                        |
| left join | yardi_DETAIL            | yardi_DETAIL.HCKORCHG  | = | yardi_Trans.HMY        |
| left join | yardi_PERSON            | yardi_PERSON.HMY       | = | invoices.HPERSON       |
| left join | yardi_PROPERTY          | yardi_PROPERTY.HMY     | = | yardi_DETAIL.HPROP     |
| left join | yardi_TRANS as invoices | invoices.HMY           | = | yardi_DETAIL.HINVORREC |
| where     |                         | yardi_TRANS.iType      | = | 2                      |


## Indexes
*See yardi_TRANS notes*
| iType | pointer  |
|-------|----------|
| 2     | Checks   |
| 3     | Invoices |

## yardi_TRANS
*from Yardi Data Dictionary*

The TRANS table contains records that are logically different types. Currently there are 20 such types. They are linked to each other with their HPARENT1 and HPARENT2 pointers and they are linked to details with the details HCHKORCHG and HINVORREC. pointers. 1, 14, 16, 17, and 20 are unused. 2=checks, 3=invoices, 4=recurring invoices, 5=bank deposit, 6=receipt, 7=charge, 8=recurring charge, 9=Check Batch (International Only) 10=journal entry, 11=batch invoice, 12=batch receipt, 13=batch journal entry, 15=transaction in a batch, 16=batch charge, 18=bank adjustment, 19=recurring journal entry.

*Additional notes from Dokumen*

- Contains transaction header data
- The TRANS table is the ‘hub’ of all transactional data in the system.
- The transaction (TRANS) table contains header data for all transactions and also batch data. 
- The iType field in the TRANS table is used to identify the type of the record (Batch Header, Charge, Journal etc.)
- iType is set to 15 until AFTER the transaction is posted (important if you are reviewing un-posted transactions)

- Primary Key starts with the iType, then sequential number padded to 8 digits with ‘0’.

|    |            |                                    |           |
|----| ---------- | ---------------------------------- | --------- |
| C- |  iType = 7 | hmy = 7xxxxxxxx (i.e. 700000328)   | Ctrl#328  |
| J- | iType = 10 | hmy = 10xxxxxxxx (i.e. 1000004776) | Ctrl#4776 |

## Common Queries

<!-- 
## Links
--> 
