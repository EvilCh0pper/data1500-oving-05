# Besvarelse: SQL-Analyse

## Oppgave 1: Grunnleggende Spørringer
1.  `SELECT * FROM Vare;`
2.  `SELECT VNr, Betegnelse FROM Vare;`
3.  `SELECT DISTINCT KatNr FROM Vare;`
4.  `SELECT Fornavn, Etternavn, Stilling AS Jobbtittel FROM Ansatt;`

1.  **Forklaring:** ...
   - Vis alle kolonner FRA tabellen vare

2.  **Forklaring:**
   - Vis kolonnene VNr, Betegnelse fra tabellen vare

3.  **Forklaring:** ...
   - Vis UNIKE rader fra kolonnen KatNr fra tabellen vare

4.  **Forklaring:** ...
   - Vis kolonnene fornavn, etternavn og stilling, som omdøpes til jobbtittel, fra tabellen ansatt

## Oppgave 2: WHERE-klausulen
1.  `SELECT * FROM Vare WHERE Pris > 500;`
2.  `SELECT * FROM Ansatt WHERE Stilling = 'Salgssjef' AND Årslønn > 600000;`
3.  `SELECT Fornavn, Etternavn FROM Kunde WHERE PostNr = '0001' OR PostNr = '0002';`
4.  `SELECT Betegnelse FROM Vare WHERE NOT KatNr = 1`;

1.  **Forklaring:** ...
   - Vis alle rader fra vare-tabellen der verdien til attributtet pris her mer enn 500

2.  **Forklaring:** ...
3. - Vis alle reader fra ansatt-tabellen hvor Stilling-attributtet har verdien 'Salgssjef' og Årslånn-attributtet er mer enn 600000

4.  **Forklaring:** ...
   - Vis kolonnene Fornavn og Etternavn fra kunde-tabellen hvor PostNr-attributtet har verdien '0001' eller PostNr-attributtet har verdien '0002'

5.  **Forklaring:** ...
   - Vis betegnelse-kolonnen fra Vare-tabellen hvor attributtet KatNr ikke har verdien '1'

## Oppgave 3: Gruppering og Sortering
1.  `SELECT * FROM Vare ORDER BY Pris DESC;`
2.  `SELECT KatNr, COUNT(*) FROM Vare GROUP BY KatNr;`
3.  `SELECT Stilling, AVG(Årslønn) FROM Ansatt GROUP BY Stilling;`
4.  `SELECT KatNr, SUM(Antall) FROM Vare GROUP BY KatNr HAVING SUM(Antall) > 500;`

1.  **Forklaring:** ...
   - Vis alle kolonner fra vare-tabellen, sorter etter pris - start fra laveste verdi

2.  **Forklaring:** ...
   - Vis kolonnen katnr, tell alle rader fra vare-tabellen. Gruppér etter katnr

3.  **Forklaring:** ...
   - Vis kolonnene stilling, gjennomsnittsverdien radenen i årslønn-kolonnen, fra ansatt-tabellen. Gruppér etter stilling

4.  **Forklaring:** ...
   - Vis kolonnene katnr, summer radene i antall-kolonnen, fra vare-tabellen. Gruppér etter katnr, og vis bare radene der summen av antall er høyere enn 500

## Oppgave 4: Spørringer mot Flere Tabeller
1.  `SELECT V.Betegnelse, K.Navn FROM Vare V JOIN Kategori K ON V.KatNr = K.KatNr;`
2.  `SELECT O.OrdreNr, K.Fornavn, K.Etternavn FROM Ordre O LEFT JOIN Kunde K ON O.KNr = K.KNr;`
3.  `SELECT A1.Fornavn, A2.Fornavn FROM Ansatt A1, Ansatt A2 WHERE A1.PostNr = A2.PostNr AND A1.AnsNr < A2.AnsNr;`
4.  `SELECT V.Betegnelse FROM Vare V WHERE V.VNr NOT IN (SELECT VNr FROM Ordrelinje);`

5.  **Forklaring:** ...
    - Vis kolonnene v.betegnelse, knavn fra Vare omdøpt til v. Slå sammen tabellen kategori omdøpt til k, der v.katnr tilsvarer k.katnr

6.  **Forklaring:** ...
    - Vis kolonnene o.ordrenr, k.fornavn, k.etternavn fra tabellen ordre omdøpt til o, slå sammen tabellen kunde omdøpt til k der o.knr tilsvarer k.knr

7.  **Forklaring:** ...
   - vis kolonenne a1.fornavn, a2.fornavn fra ansatt omdøpt til a1, ansatt omdøpt til a2 der a1.postnr tilsvarer a2.postnr og a1.ansnr er mindre enn a2.ansnr

8.  **Forklaring:** ...
   - vis kolonnen v.betegnelse fra vare omdøpt til v, hvor v.vnr ikke finnes i (vis vnr fra ordrelinje) 

## Oppgave 5: NULL-verdier og Aggregeringsfunksjoner

Forklar hva følgende SQL-spørringer gjør, og hvorfor resultatene blir som de blir. Vær spesielt oppmerksom på hvordan `NULL` påvirker resultatet.

1.  **Spørring:**
    ```sql
    SELECT COUNT(*), COUNT(Bonus) FROM Ansatt;
    ```
    **Forklaring:**
    *   Vis en opptelling av rader i alle kolonner, opptellling av alle rader i bonus-kolonnen fra ansatt-tabellen 

2.  **Spørring:**
    ```sql
    SELECT AVG(Bonus) FROM Ansatt;
    ```
    **Forklaring:**
    *   Vis gjennomsnittet av verdiene i bonus-kolonnen fra ansatt-tabellen

3.  **Spørring:**
    ```sql
    SELECT Fornavn, Etternavn, COALESCE(Bonus, 0) AS JustertBonus FROM Ansatt;
    ```
    **Forklaring:**
    *   Vis kolonnene fornavn, etternavn, returner den første verdien som ikke er null fra bonus eller 0 - og omdøp dette som JustertBonus. Vis dette fra tabellen ansatt

4.  **Spørring:**
    ```sql
    SELECT Stilling, SUM(Årslønn + Bonus) FROM Ansatt GROUP BY Stilling;
    ```
    **Forklaring:**
    *   Vis kolonnene stilling, summen av årslønn og bonus, fra ansatt tabellen. Gruppér etter stilling

## Oppgave 6: Tre-verdi Logikk (TRUE, FALSE, UNKNOWN)

SQLs logikk er ikke bare `TRUE` eller `FALSE`. Når `NULL` er involvert, får vi en tredje tilstand: `UNKNOWN`. Denne oppgaven utforsker hvordan dette påvirker `WHERE`-klausuler.

### Del 1: Forklar SQL-spørringene

Forklar resultatet av følgende SQL-spørringer. Hvorfor returnerer de det de gjør?

1.  **Spørring:**
    ```sql
    SELECT COUNT(*) FROM Ordre WHERE ErBetalt = TRUE;
    ```
    **Forklaring:**
    *   Denne spørringen returnerer en rad med verdien 1973, og ekskludererer andre rader i tellingen fordi den spesifiserer at bare radene der boolean-kolonnen ErBetalt må være TRUE for å kunne inkluderes i opptellingen  

2.  **Spørring:**
    ```sql
    SELECT COUNT(*) FROM Ordre WHERE ErBetalt = FALSE;
    ```
    **Forklaring:**
    *   Det motsatte av svaret over - her inkluderes bare radene der ErBetalt er FALSE. I dette tilfellet virker det som at det ikke er noen rader som er FALSE

3.  **Spørring:**
    ```sql
    SELECT COUNT(*) FROM Ordre WHERE ErBetalt = TRUE OR ErBetalt = FALSE;
    ```
    **Forklaring:**
    *  For hver rad som sjekkes, vil WHERE-klausulen sjekkes opp mot både om ErBetalt er enten TRUE eller FALSE. Spørringen returnerer 1973, som er det samme som i oppgave 1. Siden denne spørringen sjekker både for TRUE og FALSE, vil derfor samme radene som i første og andre spørring returneres.

4.  **Spørring:**
    ```sql
    SELECT COUNT(*) FROM Ordre WHERE ErBetalt IS UNKNOWN;
    ```
    **Forklaring:**
    *   Stusser litt på at UNKNOWN brukes, men her sjekkes det for om ErBetalt-radene returnerer null. I dette tilfellet returnerer COUNT(*) 219, som betyr at 219 rader i ErBetalt-kolonnen peker på en null-verdi. 
