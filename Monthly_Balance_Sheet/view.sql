with
imports as (
    select
        -- REDACTED

    from (
        -- REDACTED
    ) a
),

accounts as (
  -- REDACTED
),

yardi_PROPERTY as (
  -- REDACTED
),

nav_DimensionValue as (
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
)

select
  date_add(months.Month, interval -1 day) as Month
  ,entities.Code as Entity_Code
  ,entities.Name as Entity_Name
  ,case when trim(entities.Code) = '1001' then true else false end as Corporate
  ,accounts.Number as Account_Number
  ,accounts.Name as Account_Name
  ,accounts.Type as Account_Type
  ,accounts.Fixed
  ,accounts.Totals_Description as Account_Totals_Description
  ,accounts.Totals_00 as Account_Totals_00
  ,accounts.Totals_01 as Account_Totals_01
  ,accounts.Totals_02 as Account_Totals_02
  ,accounts.Totals_03 as Account_Totals_03
  ,accounts.Totals_04 as Account_Totals_04
  ,accounts.Totals_05 as Account_Totals_05

  ,sum(case 
    -- REDACTED
  
from accounts
-- REDACTED

left join -- REDACTED

where -- REDACTED

group by
  -- REDACTED
