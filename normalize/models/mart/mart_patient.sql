with json_flatten
 as (select 
	 	name::json ->0-> 'given' ->0 as firstName,
 		name::json ->0-> 'given' -> 1 as middleName,
	 	name::json ->0-> 'family' as lastName,
	 	gender as gender,
	 	birthdate as birthDate,
	 	deceaseddatetime as deceasedDateTime,
	 	address::json ->0-> 'city' as city,
	 	address::json ->0-> 'line'->0 as street1,
	 	address::json ->0-> 'line'->1 as street2,
	 	address::json ->0-> 'state'  as state, 
	 	address::json ->0-> 'postalCode' as postalCode,
	 	extension::json ->0-> 'valueCoding'  -> 'display' as race
 	 from bcda_raw.patient
 )
 select replace(firstName::text,'"','') as firstName,
 		replace(middleName::text,'"','') as middleName,
		replace(lastName::text,'"','') as lastName,
		replace(gender::text,'"','') as gender,
		replace(birthDate::text,'"','') as birthDate,
		replace(deceasedDateTime::text,'"','') as deceasedDateTime,
		replace(city::text,'"','') as city,
		replace(street1::text,'"','') as street1,
		replace(street2::text,'"','') as street2,
		replace(state::text,'"','') as state, 
		replace(postalCode::text,'"','') as postalCode,
		replace(race::text,'"','') as race
	from 
		json_flatten