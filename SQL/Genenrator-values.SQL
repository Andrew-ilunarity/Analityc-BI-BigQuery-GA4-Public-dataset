create or replace view `analytic-project-498310`.Main.analytic_partly as
	SELECT 
--Генератоор рандомних значень для розрахунку ROMI--
		date,
		case 
			when mod(extract(day from date), 2) = 0 then 'google'
			else 'facebook'
		end as source,
		'cpc' as medium,
		case
			when mod(extract(day from date), 3) = 0 then 'other'
			else 'data N/A'
		end as campaign,
		round(60 + (mod(extract(day from date) * 7, 31)), 2) as cost
	from
		unnest(generate_date_array('2021-01-01','2021-01-31')) as date
;
