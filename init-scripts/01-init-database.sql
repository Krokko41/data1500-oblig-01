-- ============================================================================
-- DATA1500 - Oblig 1: Arbeidskrav I våren 2026
-- Initialiserings-skript for PostgreSQL
-- ============================================================================

-- 1. OPPRETT TABELLER
CREATE TABLE stasjon (
    navn TEXT PRIMARY KEY
);

CREATE TABLE kunde (
    id SERIAL PRIMARY KEY,
    navn TEXT,
    mobil TEXT
);

CREATE TABLE sykkel (
    id SERIAL PRIMARY KEY,
    status TEXT DEFAULT 'Ledig'
);

CREATE TABLE laas (
    id SERIAL PRIMARY KEY,
    stasjon_navn TEXT REFERENCES stasjon(navn),
    sykkel_id INT REFERENCES sykkel(id) UNIQUE
);

CREATE TABLE utleie (
    id SERIAL PRIMARY KEY,
    kunde_id INT REFERENCES kunde(id),
    sykkel_id INT REFERENCES sykkel(id),
    tid_start TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 2. SETT INN TESTDATA 


INSERT INTO stasjon (navn) VALUES 
('Oslo'), ('Bergen'), ('Stavanger'), ('Trondheim'), ('Tromsø');


INSERT INTO kunde (navn, mobil) VALUES 
('Kunde_1', '94011522'),
('Kunde_2', '40055641'),
('Kunde_3', '99887566'),
('Kunde_4', '452332341'),
('Kunde_5', '91929394');


INSERT INTO sykkel (status)
SELECT 'Ledig' FROM generate_series(1, 100);


INSERT INTO laas (stasjon_navn, sykkel_id)
SELECT 'Oslo', generate_series(1, 20) UNION ALL
SELECT 'Bergen', generate_series(21, 40) UNION ALL
SELECT 'Stavanger', generate_series(41, 60) UNION ALL
SELECT 'Trondheim', generate_series(61, 80) UNION ALL
SELECT 'Tromsø', generate_series(81, 100);


INSERT INTO utleie (kunde_id, sykkel_id)
SELECT 
    floor(random() * 5 + 1)::int, 
    floor(random() * 100 + 1)::int
FROM generate_series(1, 50);

-- 3. DBA SETNINGER (Enkel tilgangskontroll)
CREATE ROLE kunde_rolle;
GRANT SELECT ON stasjon, sykkel, laas TO kunde_rolle;
CREATE USER kunde_1 WITH PASSWORD 'kunde123';
GRANT kunde_rolle TO kunde_1;

-- 4. INDEKSER (For ytelse)
CREATE INDEX idx_kunde_mobil ON kunde(mobil);


SELECT table_name 
FROM information_schema.tables 
WHERE table_schema = 'public' 
AND table_type = 'BASE TABLE';


-- Vis at initialisering er fullført (kan se i loggen fra "docker-compose log"
SELECT 'Database initialisert!' as status;
