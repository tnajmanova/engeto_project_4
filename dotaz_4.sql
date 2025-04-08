-- 4. otázka: Existuje rok, ve kterém byl meziroční nárůst cen potravin výrazně vyšší než růst mezd (větší než 10 %)?

create or replace view v_porovnani_prum_mezd as (
	with prum_mzdy_v_letech as (
		select
			mzdy_rok as rok,
			round(avg(hruba_mzda)) as prumerna_mzda
		from t_tereza_najmanova_project_sql_primary_final
		group by mzdy_rok
		order by rok 
		)
	select 
		*,
		lag(prumerna_mzda) over (order by rok) as predchozi_mzda,
		(prumerna_mzda - lag(prumerna_mzda) over (order by rok)) / lag(prumerna_mzda) over (order by rok) * 100 as mzdy_rozdil
	from prum_mzdy_v_letech 
);

create or replace view v_porovnani_prum_cen as (
	with prum_ceny_v_letech as (
		select
			produkt_rok,
			round(avg(cena), 2) as prumerna_cena
		from t_tereza_najmanova_project_sql_primary_final
		group by produkt_rok
		order by produkt_rok
		)
	select 
		*,
		lag(prumerna_cena) over (order by produkt_rok) as predchozi_cena,
		(prumerna_cena - lag(prumerna_cena) over (order by produkt_rok)) / lag(prumerna_cena) over (order by produkt_rok) * 100 as ceny_rozdil
	from prum_ceny_v_letech
	)

create or replace view v_meziroc_proc_rozdil_cen_mezd as (
	select 
		rok,
		round(ceny_rozdil, 2) as meziroc_proc_rozdil_ceny,
		round(mzdy_rozdil, 2) as meziroc_proc_rozdil_mzdy,
		abs(round((mzdy_rozdil - ceny_rozdil), 2)) proc_rozdil_ceny_a_mzdy
	from v_porovnani_prum_mezd m 
	join v_porovnani_prum_cen c
		on m.rok = c.produkt_rok
) ;

select *
from v_meziroc_proc_rozdil_cen_mezd ;

/*
Odpověď na otázku: Ve sledovaném období se nevyskytuje rok, kdy by nárůst cen o 10 % vyšší jak nárůst mezd. 

Pozn.:
Největší rozdíl byl v roce 2009, kdy byl naopak nárůst mezd skoro o 10 % větší oproti cenám potravin.
Zajímavý je rok 2013, kdy se procentualně více zdražilo, ale mzdy klesaly.
*/
