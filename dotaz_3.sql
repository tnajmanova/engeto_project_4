-- 3. Otázka: Která kategorie potravin zdražuje nejpomaleji (je u ní nejnižší percentuální meziroční nárůst)?

with ceny_v_letech as (
	select
		distinct produkt,
		produkt_rok as rok,
		cena as aktualni_cena
	from t_tereza_najmanova_project_sql_primary_final
	where produkt_rok in (2006, 2018)
	order by produkt, rok
	)
select 
	*,
	lag(aktualni_cena) over (partition by produkt order by rok) as predchozi_cena,
	(aktualni_cena - lag(aktualni_cena) over (partition by produkt order by rok)) / lag(aktualni_cena) over (partition by produkt order by rok) * 100 as procentualni_rozdil
from ceny_v_letech ;

/*
V procentuálním porovnání cen mezi roky 2006 a 2018 nejpomaleji zdražují Banány, a to cca o 7,5 %.
Naopak cukr nejvíce zlevnil a to o 27,5 %.

Všímám si ale, že pro bílé víno chybí data pro rok 2006, takže si udělám podrobnější analýzu:
*/

with ceny_vino as (
	select
		distinct produkt,
		produkt_rok as rok,
		cena as aktualni_cena
	from t_tereza_najmanova_project_sql_primary_final
	where produkt = 'Jakostní víno bílé'
		and produkt_rok in (
			(select min(produkt_rok)
			from t_tereza_najmanova_project_sql_primary_final
			where produkt = 'Jakostní víno bílé'),
			(select max(produkt_rok)
			from t_tereza_najmanova_project_sql_primary_final)
		)
	)
select 
	*,
	lag(aktualni_cena) over (order by rok) as predchozi_cena,
	(aktualni_cena - lag(aktualni_cena) over (order by rok)) / lag(aktualni_cena) over (order by rok) * 100 as procentualni_rozdil
from ceny_vino ;

/*
Víno mezi roky 2015 a 2018 zdražilo o 8,5 %, což je nepatrně více než banány. 

Odpověd na otázku: Banány žluté zdražují mezi roky 2006 a 2018 nejpomaleji, a to o 7,5 %
*/
