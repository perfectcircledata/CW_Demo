with
imports as (
    -- REDACTED
    ) a
),

accounts as (
  -- REDACTED
),

yardi_PROPERTY as (
  -- REDACTED
),

entity_codes as (
  -- REDACTED
),

entities as (
  -- REDACTED
),

months as (
  -- REDACTED
),

yardi_ACCT as (
  -- REDACTED
)

select
  -- months.Month as Month
  date_add(date_add(months.Month, interval 1 month), interval -1 day) as Month
  ,entities.Code as Entity_Code
  ,entities.Name as Entity_Name
  ,case when trim(entities.Code) = -- REDACTED
  ,accounts.Number as Account_Number
  ,accounts.Name as Account_Name
  ,accounts.Type as Account_Type
  -- ,accounts.Fixed
  ,case 
   -- REDACTED
  ,accounts.Totals_Description as Account_Totals_Description
  ,accounts.Totals_00 as Account_Totals_00
  ,accounts.Totals_01 as Account_Totals_01
  ,accounts.Totals_02 as Account_Totals_02
  ,accounts.Totals_03 as Account_Totals_03
  ,accounts.Totals_04 as Account_Totals_04
  ,accounts.Totals_05 as Account_Totals_05

  ,-- REDACTED



from accounts
-- REDACTED

left join -- REDACTED

left join -- REDACTED

where -- REDACTED

group by
  -- REDACTED
