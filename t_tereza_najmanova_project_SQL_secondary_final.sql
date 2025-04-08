/*
2. tabulka t_{jmeno}_{prijmeni}_project_SQL_secondary_final (pro dodatečná data o dalších evropských státech).

Jako dodatečný materiál připravte i tabulku s HDP, GINI koeficientem a populací dalších evropských států ve stejném období, 
jako primární přehled pro ČR. 
*/

create table t_tereza_najmanova_project_SQL_secondary_final as (
	select 
		e.country, 
		e.year,
		e.gdp,
		e.gini,
		e.population
	from economies e 
	left join countries c
		on e.country = c.country
	where c.continent = 'Europe'
		and year between 2006 and 2018
	order by country, year
) ;

select *
from t_tereza_najmanova_project_SQL_secondary_final ;
