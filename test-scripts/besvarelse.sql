--  Oppgave 1 Del 2
-- Kjør med 'docker-compose exec postgres psql -U admin -d hobbyhuset'

-- 1.  Finn alle data om alle kunder. Vis kun de 20 siste fra resultatrelasjonen (tips: bruke delspørring).
SELECT * FROM kunde LIMIT 20;
-- 2.  Finn fornavn og etternavn til alle ansatte. Vis kun de 10 første radene fra resultatrelasjonen.
SELECT fornavn, etternavn FROM ansatt LIMIT 10;
-- 3.  Finn alle unike stillinger som finnes i `Ansatt`-tabellen.
SELECT DISTINCT stilling FROM ansatt;
-- 4.  Finn varenummer, betegnelse og pris for alle varer.
SELECT vnr, betegnelse, pris FROM vare;
-- 5.  Finn navn og kategori-nummer for alle kategorier, men døp om kolonnene til `Kategorinavn` og `KategoriID`.
SELECT 
    navn AS Kategorinavn,
    katnr AS KategoriID
FROM kategori;
-- 6.  Finn ut hvor mange rader vil en kryssprodukt mellom kunder og ordrer ha.
SELECT COUNT(*) FROM kunde, ordre;

-- Oppgave 2 Del 2: Lag SQL-spørringer (skriv i `besvarelse.sql`)

-- 1.  Finn alle varer som koster mellom 200 og 500 (inkludert).
SELECT * FROM vare WHERE pris BETWEEN 200 AND 500;
-- 2.  Finn alle ansatte som er 'Lagermedarbeider' eller 'Innkjøper'.
SELECT * FROM ansatt WHERE stilling = 'Lagermedarbeider' OR stilling = 'Innkjøper';
-- 3.  Finn alle kunder som bor i postnummer '3199' eller '1711' og hvis fornavn starter med 'A'.
SELECT * FROM kunde WHERE fornavn LIKE 'A%' AND (postnr = '3199' OR postnr = '1711');
-- 4.  Finn alle varer som ikke er i kategori 1 og som har mer enn 600 på lager.
SELECT * FROM vare WHERE katnr != 1 AND antall > 600;
-- 5.  Finn alle ordrer som ble sendt, men ikke betalt.
SELECT * FROM ordre WHERE sendtdato IS NOT NULL AND betaltdato IS NULL;
-- 6.  Finn alle ansatte hvis etternavn inneholder 'sen' (ikke case-sensitivt).
SELECT * FROM ansatt WHERE etternavn LIKE '%sen';

-- Oppgave 3 Del 2: Lag SQL-spørringer (skriv i `besvarelse.sql`)

-- 1.  Finn antall kunder per postnummer.
SELECT 
    postnr, 
    COUNT(*) AS antall_kunder 
FROM kunde 
GROUP BY postnr 
ORDER BY antall_kunder DESC;
-- 2.  Finn gjennomsnittlig pris for hver kategori.
SELECT
    katnr,
    ROUND(AVG(pris), 2) AS gjennomsnittlig_pris
FROM vare
GROUP BY katnr
ORDER BY gjennomsnittlig_pris DESC;

-- 3.  Finn den dyreste varen i hver kategori.
SELECT v.betegnelse, v.pris, k.navn
FROM vare AS v
JOIN kategori k ON v.katnr = k.katnr
WHERE v.pris = (
    SELECT MAX(v2.pris)
    FROM vare v2 
    WHERE v2.katnr = v.katnr
);

-- 4.  List opp alle stillinger og antall ansatte i hver stilling, sortert synkende etter antall.
SELECT 
    stilling, 
    COUNT(stilling) AS antall -- viktig å talle stilling og ikke * for ekskluderes nullverdier
FROM ansatt
GROUP BY stilling
ORDER BY antall DESC;

-- 5.  Finn totalt antall vnr på lager for hver kategori, men vis kun kategorier med mer enn 1000 varer totalt.
SELECT 
    k.navn, 
    k.katnr, 
    COUNT(*) AS antall
FROM kategori k
JOIN vare v ON k.katnr = v.katnr
GROUP BY k.navn, k.katnr
HAVING COUNT(*) > 1000
ORDER BY antall DESC;

-- 6.  Finn den eldste og yngste ansatte.
SELECT 
    CONCAT(fornavn, ' ', etternavn),
    fødselsdato
FROM ansatt
WHERE fødselsdato = (SELECT MAX(fødselsdato) FROM ansatt)
    OR fødselsdato =  (SELECT MIN(fødselsdato) FROM ansatt);

-- Oppgave 4 Del 2: Lag SQL-spørringer (skriv i `besvarelse.sql`)

-- 1.  Finn navn på alle kunder og poststedet de bor i. Vis kun de første 20 rader fra resultatrelasjon. 
SELECT 
    CONCAT(a.fornavn, ' ', a.etternavn),
    p.poststed
FROM ansatt a
JOIN poststed p ON a.postnr = p.postnr
LIMIT 20;
    
-- 2.  Finn navn på alle varer og navnet på kategorien de tilhører. Vis kun de første 20 rader fra resultatrelasjon. 
SELECT v.*, k.navn AS kategorinavn
FROM vare v
JOIN kategori k ON v.katnr = k.katnr
LIMIT 20;

-- 3.  Finn alle ordrer med kundenavn og ordredato. Vis kun de første 20 rader fra resultatrelasjon. 
SELECT 
    CONCAT(k.fornavn, ' ', k.etternavn),
    o.*
FROM kunde k
JOIN ordre o ON k.knr = o.knr
LIMIT 20;

-- 4.  Finn alle varer som aldri har blitt solgt (dvs. ikke finnes i `Ordrelinje`).
SELECT v.betegnelse
FROM vare v
LEFT JOIN ordrelinje ol ON v.vnr = ol.vnr
WHERE ol.ordrenr IS NULL;

-- 5.  Finn totalt antall solgte enheter for hver vare (bruk `Ordrelinje`).
SELECT v.betegnelse, SUM(ol.antall) AS antall_solgte
FROM vare v
JOIN ordrelinje ol ON v.vnr = ol.vnr
GROUP BY v.betegnelse
ORDER BY antall_solgte DESC;

-- 6.  Finn navnet på alle ansatte som bor i Bø i Telemark.
SELECT CONCAT(a.fornavn, ' ', a.etternavn) AS navn, ps.poststed
FROM ansatt a
JOIN poststed ps ON a.postnr = ps.postnr
WHERE LOWER(ps.poststed) = 'bø i telemark';

-- Oppgave 5 Del 2: Skriv SQL-spørringer for å hente ut følgende informasjon fra `hobbyhuset`-databasen.

-- 1.  Finn antall ansatte som **ikke** har fått bonus.
SELECT COUNT(*) AS ikke_bonus
FROM ansatt
WHERE bonus IS NULL;

-- 2.  Beregn gjennomsnittlig bonus for alle ansatte, men behandle de som ikke har fått bonus som om de har 0 i bonus.
SELECT AVG(COALESCE(Bonus, 0)) FROM ansatt; -- COALESCE(gi meg denne verdien, men gi meg 0 istedenfor hvis NULL)

-- 3.  List opp alle kunder som **ikke** har registrert et telefonnummer.
SELECT *
FROM kunde
WHERE telefon IS NULL;

-- 4.  Finn den totale lønnskostnaden (Årslønn + Bonus) for alle ansatte. Pass på at ansatte uten bonus også blir med i den totale summen.
SELECT SUM(Årslønn + COALESCE(bonus,0)) FROM ansatt;

-- 5.  List opp alle stillinger og antall ansatte i hver stilling som har en bonus registrert.
SELECT stilling, COUNT(bonus) AS antall_med_bonus
FROM ansatt
WHERE bonus IS NOT NULL
GROUP BY stilling;

-- 6.  Finn den laveste bonusen som er gitt ut (ignorer de som ikke har fått bonus).
SELECT MIN(bonus) FROM ansatt;

-- Oppgave 6 Del 2
-- Skriv SQL-spørringer for å hente ut følgende informasjon.

-- 1.  Finn alle ordrer som **verken** er bekreftet betalt eller bekreftet ikke-betalt (dvs. de hvor logikken er `UNKNOWN`).
-- 2.  List opp alle ansatte som har en bonus som er enten `NULL` eller mindre enn 6000.
-- 3.  Finn antall kunder som **ikke** har telefonnummer `41234567` (pass på å inkludere de med `NULL` telefonnummer i tellingen).
-- 4.  List opp alle ordrer som er betalt (`ErBetalt = TRUE`), men hvor `SendtDato` er `NULL`.
