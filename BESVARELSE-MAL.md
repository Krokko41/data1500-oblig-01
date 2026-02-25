# Besvarelse - Refleksjon og Analyse

**Student:** Elias Aschim

**Studentnummer:** 407719

**Dato:** [Innleveringsdato]

---

## Del 1: Datamodellering

### Oppgave 1.1: Entiteter og attributter

**Identifiserte entiteter:**

Kunder, utleid, sykkel og stasjon

**Attributter for hver entitet:**

utlevert, levert, sted, tidsintervall, NULL, mobilnummer, epost, fornavn og etternavn.



---

### Oppgave 1.2: Datatyper og `CHECK`-constraints

**Valgte datatyper og begrunnelser:**

INTEGER fordi det brukes for å lagre kundeID i systemet

VARCHAR for å lagre etternavn, fornavn, epost osv

DATETIME som skal telle hvor lenge med tidsintervall når sykkelen blir utlevert og levert 


**`CHECK`-constraints:**

Leiebeløp >= 0 for å sjekke at verdien ikke blir mindre enn 0 

KundeID int NOT NULL, for å sjekke om kunden kan bruke sykkelen bare hvis de er logget inn



**ER-diagram:**



erDiagram
    KUNDE ||--o{ UTLEIE : ""
    SYKKEL ||--o{ UTLEIE : ""
    STASJON ||--|{ SYKKEL : ""
    
    KUNDE {
        int KundeID
        string Fullenavn
        string Mobilnr
        string E-post
    }

    SYKKEL {
        int SykkelID
        string Ledig
        string Ikke-ledig
    }

    STASJON {
        int Stasjonsnavn
    }

    UTLEIE {
        int UtleieID
        int KundeID
        int SykkelID
        int NULL
        datetime Start
        datetime Slutt
    }

---

### Oppgave 1.3: Primærnøkler

**Valgte primærnøkler og begrunnelser:**


jeg hadde valgt primærnøkler i IDer som kundeID, sykkelID og stasjonsID for å finne unike indikatorer for hver rad i databasen

**Naturlige vs. surrogatnøkler:**



jeg hadde brukt surrugatnøkler for KundeID og sykkelID osv istedetfor naturligenøkler for å lagre en unik verdi i databasen mens naturlige nøkler som e-post og telefonnr som en kunde bruker kan også brukes i forskjellige databaser. 

**Oppdatert ER-diagram:**

erDiagram
    KUNDE ||--o{ UTLEIE : ""
    SYKKEL ||--o{ UTLEIE : ""
    STASJON ||--|{ SYKKEL : ""

    KUNDE {
        int KundeID PK "Surrogatnøkkel"
        string Fullenavn
        string Mobilnr
    }

    SYKKEL {
        int SykkelID PK "Surrogatnøkkel"
        string Ledig
        string Ikke-ledig
    }

    STASJON {
        int Stasjonsnavn PK "surrogatnøkkel"
    }

    UTLEIE {
        int UtleieID PK "Surrogatnøkkel"
        int KundeID
        int SykkelID
        int NULL
        datetime Start
        datetime Slutt
    }

---

### Oppgave 1.4: Forhold og fremmednøkler

**Identifiserte forhold og kardinalitet:**

Kunde-utleie,sykkel-utleie og stasjon-sykkel. Alle de tre forholdene har kardinalitet 1:N

**Fremmednøkler:**

KundeID fra kundetabellen til KundeID i utleie tabellen og SykkelID i utleie tablellen til SykkelID i Sykkel tabellen. 

De implementerer forholdene med at man får kontroll hvilken kunde og hvilken sykkel brukes mellom forskjellige tabeller




**Oppdatert ER-diagram:**

erDiagram Kunde ||--o{ Utleie : "" Sykkel ||--o{ Utleie : "" Stasjon ||--|{ Sykkel : ""

Kunde {
    int KundeID PK "Surrogatnøkkel og forhold til utleie tabellen"
    string Fullenavn
    string Mobilnr
}

Sykkel {
    int SykkelID PK "Surrogatnøkkel og forhold til utleie tabellen"
    string Ledig
    string Ikke-ledig
}

Stasjon {
    int Stasjonsnavn PK "surrogatnøkkel"
}

Utleie {
    int UtleieID PK "Surrogatnøkkel"
    int KundeID "forhold til kunde tabellen"
    int SykkelID "forhold til sykkeln tabellen"
    int NULL
    datetime Start
    datetime Slutt
}

---

### Oppgave 1.5: Normalisering

**Vurdering av 1. normalform (1NF):**


Ja 1NF datamobellen min tilfredsstiller 1NF fordi hver celle i tabellene er det bare én enkelt verdi. Det gjør at hver rad kan bli identifisert unikt med bruk av en primærnøkkel.

**Vurdering av 2. normalform (2NF):**

For at datamodellen min tilfreddstiller 2NF må den først funke med 1NF og alle dataene i tabellen må være knyttet til hele primærnøklene. Det fyller kravene som datamodellen min har med å være avhengig av hele primærnøklene. 



**Vurdering av 3. normalform (3NF):**

Datamobellen min tilfredstiller også 3NF fordi den også funker med 2NF og fordi den ikke har noe transitive avhengigheter. Transitive avhengigheter betyr at alle felt i tabellen er avhengige av primærnøkkelen og ikke av andre kolonner. 



**Eventuelle justeringer:**


## Del 2: Database-implementering

### Oppgave 2.1: SQL-skript for database-initialisering

**Plassering av SQL-skript:**

[Bekreft at du har lagt SQL-skriptet i `init-scripts/01-init-database.sql`]

**Antall testdata:**

- Kunder: [antall]
- Sykler: [antall]
- Sykkelstasjoner: [antall]
- Låser: [antall]
- Utleier: [antall]

---

### Oppgave 2.2: Kjøre initialiseringsskriptet

**Dokumentasjon av vellykket kjøring:**


<img width="577" height="330" alt="Skjermbilde 2026-02-24 kl  22 14 31" src="https://github.com/user-attachments/assets/f315fce7-17c8-4a3c-bbb5-f87de9261563" />


**Spørring mot systemkatalogen:**

```sql
SELECT table_name 
FROM information_schema.tables 
WHERE table_schema = 'public' 
  AND table_type = 'BASE TABLE'
ORDER BY table_name;
```

**Resultat:**


Alle tabellene som ble oppretter var Kunde, Sykkel lås, stasjon, utleie og STATUS.

---

## Del 3: Tilgangskontroll

### Oppgave 3.1: Roller og brukere

**SQL for å opprette rolle:**

CREATE ROLE kunde_rolle;
CREATE ROLE admin_rolle;

**SQL for å opprette bruker:**

Create User kunde_1;
Grant kunde TO kunde_1;


**SQL for å tildele rettigheter:**

CREATE VIEW kunde_sykkel_visning AS 
SELECT id, status FROM sykkel;
GRANT SELECT ON kunde_sykkel_visning TO kunde;


### Oppgave 3.2: Begrenset visning for kunder

**SQL for VIEW:**

CREATE OR REPLACE VIEW mine_utleier AS
SELECT 
utleie.id, 
utleie.sykkel_id, 
utleie.tid_start
FROM utleie
JOIN kunde ON utleie.kunde_id = kunde.id
WHERE kunde.navn = current_user;
GRANT SELECT ON mine_utleier TO kunde;

**Ulempe med VIEW vs. POLICIES:**

En ulempe med å bruke VIEW sammenlignet med POLICIES er at når du bruker VIEW til autorisasjon er sikkerheten ekstern. Sikkerheten bare ligger i visningen og ikke i dataene som POLICIES gjør

---

## Del 4: Analyse og Refleksjon

### Oppgave 4.1: Lagringskapasitet

**Gitte tall for utleierate:**

- Høysesong (mai-september): 20000 utleier/måned
- Mellomsesong (mars, april, oktober, november): 5000 utleier/måned
- Lavsesong (desember-februar): 500 utleier/måned

**Totalt antall utleier per år:**

WITH sesong_data AS (
    SELECT 'Høysesong' AS sesong, 20000 AS utleier, 5 AS maaneder
    UNION ALL
    SELECT 'Mellomsesong', 5000 AS utleier, 4 AS maaneder
    UNION ALL
    SELECT 'Lavsesong', 500 AS utleier, 3 AS maaneder
)
SELECT 
    SUM(utleier * maaneder) AS totalt_utleier
FROM sesong_data

Det blir totalt 121500 antall utleier per år

**Estimat for lagringskapasitet:**


Hver rad i utleie tabellen tar rundt 36 bytes å lagre. Når vi skal lagre dataene i hver tabell så blir det 20000 x 5 x 36 = 3 600 0000 bytes for høysesong. 5000 x 4 x 36 = 720 000 for mellomsesong og 500 x 3 x 36 = 54000 bytes for lavsesong.

**Totalt for første år:**

Mitt estimat for første år etter vi har plusset alle tabellene sammen blir 4 3740 000 bytes eller 4.17 MB

---

### Oppgave 4.2: Flat fil vs. relasjonsdatabase

**Analyse av CSV-filen (`data/utleier.csv`):**

**Problem 1: Redundans**


Et eksempel som viser redundans er hvordan Ole Hansen utleier sykkel tre ganger men databasen forsatt lagrer E-post og mobilnr for hver gang han utleier en sykkel som tar unødvendig plass.

**Problem 2: Inkonsistens**

Siden databasen har lagret tre forskjellige mobilnr og E-post med Ole hansen og han skulle velge å bytte enten mobilnr eller e-post vil det oppgstå en inkonsistens når personlig data er forskjellig hos samme kunde. 

**Problem 3: Oppdateringsanomalier**


Oppdateringsanomalier er problemer som oppstår når man forsøker å slette, endre og legge til data i en database. For eksempel med CSV-filen så vil å oppdatere E-posten til Ole Hansen lede til problemer når vi får forskjellige data for en person. Sletteanomalier oppstår når man skal slette data men ender opp med å slette annen informasjon som man vil beholde. Innsettningsanomalier kommer når man prøver å legge inn data men det oppstår feil fordi man mangler andre data som tabellen krever.

**Fordeler med en indeks:**


Med en indeks ville gjort spørringen mer effektiv fordi da trenger den ikke lete over alle tabeller for å finne informasjonen. Hvis databasen for eksempel har en indeks i kolonnen fornavn kan man lettere finne fornavnet til personen man leter etter enn å gå gjennom alle kollonene.

**Case 1: Indeks passer i RAM**

Når indeks passer inn i RAM kan databasen finne hvor dataene ligger veldig raskt og effektivt. RAM leser mye raskere enn harddisker og passer godt når man vil ha rask respons i databasen som kalles an in-memory database(IMDB). Dette vil gjøre spørring i sykkeldatabasen veldig effektivt


**Case 2: Indeks passer ikke i RAM**

Hvis datamengden overstiger tilgjengelig minne i RAM må den dele oppgaven sin i mindre biter. Når en bit er ferdig blir den lagret midlertidlig som en fil i harddisken og RAM gjentar dette til den er ferdig med hele biten som denne prosessen kalles flettesortering. 

**Datastrukturer i DBMS:**

b+-tre brukes nesten i alle moderne datasystemer som holder dataene sortert i et hierarkisk struktur. Strukturen gjør det effektivt med bruk av intervallsøk fordi dataene er sortert. Hash indekser brukes for å få raske svar på eksakte verdier med bruk av en Hash tabell. Forskjellen mellom de to er at det er enklere å bruke b+-tre når man sorterer mye data og kan bruke intervallsøk for å finne fram mens Hash-indekser er ment for å søke opp raskt eksakte verdier men mangler evnen til å håndtere sortering i data.

---

### Oppgave 4.3: Datastrukturer for logging

**Foreslått datastruktur:**



Jeg hadde valgt heap-fil fordi det har en rask måte å logge ny data på hvor man sjeldent trenger å gjennomføre lese-operasjoner



**Begrunnelse:**

**Skrive-operasjoner:**

Heap-fil egner seg godt for mange skrive-operasjoner fordi den logger all ny data på slutten av tabellen hvor det er ledig plass. Det blir gjort på en enkel og effektivt måte hvor dataene trenger ikke sortering. 



**Lese-operasjoner:**

Heap-fil er ikke ideelt for lese-operasjoner fordi hvis du skal finne en logg i databasen må den lese hele fila fra topp til bunn fordi dataene er ikke sortert. Det kan ta tid for operasjonen til å fullføres og bør brukes sjeldent. 


---

### Oppgave 4.4: Validering i flerlags-systemer

**Hvor bør validering gjøres:**

[Skriv ditt svar her - argumenter for validering i ett eller flere lag]

**Validering i nettleseren:**

[Skriv ditt svar her - diskuter fordeler og ulemper]

**Validering i applikasjonslaget:**

[Skriv ditt svar her - diskuter fordeler og ulemper]

**Validering i databasen:**

[Skriv ditt svar her - diskuter fordeler og ulemper]

**Konklusjon:**

[Skriv ditt svar her - oppsummer hvor validering bør gjøres og hvorfor]

---

### Oppgave 4.5: Refleksjon over læringsutbytte

**Hva har du lært så langt i emnet:**

[Skriv din refleksjon her - diskuter sentrale konsepter du har lært]

**Hvordan har denne oppgaven bidratt til å oppnå læringsmålene:**

[Skriv din refleksjon her - koble oppgaven til læringsmålene i emnet]

Se oversikt over læringsmålene i en PDF-fil i Canvas https://oslomet.instructure.com/courses/33293/files/folder/Plan%20v%C3%A5ren%202026?preview=4370886

**Hva var mest utfordrende:**

[Skriv din refleksjon her - diskuter hvilke deler av oppgaven som var mest krevende]

**Hva har du lært om databasedesign:**

[Skriv din refleksjon her - reflekter over prosessen med å designe en database fra bunnen av]

---

## Del 5: SQL-spørringer og Automatisk Testing

**Plassering av SQL-spørringer:**

[Bekreft at du har lagt SQL-spørringene i `test-scripts/queries.sql`]


**Eventuelle feil og rettelser:**

[Skriv ditt svar her - hvis noen tester feilet, forklar hva som var feil og hvordan du rettet det]

---

## Del 6: Bonusoppgaver (Valgfri)

### Oppgave 6.1: Trigger for lagerbeholdning

**SQL for trigger:**

```sql
[Skriv din SQL-kode for trigger her, hvis du har løst denne oppgaven]
```

**Forklaring:**

[Skriv ditt svar her - forklar hvordan triggeren fungerer]

**Testing:**

[Skriv ditt svar her - vis hvordan du har testet at triggeren fungerer som forventet]

---

### Oppgave 6.2: Presentasjon

**Lenke til presentasjon:**

[Legg inn lenke til video eller presentasjonsfiler her, hvis du har løst denne oppgaven]

**Hovedpunkter i presentasjonen:**

[Skriv ditt svar her - oppsummer de viktigste punktene du dekket i presentasjonen]

---

**Slutt på besvarelse**
