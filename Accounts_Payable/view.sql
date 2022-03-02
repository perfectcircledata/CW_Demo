with
imports as (
    select
        -- CTE REDACTED

    from (
        -- CTE REDACTED
    ) a
),

yardi_TRANS as (
  -- CTE REDACTED
),

yardi_DETAIL as (
  -- CTE REDACTED
),

yardi_PERSON as (
  -- CTE REDACTED
),

yardi_PROPERTY as (
  -- CTE REDACTED
)

select
  yardi_TRANS.HMY - 300000000 as CTRL_No
  ,trim(yardi_PROPERTY.SCODE) as Entity_Code
  ,trim(yardi_PROPERTY.SADDR1) as Entity_Name
  ,'invoice' as Transaction_Type
  ,yardi_DETAIL.HINVORREC as Invoice_Id
  ,yardi_TRANS.UREF as Invoice_Number
  ,yardi_TRANS.SDATEOCCURRED as Invoice_Date
  ,yardi_TRANS.UPOSTDATE as Posting_Date
  ,yardi_DETAIL.SAMOUNT as Transaction_Amount
  ,yardi_DETAIL.SAMOUNT as Transaction_Amount_Adj
  ,case when yardi_TRANS.BOPEN = -1 then true else false end as Open
  ,case when yardi_TRANS.VOID = -1 then true else false end as Void
  ,trim(yardi_PERSON.ucode) as Payee_Code
  ,trim(yardi_PERSON.ULASTNAME) as Payee_Name
  ,yardi_TRANS.SDATECREATED as Create_Date
  ,yardi_TRANS.SDATEMODIFIED as Modified_Date
  ,yardi_DETAIL.SNOTES as Notes
  ,yardi_TRANS.sMemo as Memo
  
from yardi_TRANS

left join yardi_PERSON
  -- REDACTED

left join yardi_DETAIL
  -- REDACTED

left join yardi_PROPERTY
  -- REDACTED

where yardi_TRANS.iType = X


union all


select
  yardi_TRANS.HMY - 200000000 as CTRL_No
  ,trim(yardi_PROPERTY.SCODE) as Entity_Code
  ,trim(yardi_PROPERTY.SADDR1) as Entity_Name
  ,'payment' as Transaction_Type
  ,yardi_DETAIL.HINVORREC as Invoice_Id
  ,invoices.UREF as Invoice_Number
  ,invoices.SDATEOCCURRED as Invoice_Date
  ,yardi_TRANS.UPOSTDATE as Posting_Date
  ,yardi_DETAIL.SAMOUNT as Transaction_Amount
  ,yardi_DETAIL.SAMOUNT * -1 as Transaction_Amount_Adj
  ,case when yardi_TRANS.BOPEN = -1 then true else false end as Open
  ,case when yardi_TRANS.VOID = -1 then true else false end as Void
  ,trim(yardi_PERSON.ucode) as Payee_Code
  ,trim(yardi_PERSON.ULASTNAME) as Payee_Name
  ,yardi_TRANS.SDATECREATED as Create_Date
  ,yardi_TRANS.SDATEMODIFIED as Modified_Date
  ,yardi_DETAIL.SNOTES as Notes
  ,yardi_TRANS.sMemo as Memo
--   ,yardi_DETAIL.*
--   ,yardi_TRANS.*
  
from yardi_TRANS

left join yardi_DETAIL
  -- REDACTED

left join yardi_PROPERTY
  -- REDACTED

left join yardi_TRANS as invoices
  -- REDACTED

left join yardi_PERSON
  -- REDACTED

where yardi_TRANS.iType = X
