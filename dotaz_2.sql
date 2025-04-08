-- 2. otázka: Kolik je možné si koupit litrů mléka a kilogramů chleba za první a poslední srovnatelné období v dostupných datech cen a mezd?  

with vypocet_jednotek_odvetvi as ( -- CTE pro výpočet jednotek za jednotlivá období:
	select 
		distinct produkt,
		mzdy_rok as rok,
		cena,
		odvetvi,
		hruba_mzda,
		round(hruba_mzda / cena) as pocet_jednotek
	from t_tereza_najmanova_project_sql_primary_final
	where produkt in ('Chléb konzumní kmínový', 'Mléko polotučné pasterované')
	order by rok, hruba_mzda 
)
select  -- výpočet průměru počtu jednotek za veškerá odvětví za 2006 a 2008
	produkt,
	rok,
	round(avg(pocet_jednotek)) as pocet_jednotek
from vypocet_jednotek_odvetvi
where rok in (2006, 2018)
group by produkt, rok
order by rok ;

/*
Odpověď na otázky:
v roce 2006 bylo možné si za průměrný hrubý měsíční příjem koupit 1287 kg chleba a 1437 l mléka.
v roce 2018 bylo možné si za průměrný hrubý měsíční příjěm koupit 1342 kg chleba a 1642 l mléka.
*/
