-- 1. otázka: Rostou v průběhu let mzdy ve všech odvětvích, nebo v některých klesají?

create or replace view v_vyhodnoceni_mezd as (
	with porovnani_mezd as (
		select 
			distinct odvetvi,
			mzdy_rok as rok,
			avg(hruba_mzda) as prum_hruba_mzda,
			lag(hruba_mzda) over (partition by odvetvi order by mzdy_rok) as predchozi_mzda
		from t_tereza_najmanova_project_SQL_primary_final
		group by odvetvi, mzdy_rok, hruba_mzda
	)
	select 
		odvetvi,
		rok,
		prum_hruba_mzda,
		case 
			when prum_hruba_mzda > predchozi_mzda then 'meziroční růst'
			when predchozi_mzda is null then '-'		
			else 'meziroční pokles'
		end as porovnani_mezd
	from porovnani_mezd
	order by odvetvi, rok
);

select *
from v_vyhodnoceni_mezd;

select 
	count(distinct odvetvi)
from v_vyhodnoceni_mezd 
where porovnani_mezd = 'meziroční pokles' ;

select *
from v_vyhodnoceni_mezd 
where porovnani_mezd = 'meziroční pokles' ;

/*
Odpověď na otázku: Bylo celkem 15 odvětví, které mezi roky 2006 a 2018 zažili propad mezd.

pozn.: Při bližším zkoumání si všímám:
	1) častého výskytu poklesu mezd napříč odvětvími v roce 2013
	2) odvětví, které čelilo nejčastěji poklesu (4x) je Těžba a dobývání 
*/
