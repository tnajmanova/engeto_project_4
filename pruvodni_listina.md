##Průvodní listina
V rámci projektu byly vytvořeny dvě tabulky s příslušnými daty pro odpovědi výzkumných otázek:

1. t_tereza_najmanova_project_SQL_primary_final (pro data mezd a cen potravin za Českou republiku sjednocených na totožné porovnatelné období – společné roky) 
2. t_tereza_najmanova_project_SQL_secondary_final (pro dodatečná data o dalších evropských státech).

pro postupné zodpovězení otázek byly vytvořeny následující views:
- v_vyhodnoceni_mezd
- v_porovnani_prum_mezd
- v_porovnani_prum_cen
- v_meziroc_proc_rozdil_cen_mezd

##Výzkumné otázky:
1. Rostou v průběhu let mzdy ve všech odvětvích, nebo v některých klesají?
2. Kolik je možné si koupit litrů mléka a kilogramů chleba za první a poslední srovnatelné období v dostupných datech cen a mezd?
3. Která kategorie potravin zdražuje nejpomaleji (je u ní nejnižší percentuální meziroční nárůst)?
4. Existuje rok, ve kterém byl meziroční nárůst cen potravin výrazně vyšší než růst mezd (větší než 10 %)?
5. Má výška HDP vliv na změny ve mzdách a cenách potravin? Neboli, pokud HDP vzroste výrazněji v jednom roce, projeví se to na cenách potravin či mzdách ve stejném nebo následujícím roce výraznějším růstem?

Původní zadání je k dispozici jako poslední kapitola tohoto dokumentu.

### 1. otázka: Rostou v průběhu let mzdy ve všech odvětvích, nebo v některých klesají?

*Odpověď na otázku:* Bylo celkem 15 odvětví, které mezi roky 2006 a 2018 zažili propad mezd.

Pozn.: Při bližším zkoumání si všímám:
1. častého výskytu poklesu mezd napříč odvětvími v roce 2013
2. odvětví, které čelilo nejčastěji poklesu (4x) je Těžba a dobývání

###2. otázka: Kolik je možné si koupit litrů mléka a kilogramů chleba za první a poslední srovnatelné období v dostupných datech cen a mezd?  

*Odpověď na otázky:*
v roce 2006 bylo možné si za průměrný hrubý měsíční příjem koupit 1287 kg chleba a 1437 l mléka.
v roce 2018 bylo možné si za průměrný hrubý měsíční příjěm koupit 1342 kg chleba a 1642 l mléka.

### 3. otázka: Která kategorie potravin zdražuje nejpomaleji (je u ní nejnižší percentuální meziroční nárůst)?

*Odpověď na otázku:* Banány žluté zdražují mezi roky 2006 a 2018 nejpomaleji, a to o 7,5 %

Pozn.: Víno mezi roky 2015 a 2018 zdražilo o 8,5 %, což je nepatrně více než banány.

### 4. otázka: Existuje rok, ve kterém byl meziroční nárůst cen potravin výrazně vyšší než růst mezd (větší než 10 %)?

*Odpověď na otázku:* Ve sledovaném období se nevyskytuje rok, kdy by nárůst cen o 10 % vyšší jak nárůst mezd.

Pozn.: Největší rozdíl byl v roce 2009, kdy byl naopak nárůst mezd skoro o 10 % větší oproti cenám potravin. Zajímavý je rok 2013, kdy se procentualně více zdražilo, ale mzdy klesaly.

### 5. otázka: Má výška HDP vliv na změny ve mzdách a cenách potravin? Neboli, pokud HDP vzroste výrazněji v jednom roce, projeví se to na cenách potravin či mzdách ve stejném nebo následujícím roce výraznějším růstem?

*Odpověď na otázku:* Nevidím žádný očividný vztah, kdy by při vyšším nárůstu HDP (např. o více jak 5%) výrazněji rostly ceny či mzdy oproti jiným rokům, kdy růst HDP nebyl tak vysoký.

## Zadání projekt z SQL

Na vašem analytickém oddělení nezávislé společnosti, která se zabývá životní úrovní občanů, jste se dohodli, že se pokusíte odpovědět na pár definovaných výzkumných otázek, které adresují dostupnost základních potravin široké veřejnosti. Kolegové již vydefinovali základní otázky, na které se pokusí odpovědět a poskytnout tuto informaci tiskovému oddělení. Toto oddělení bude výsledky prezentovat na následující konferenci zaměřené na tuto oblast.
Potřebují k tomu od vás připravit robustní datové podklady, ve kterých bude možné vidět porovnání dostupnosti potravin na základě průměrných příjmů za určité časové období.
Jako dodatečný materiál připravte i tabulku s HDP, GINI koeficientem a populací dalších evropských států ve stejném období, jako primární přehled pro ČR.
﻿
Datové sady, které je možné požít pro získání vhodného datového podkladu

Primární tabulky:
1. czechia_payroll – Informace o mzdách v různých odvětvích za několikaleté období. Datová sada pochází z Portálu otevřených dat ČR.
2. czechia_payroll_calculation – Číselník kalkulací v tabulce mezd.
3. czechia_payroll_industry_branch – Číselník odvětví v tabulce mezd.
4. czechia_payroll_unit – Číselník jednotek hodnot v tabulce mezd.
5. czechia_payroll_value_type – Číselník typů hodnot v tabulce mezd.
6. czechia_price – Informace o cenách vybraných potravin za několikaleté období. Datová sada pochází z Portálu otevřených dat ČR.
7. czechia_price_category – Číselník kategorií potravin, které se vyskytují v našem přehledu.

Číselníky sdílených informací o ČR:
1. czechia_region – Číselník krajů České republiky dle normy CZ-NUTS 2.
2. czechia_district – Číselník okresů České republiky dle normy LAU.

Dodatečné tabulky:
1. countries - Všemožné informace o zemích na světě, například hlavní město, měna, národní jídlo nebo průměrná výška populace.
2. economies - HDP, GINI, daňová zátěž, atd. pro daný stát a rok.
﻿
Výzkumné otázky
1. Rostou v průběhu let mzdy ve všech odvětvích, nebo v některých klesají?
2. Kolik je možné si koupit litrů mléka a kilogramů chleba za první a poslední srovnatelné období v dostupných datech cen a mezd?
3. Která kategorie potravin zdražuje nejpomaleji (je u ní nejnižší percentuální meziroční nárůst)?
4. Existuje rok, ve kterém byl meziroční nárůst cen potravin výrazně vyšší než růst mezd (větší než 10 %)?
5. Má výška HDP vliv na změny ve mzdách a cenách potravin? Neboli, pokud HDP vzroste výrazněji v jednom roce, projeví se to na cenách potravin či mzdách ve stejném nebo následujícím roce výraznějším růstem?
﻿
Výstupy z projektu
Pomozte kolegům s daným úkolem. Výstupem by měly být dvě tabulky v databázi, ze kterých se požadovaná data dají získat. Tabulky pojmenujte t_{jmeno}_{prijmeni}_project_SQL_primary_final (pro data mezd a cen potravin za Českou republiku sjednocených na totožné porovnatelné období – společné roky) a t_{jmeno}_{prijmeni}_project_SQL_secondary_final (pro dodatečná data o dalších evropských státech).
Dále připravte sadu SQL, které z vámi připravených tabulek získají datový podklad k odpovězení na vytyčené výzkumné otázky. Pozor, otázky/hypotézy mohou vaše výstupy podporovat i vyvracet! Záleží na tom, co říkají data.
Na svém GitHub účtu vytvořte veřejný repozitář, kam uložíte všechny informace k projektu – hlavně SQL skript generující výslednou tabulku, popis mezivýsledků (průvodní listinu) a informace o výstupních datech (například kde chybí hodnoty apod.).
Neupravujte data v primárních tabulkách! Pokud bude potřeba transformovat hodnoty, dělejte tak až v tabulkách nebo pohledech, které si nově vytváříte.

