# Besvarelse - Refleksjon og Analyse

**Student:** [Ditt navn]

**Studentnummer:** [Ditt studentnummer]

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

[Skriv ditt svar her - f.eks. skjermbilder eller output fra terminalen som viser at databasen ble opprettet uten feil]

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

```
[Skriv resultatet av spørringen her - list opp alle tabellene som ble opprettet]
```
Alle tabellene som ble oppretter var Kunde, Sykkel lås, stasjon, utleie og STATUS.

---

## Del 3: Tilgangskontroll

### Oppgave 3.1: Roller og brukere

**SQL for å opprette rolle:**

```sql
[Skriv din SQL-kode for å opprette rollen 'kunde' her]
```

**SQL for å opprette bruker:**

```sql
[Skriv din SQL-kode for å opprette brukeren 'kunde_1' her]
```

**SQL for å tildele rettigheter:**

```sql
[Skriv din SQL-kode for å tildele rettigheter til rollen her]
```

---

### Oppgave 3.2: Begrenset visning for kunder

**SQL for VIEW:**

```sql
[Skriv din SQL-kode for VIEW her]
```

**Ulempe med VIEW vs. POLICIES:**

[Skriv ditt svar her - diskuter minst én ulempe med å bruke VIEW for autorisasjon sammenlignet med POLICIES]

---

## Del 4: Analyse og Refleksjon

### Oppgave 4.1: Lagringskapasitet

**Gitte tall for utleierate:**

- Høysesong (mai-september): 20000 utleier/måned
- Mellomsesong (mars, april, oktober, november): 5000 utleier/måned
- Lavsesong (desember-februar): 500 utleier/måned

**Totalt antall utleier per år:**

[Skriv din utregning her]

**Estimat for lagringskapasitet:**

[Skriv din utregning her - vis hvordan du har beregnet lagringskapasiteten for hver tabell]

**Totalt for første år:**

[Skriv ditt estimat her]

---

### Oppgave 4.2: Flat fil vs. relasjonsdatabase

**Analyse av CSV-filen (`data/utleier.csv`):**

**Problem 1: Redundans**

[Skriv ditt svar her - gi konkrete eksempler fra CSV-filen som viser redundans]

**Problem 2: Inkonsistens**

[Skriv ditt svar her - forklar hvordan redundans kan føre til inkonsistens med eksempler]

**Problem 3: Oppdateringsanomalier**

[Skriv ditt svar her - diskuter slette-, innsettings- og oppdateringsanomalier]

**Fordeler med en indeks:**

[Skriv ditt svar her - forklar hvorfor en indeks ville gjort spørringen mer effektiv]

**Case 1: Indeks passer i RAM**

[Skriv ditt svar her - forklar hvordan indeksen fungerer når den passer i minnet]

**Case 2: Indeks passer ikke i RAM**

[Skriv ditt svar her - forklar hvordan flettesortering kan brukes]

**Datastrukturer i DBMS:**

[Skriv ditt svar her - diskuter B+-tre og hash-indekser]

---

### Oppgave 4.3: Datastrukturer for logging

**Foreslått datastruktur:**

[Skriv ditt svar her - f.eks. heap-fil, LSM-tree, eller annen egnet datastruktur]

**Begrunnelse:**

**Skrive-operasjoner:**

[Skriv ditt svar her - forklar hvorfor datastrukturen er egnet for mange skrive-operasjoner]

**Lese-operasjoner:**

[Skriv ditt svar her - forklar hvordan datastrukturen håndterer sjeldne lese-operasjoner]

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
