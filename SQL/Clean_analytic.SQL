SELECT
--Приводить всі дати до 1 виду і змінює тип рядку--
parse_date('%Y%m%d', event_date) as date,
--Всі ці конструкції фільтрують значення та запобігають дублям--
	case
  		when lower(traffic_source.source) in ('(not set)', '(direct)') then 'direct'
  		when lower(traffic_source.source) = '(data deleted)' then 'data N/A'
  		when lower(traffic_source.source) = '<other>' then 'other'
  		else lower(traffic_source.source)
 	end AS source,
  ----
 	case
  		when lower(traffic_source.medium) in ('(not set)', '(none)') then 'none'
  		when lower(traffic_source.medium) = '(data deleted)' then 'data N/A'
  		when lower(traffic_source.medium) = '<other>' then 'other'
  		else lower(traffic_source.medium)
  	end AS medium,
  ----
  	case
  		when lower(traffic_source.name) in ('(not set)', '(direct)') then 'direct'
  		when lower(traffic_source.name) = '(organic)' then 'organic'
  		when lower(traffic_source.name) = '(referral)' then 'referral'
  		when lower(traffic_source.name) = '(data deleted)' then 'data N/A'
  		when lower(traffic_source.name) = '<other>' then 'other'
  		else lower(traffic_source.name)
 	end AS campaign,	
	--
	case
		when lower(geo.sub_continent) in( '(not set)','unknown') then 'unknown'
		when lower(geo.sub_continent) = '<other>' then 'other'
		else lower(geo.sub_continent)
	end as continent,
	--
	case
		when lower(geo.country) in( '(not set)','unknown') then 'unknown'
		when lower(geo.country) = '<other>' then 'other'
		else lower(geo.country)
	end as country,
  	 --
	case
		when lower(geo.city) in( '(not set)','unknown') then 'unknown'
		when lower(geo.city) = '<other>' then 'other'
		else lower(geo.city)
	end as city,
  	--
	case
		when lower(device.operating_system) in( '(not set)','unknown') then 'unknown'
		when lower(device.operating_system) = '<other>' then 'other'
		else lower(device.operating_system)
	end as OC,
  	--Фільтр значень NULL і розрахунок виручки--
  	coalesce(ecommerce.purchase_revenue, 0) as revenue
FROM 
  `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`
--Базовий фільтр за датою і статусом--
where event_name = 'purchase'
	and _table_suffix between '20210101' AND '20210131' 
order by `date` asc
;
