-- Active: 1748106806994@@127.0.0.1@5432@conservation_db


-- SELECT * FROM "rangers"

-- SELECT * FROM "species"

-- SELECT * FROM "sightings"

-- UPDATE species
-- SET conservation_status = 'Least Concern'
-- WHERE species_id = 10;




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

-- Problem-6: Show the most recent 2 sightings.
SELECT sp.common_name, si.sighting_time, r.name from sightings si 
JOIN species sp ON si.species_id = sp.species_id 
JOIN rangers r ON si.ranger_id = r.ranger_id 
ORDER BY si.sighting_time DESC LIMIT 2;

-- Problem-7: Update all species discovered before year 1800 to have status 'Historic'.
Update species SET conservation_status = 'Historic' WHERE discovery_date < '1800-01-01';

-- PRoblem-8: Label each sighting's time of day as 'Morning', 'Afternoon', or 'Evening'.
SELECT sighting_id, CASE 
WHEN EXTRACT (HOUR FROM sighting_time) < 12 THEN 'Morning'
WHEN EXTRACT (HOUR FROM sighting_time) BETWEEN 12 AND 17 THEN 'Afternoon'
ELSE 'Evening' END AS time_of_day FROM sightings;

-- Problem-9: Delete rangers who have never sighted any species.
DELETE FROM rangers WHERE ranger_id NOT IN (SELECT DISTINCT ranger_id FROM sightings);
-- For test case this operation add some new ranger data who have never sighted any species.This is new data in rangers table.
INSERT INTO rangers (name, region) VALUES
('Liam Rivers', 'Misty Mountains'),
('Maya Forest', 'Sunny Meadows');
