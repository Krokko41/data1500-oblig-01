-- ============================================================================
-- TEST-SKRIPT FOR OBLIG 1
-- ============================================================================


Oppgave 5.1
SELECT * FROM sykkel;

Oppgave 5.2
SELECT etternavn, fornavn, mobilnummer 
FROM kunde
ORDER BY etternavn AS;

Oppgave 5.3
SELECT * FROM sykkel 
WHERE tatt_i_bruk > '2023-04-01';

Oppgave 5.4
SELECT COUNT(*) AS totalt_antall_kunder 
FROM kunde;


Oppgave 5.5
SELECT 
kunde.etternavn, 
kunde.fornavn, 
COUNT(utleie.utleie_id) AS antall_utleie
FROM kunde
LEFT JOIN utleie ON kunde.kunde_id = utleie.kunde_id
GROUP BY kunde.kunde_id, kunde.etternavn, kunde.fornavn
ORDER BY antall_utleie DESC;

Oppgave 5.6 
SELECT 
  kunde.etternavn, 
  kunde.fornavn, 
  kunde.mobilnummer
FROM kunde
LEFT JOIN utleie ON kunde.kunde_id = utleie.kunde_id
WHERE utleie.utleie_id IS NULL;

Oppgave 5.7 
SELECT 
    sykkel.sykkel_id, 
    sykkel.type, 
    sykkel.merke
FROM sykkel
LEFT JOIN utleie ON sykkel.sykkel_id = utleie.sykkel_id
WHERE utleie.utleie_id IS NULL;

Oppgave 5.7
SELECT 
    s.sykkel_id, 
    s.type, 
    k.fornavn, 
    k.etternavn, 
    k.mobilnummer,
    u.utleie_tidspunkt
FROM utleie u
JOIN sykkel s ON u.sykkel_id = s.sykkel_id
JOIN kunde k ON u.kunde_id = k.kunde_id
WHERE u.innlevert_tidspunkt IS NULL 
  AND u.utleie_tidspunkt < NOW() - INTERVAL '1 dag';


