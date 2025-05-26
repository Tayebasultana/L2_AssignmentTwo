-- Active: 1748106806994@@127.0.0.1@5432@conservation_db


SELECT * FROM "rangers"

SELECT * FROM "species"

SELECT * FROM "sightings"

-- Problem-1: Register a new ranger
INSERT INTO rangers (name, region) VALUES ('Liam Rivers', 'Highland Valley');

-- Problem-2: Count unique species ever sighted.
SELECT COUNT (DISTINCT species_id) AS unique_species_count FROM sightings;

-- Problem-3: Find all sightings where the location includes "Pass".
SELECT * FROM sightings WHERE location ILIKE '%Pass%';

-- Problem-4: List each ranger's name and their total number of sightings.
SELECT r.name, COUNT (s.sighting_id) AS total_sightings FROM rangers r
LEFT JOIN sightings s ON r.ranger_id = s.ranger_id
GROUP BY r.name 
ORDER BY r.name;

-- Problem-5: List species that have never been sighted.
SELECT s.common_name FROM species s
LEFT JOIN sightings si ON s.species_id = si.species_id Where si.species_id IS NULL;