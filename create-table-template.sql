DROP TABLE IF EXISTS sightings;
DROP TABLE IF EXISTS species;
DROP TABLE IF EXISTS rangers;

CREATE TABLE rangers (
    ranger_id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    region TEXT NOT NULL
);

CREATE TABLE species (
    species_id SERIAL PRIMARY KEY,
    common_name TEXT NOT NULL,
    scientific_name TEXT NOT NULL,
    discovery_date DATE NOT NULL,
    conservation_status TEXT CHECK (conservation_status IN ('Endangered', 'Vulnerable', 'Least Concern'))
);
-- Delete the conservation_status check constraint to allow for the update 
ALTER TABLE species
DROP CONSTRAINT species_conservation_status_check;
-- Recreate the conservation_status check constraint to include 'Historic' status
ALTER TABLE species
ADD CONSTRAINT species_conservation_status_check
CHECK (conservation_status IN ('Endangered', 'Vulnerable', 'Least Concern', 'Historic'));



CREATE TABLE sightings (
    sighting_id SERIAL PRIMARY KEY,
    species_id INT NOT NULL REFERENCES species(species_id),
    ranger_id INT NOT NULL REFERENCES rangers(ranger_id),
    location TEXT NOT NULL,
    sighting_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    notes TEXT
);


INSERT INTO rangers (name, region) VALUES
('Alice Green', 'Northern Hills'),
('Bob White', 'River Delta'),
('Carol King', 'Mountain Range'),
('Derek Fox', 'Coastal Plains'),
('Eva Stone', 'Sunset Savannah'),
('Frank Blaze', 'Highland Peaks'),
('Grace Woods', 'Emerald Forest'),
('Henry Lake', 'Crystal Marsh'),
('Isla Storm', 'Desert Edge'),
('Jack Moon', 'Jungle Basin');

INSERT INTO species (common_name, scientific_name, discovery_date, conservation_status) VALUES
('Snow Leopard', 'Panthera uncia', '1775-01-01', 'Endangered'),
('Bengal Tiger', 'Panthera tigris tigris', '1758-01-01', 'Endangered'),
('Red Panda', 'Ailurus fulgens', '1825-01-01', 'Vulnerable'),
('Asiatic Elephant', 'Elephas maximus indicus', '1758-01-01', 'Endangered'),
('Golden Langur', 'Trachypithecus geei', '1953-01-01', 'Endangered'),
('Indian Pangolin', 'Manis crassicaudata', '1800-01-01', 'Vulnerable'),
('Sloth Bear', 'Melursus ursinus', '1791-01-01', 'Vulnerable'),
('Blackbuck', 'Antilope cervicapra', '1758-01-01', 'Least Concern'),
('Gaur', 'Bos gaurus', '1827-01-01', 'Vulnerable'),
('Indian Rhino', 'Rhinoceros unicornis', '1758-01-01', 'Vulnerable');

INSERT INTO sightings (species_id, ranger_id, location, sighting_time, notes) VALUES
(1, 1, 'Peak Ridge', '2024-05-10 07:45:00', 'Camera trap image captured'),
(2, 2, 'Bankwood Area', '2024-05-12 16:20:00', 'Juvenile seen'),
(3, 3, 'Bamboo Grove East', '2024-05-15 09:10:00', 'Feeding observed'),
(1, 2, 'Snowfall Pass', '2024-05-18 18:30:00', NULL),
(4, 4, 'Elephant Alley', '2024-05-11 14:05:00', 'Footprints found'),
(5, 5, 'Langur Lookout', '2024-05-13 09:30:00', 'Group seen jumping trees'),
(6, 6, 'Pangolin Path', '2024-05-14 20:10:00', 'Burrow found'),
(7, 7, 'Bear Bend', '2024-05-16 06:45:00', 'Seen with cubs'),
(8, 8, 'Blackbuck Field', '2024-05-19 17:25:00', 'Running across grass'),
(9, 9, 'Gaur Grove', '2024-05-20 08:50:00', 'Heard rustling nearby');
