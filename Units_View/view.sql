with
imports as (
    -- REDACTED
    ) a
),

yardi_UNIT as (
  -- REDACTED
),

yardi_BUILDING as (
  -- REDACTED
),

yardi_PROPERTY as (
  -- REDACTED
),

yardi_TENANT as (
  -- REDACTED
),

yardi_unitxref as (
  -- REDACTED
),

yardi_CommAmendments as (
  -- REDACTED
),

yardi_CommLeaseType as (
    -- REDACTED
),

yardi_CommTenant as (
    -- REDACTED
),

yardi_Sqft as (
  -- REDACTED
),

yardi_Camrule as (
  -- REDACTED
),

amendments as (
    -- REDACTED
)


select
  --Property
  trim(yardi_PROPERTY.SCODE) as Property_Code
  ,yardi_UNIT.SCODE as Unit_Name
  ,yardi_PROPERTY.SADDR1 as Property_Name
  ,yardi_UNIT.HMY as Unit_Id
  
  --Tenant
  -- REDACTED
  
  --Lease Info
  ,(
		-- REDACTED
    ) as Lease_Type
  ,yardi_Sqft.DSQFT0 as Leased_Square_Feet
  
  --Renewal
  ,case amendments.iType 
    -- REDACTED
  
  --Status
  ,case amendments.iStatus 
    -- REDACTED
    else 'VACANT' end as Status

  --Dates
  ,cast(-- REDACTED) as Lease_Start
  ,cast(-- REDACTED) as Lease_End  
  ,amendments.iTerm as Term
  
  -- Rent
  ,amendments.DESTIMATED as Monthly_Amount
  ,amendments.DESTIMATED * 12 as Annual_Amount

  --Vacant
  ,case 
    -- REDACTED
    else false end as Vacant
  
  --Leased
  ,case 
    -- REDACTED
    else FALSE end as Leased
  

from yardi_UNIT

left join yardi_BUILDING
  -- REDACTED

left join amendments 
  -- REDACTED 

left join yardi_Sqft
  -- REDACTED

left join yardi_PROPERTY
  -- REDACTED
  
left join yardi_TENANT
  -- REDACTED

left join yardi_CommTenant 
  -- REDACTED

where yardi_PROPERTY.ITYPE = X  -------------------------------filter onto only actual properties
  and (amendments.iStatus = X or amendments.iStatus is null)
  and trim(yardi_PROPERTY.SCODE) in ( -------------------------Active Properties,this will need to be continually updated until list created to filter on properties in query GRT
  -- REDACTED
)
