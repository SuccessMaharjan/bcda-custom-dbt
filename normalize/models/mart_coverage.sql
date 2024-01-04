with ctecoverage
as (
select id as iD,
		status as status,
		type::json -> 'coding' -> 0 -> 'code'  as actCode,
    relationship::json -> 'coding' -> 0 -> 'code' as subscriberRelationship,
    payor::json -> 0 -> 'identifier' -> 'value'  as payorIdentifier,
    meta::json -> 'profile'  as profile,
    meta::json -> 'lastUpdated' as lastUpdated,
  	beneficiary::json -> 'reference' as beneficiary,
  	class::json -> 0 -> 'value'  as coverageClassGroup,
  	class::json -> 1 -> 'value' as coverageClassplan,
  	extension::json -> 0 -> 'valueCoding' -> 'code' as ms_cd_code,
		extension::json -> 0 -> 'valueCoding' -> 'display' as ms_cd_displayName,
  	extension::json -> 1 -> 'valueCoding' -> 'code' as orec_code,
		extension::json -> 1 -> 'valueCoding' -> 'display' as orec_displayName
from bcda_fhir_raw.coverage
  )
  select id::text, 
  			status::text,
        replace(actCode::text,'"','') as actCode,
        replace(subscriberRelationship::text,'"','') as subscriberRelationship,
        substring(profile::text from 'C4BB-Coverage') as profile,
        replace(lastUpdated::text,'"','') as lastUpdated,
        replace(beneficiary::text,'"','') as beneficiary,
        replace(coverageClassGroup::text,'"','') as coverageClassGroup,
        replace(coverageClassplan::text,'"','') as coverageClassPlan,
        replace(ms_cd_code::text,'"','') as ms_cd_code,
        replace(ms_cd_displayName::text,'"','') as ms_cd_displayName,
        replace(orec_code::text,'"','') as orec_code,
        replace(orec_displayName::text,'"','') as orec_displayName
  from ctecoverage