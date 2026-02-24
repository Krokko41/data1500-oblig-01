-- ============================================================================
-- DATA1500 - Oblig 1: Arbeidskrav I våren 2026
-- Initialiserings-skript for PostgreSQL
-- ============================================================================

-- Opprett grunnleggende tabeller
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
    status TEXT,
    stasjon_navn TEXT REFERENCES stasjon(navn)
);

CREATE TABLE utleie (
    id SERIAL PRIMARY KEY,
    kunde_id INT REFERENCES kunde(id),
    sykkel_id INT REFERENCES sykkel(id),
    tid_start TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


-- Sett inn testdata
INSERT INTO stasjon (navn) VALUES ('Oslo S'), ('Aker Brygge');

INSERT INTO kunde (navn, mobil) VALUES ('Ola Nordmann', '90011222');

INSERT INTO sykkel (status, stasjon_navn) VALUES ('Ledig', 'Oslo S');

INSERT INTO utleie (kunde_id, sykkel_id) VALUES (1, 1);


-- DBA setninger (rolle: kunde, bruker: kunde_1)



-- Eventuelt: Opprett indekser for ytelse



-- Vis at initialisering er fullført (kan se i loggen fra "docker-compose log"
SELECT 'Database initialisert!' as status;
