/*
5. otázka: Má výška HDP vliv na změny ve mzdách a cenách potravin? Neboli, pokud HDP vzroste výrazněji v jednom roce, 
projeví se to na cenách potravin či mzdách ve stejném nebo následujícím roce výraznějším růstem?
*/

with meziroc_proc_rozdil_hdp as (
	select 
		year as rok,
		gdp as hdp,
		lag(gdp) over (order by year) as predchozi_hdp,
		(gdp - lag(gdp) over (order by year)) / lag(gdp) over (order by year) * 100 as proc_rozdil_hdp
	from t_tereza_najmanova_project_SQL_secondary_final
	where country = 'Czech Republic' )
select
	h.rok,
	round(h.proc_rozdil_hdp:: numeric, 2) as meziroc_proc_rozdil_hdp,
	cm.meziroc_proc_rozdil_ceny,
	cm.meziroc_proc_rozdil_mzdy
from meziroc_proc_rozdil_hdp h
join v_meziroc_proc_rozdil_cen_mezd cm
	on h.rok = cm.rok ;

/*
Odpověď na otázku: Nevidím žádný očividný vztah, kdy by při vyšším nárůstu HDP (např. o více jak 5%) 
výrazněji rostly ceny či mzdy oproti jiným rokům, kdy růst HDP nebyl tak vysoký.
*/

