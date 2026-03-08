--  Oppgave 1 Del 2

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
-- 4.  List opp alle stillinger og antall ansatte i hver stilling, sortert synkende etter antall.
-- 5.  Finn totalt antall varer på lager for hver kategori, men vis kun kategorier med mer enn 1000 varer totalt.
-- 6.  Finn den eldste og yngste ansatte.

-- Oppgave 4 Del 2: Lag SQL-spørringer (skriv i `besvarelse.sql`)

-- 1.  Finn navn på alle kunder og poststedet de bor i. Vis kun de første 20 rader fra resultatrelasjon. 
-- 2.  Finn navn på alle varer og navnet på kategorien de tilhører. Vis kun de første 20 rader fra resultatrelasjon. 
-- 3.  Finn alle ordrer med kundenavn og ordredato. Vis kun de første 20 rader fra resultatrelasjon. 
-- 4.  Finn alle varer som aldri har blitt solgt (dvs. ikke finnes i `Ordrelinje`).
-- 5.  Finn totalt antall solgte enheter for hver vare (bruk `Ordrelinje`).
-- 6.  Finn navnet på alle ansatte som bor i Bø i Telemark.

-- Oppgave 5 Del 2: Skriv SQL-spørringer for å hente ut følgende informasjon fra `hobbyhuset`-databasen.

-- 1.  Finn antall ansatte som **ikke** har fått bonus.
-- 2.  Beregn gjennomsnittlig bonus for alle ansatte, men behandle de som ikke har fått bonus som om de har 0 i bonus.
-- 3.  List opp alle kunder som **ikke** har registrert et telefonnummer.
-- 4.  Finn den totale lønnskostnaden (Årslønn + Bonus) for alle ansatte. Pass på at ansatte uten bonus også blir med i den totale summen.
-- 5.  List opp alle stillinger og antall ansatte i hver stilling som har en bonus registrert.
-- 6.  Finn den laveste bonusen som er gitt ut (ignorer de som ikke har fått bonus).

-- Oppgave 6 Del 2
-- Skriv SQL-spørringer for å hente ut følgende informasjon.

-- 1.  Finn alle ordrer som **verken** er bekreftet betalt eller bekreftet ikke-betalt (dvs. de hvor logikken er `UNKNOWN`).
-- 2.  List opp alle ansatte som har en bonus som er enten `NULL` eller mindre enn 6000.
-- 3.  Finn antall kunder som **ikke** har telefonnummer `41234567` (pass på å inkludere de med `NULL` telefonnummer i tellingen).
-- 4.  List opp alle ordrer som er betalt (`ErBetalt = TRUE`), men hvor `SendtDato` er `NULL`.
