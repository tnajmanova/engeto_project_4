/*
1. tabulka t_{jmeno}_{prijmeni}_project_SQL_primary_final 
(pro data mezd a cen potravin za Českou republiku sjednocených na totožné porovnatelné období – společné roky) 
*/

create table t_tereza_najmanova_project_SQL_primary_final as (
	select *
	from (
		select 
			cpc.name as produkt,
			round(avg(cp.value):: numeric, 2) as cena, -- průměr cen napříč regiony
			date_part('year', cp.date_from) as produkt_rok
		from czechia_price cp 
		left join czechia_price_category cpc 
			on cp.category_code = cpc.code
		group by 
			cpc.name, 
			date_part('year', cp.date_from)
		order by produkt_rok -- zjistím že data jsou za období 2006 - 2018  
		)
	join (
		select 
			cpib.name as odvetvi,	
			round(avg(cp.value):: numeric) as hruba_mzda, -- průměr mezd napříč kvartály
			cp.payroll_year as mzdy_rok
		from czechia_payroll cp 
		left join czechia_payroll_industry_branch cpib 
			on cp.industry_branch_code = cpib.code
		where 
			value_type_code = '5958' -- přes ERD diagram odkazující na tab czechia_payroll_value_type vyhledám kód pro "Průměrná hrubá mzda na zaměstnance"
			and industry_branch_code is not null
		group by cpib.name, cp.payroll_year
		order by odvetvi, mzdy_rok
		)
	on produkt_rok = mzdy_rok 
);

select *
from t_tereza_najmanova_project_sql_primary_final ;
