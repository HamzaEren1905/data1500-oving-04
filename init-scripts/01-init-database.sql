-- ============================================================================
-- DATA1500 - Oppgavesett 1.5: Databasemodellering og implementasjon
-- Initialiserings-skript for PostgreSQL
-- ============================================================================

-- Opprett grunnleggende tabeller
CREATE TABLE bruker(
    bruker_id SERIAL PRIMARY KEY,
    brukernavn TEXT NOT NULL,
    passord TEXT NOT NULL
);

CREATE TABLE klasserom(
    klasserom_id SERIAL PRIMARY KEY,
    navn TEXT NOT NULL
);

CREATE TABLE gruppe(
    gruppe_id SERIAL PRIMARY KEY,
    navn TEXT NOT NULL
);

CREATE TABLE beskjed(
    beskjed_id SERIAL PRIMARY KEY,
    klasserom_id INT REFERENCES klasserom(klasserom_id),
    bruker_id INT REFERENCES bruker(bruker_id),
    datetime_dato TIMESTAMP NOT NULL,
    innhold TEXT NOT NULL
);

CREATE TABLE innlegg(
    innlegg_id SERIAL PRIMARY KEY,
    bruker_id INT REFERENCES bruker(bruker_id),
    klasserom_id INT REFERENCES klasserom(klasserom_id),
    parent_id INT REFERENCES innlegg(innlegg_id),
    innhold TEXT NOT NULL
);

CREATE TABLE medlemskap(
    bruker_id INT REFERENCES bruker(bruker_id),
    gruppe_id INT REFERENCES gruppe(gruppe_id),
    PRIMARY KEY (bruker_id, gruppe_id)
);

CREATE TABLE klasserom_tilgang(
    gruppe_id INT REFERENCES gruppe(gruppe_id),
    klasserom_id INT REFERENCES klasserom(klasserom_id),
    PRIMARY KEY (gruppe_id, klasserom_id)
);



-- Sett inn testdata
-- ------------------
-- Brukere
-- ------------------
INSERT INTO bruker (brukernavn, passord) VALUES 
('lærer1', 'pass123'),
('student1', 'pass123'),
('student2', 'pass123');

-- ------------------
-- Grupper
-- ------------------
INSERT INTO gruppe (navn) VALUES 
('Gruppe A'),
('Gruppe B');

-- ------------------
-- Klasserom
-- ------------------
INSERT INTO klasserom (navn) VALUES
('Matematikk 101'),
('Fysikk 101');

-- ------------------
-- Medlemskap (BRUKER ↔ GRUPPE)
-- ------------------
INSERT INTO medlemskap (bruker_id, gruppe_id) VALUES
(2, 1), -- student1 i Gruppe A
(3, 1), -- student2 i Gruppe A
(3, 2); -- student2 også i Gruppe B

-- ------------------
-- Klasserom Tilgang (GRUPPE ↔ KLASSEROM)
-- ------------------
INSERT INTO klasserom_tilgang (gruppe_id, klasserom_id) VALUES
(1, 1), -- Gruppe A har tilgang til Matematikk 101
(2, 2); -- Gruppe B har tilgang til Fysikk 101

-- ------------------
-- Beskjeder
-- ------------------
INSERT INTO beskjed (klasserom_id, bruker_id, datetime_dato, innhold) VALUES
(1, 1, '2026-02-08 10:00', 'Velkommen til Matematikk 101!'),
(2, 1, '2026-02-08 11:00', 'Velkommen til Fysikk 101!');

-- ------------------
-- Innlegg (diskusjonstråder)
-- ------------------
INSERT INTO innlegg (bruker_id, klasserom_id, parent_id, innhold) VALUES
(2, 1, NULL, 'Hei, jeg har et spørsmål om oppgave 1.'),
(1, 1, 1, 'Hei! Hva er spørsmålet ditt?'),
(2, 1, 2, 'Jeg forstår ikke hvordan man løser likningen.'),
(3, 1, NULL, 'Hei, jeg synes oppgave 1 er vanskelig også.');



-- Eventuelt: Opprett indekser for ytelse



-- Vis at initialisering er fullført
SELECT 'Database initialisert!' as status;