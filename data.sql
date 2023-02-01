/* Populate database with sample data. */

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES
	('Agumon', '2020,02,03', 0, TRUE, 10.23),
	('Gabumon', '2018-11-15', 2, TRUE, 8),
	('Pikachu', '2021-01-07', 1, FALSE, 15.04),
	('Devimon', '2017-05-12', 5, TRUE, 11);


INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES
	('Charmander', '2020,02,08', 0, FALSE, -11),
	('Plantmon', '2021-11-15', 2, TRUE, -5.7),
	('Squirtle', '1993-04-02', 3, FALSE, -12.13),
	('Angemon', '2005-06-12', 1, TRUE, -45),
	('Boarmon', '2005-06-07', 7, TRUE, 20.4),
	('Blossom', '1998-10-13', 3, TRUE, 17),
	('Ditto', '2022-05-14', 4, TRUE, 22);

INSERT INTO owners (full_name, age)
VALUES
	('Sam Smith', 34),
	('Jennifer Orwell', 19),
	('Bob', 45),
	('Melody Pond ', 77),
	('Dean Winchester', 14),
	('Jodie Whittaker ', 38);

INSERT INTO species (name)
VALUES
	('Digimon'),
	('Pokemon');

INSERT INTO vets (name, age, date_of_graduation)
VALUES
	('William Tatcher', 45, '2000,04,23'),
	('Maisy Smith', 26, '2019,01,17'),
	('Stephanie Mendez', 64, '1981,05,04'),
	('Jack Harkness', 38, '2008,06,08');

INSERT INTO specializations (vet_id, vet_name, species_id)
VALUES
	(1,'William Tatcher', 2),
	(3,'Stephanie Mendez', 2),
	(4,'Jack Harkness', 1);

INSERT INTO visits (vet_id, vet_name, animal_id, animal, date_of_visit)
VALUES
	(1, 'William Tatcher', 1, 'Agumon', '2020,05,24'),
	(3, 'Stephanie Mendez', 1, 'Agumon', '2020,07,22'),
	(4, 'Jack Harkness', 2, 'Gabumon', '2021,02,02'),
	(2, 'Maisy Smith', 3, 'Pikachu', '2020,01,05'),
	(2, 'Maisy Smith', 3, 'Pikachu', '2020,03,08'),
	(2, 'Maisy Smith', 3, 'Pikachu', '2020,05,14'),
	(3, 'Stephanie Mendez', 4, 'Devimon', '2021,05,04'),
	(4, 'Jack Harkness', 5, 'Charmander', '2021,02,24'),
	(2, 'Maisy Smith', 6, 'Plantmon', '2019,12,21'),
	(2, 'Maisy Smith', 6, 'Plantmon', '2020,08,10'),
	(1, 'William Tatcher', 6, 'Plantmon', '2021,04,07'),
	(3, 'Stephanie Mendez', 7, 'Squirtle', '2019,09,29'),
	(4, 'Jack Harkness', 8, 'Angemon', '2020,10,03'),
	(4, 'Jack Harkness', 8, 'Angemon', '2020,11,04'),
	(2, 'Maisy Smith', 9, 'Boarmon', '2019,01,24'),
	(2, 'Maisy Smith', 9, 'Boarmon', '2019,05,15'),
	(2, 'Maisy Smith', 9, 'Boarmon', '2020,02,27'),
	(2, 'Maisy Smith', 9, 'Boarmon', '2020,08,03'),
	(3, 'Stephanie Mendez', 10, 'Blossom', '2020,05,24'),
	(1, 'William Tatcher', 10, 'Blossom', '2021,01,11');

----------------------------------------------
----------------------------------------------

BEGIN;

UPDATE animals
SET species_id = 1
WHERE name LIKE '%mon';

UPDATE animals
SET species_id = 2
WHERE species_id IS NULL;

COMMIT;

BEGIN;

UPDATE animals
SET owner_id = 1
WHERE name = 'Agumon';

UPDATE animals
SET owner_id = 2
WHERE (SELECT name from animals WHERE name = 'Gabumon' OR name = 'Pikachu');

UPDATE animals
SET owner_id = 3
WHERE name = 'Devimon' OR name = 'Plantmon';

UPDATE animals
SET owner_id = 4
WHERE name = 'Charmander' OR name = 'Squirtle' OR name = 'Blossom';

UPDATE animals
SET owner_id = 5
WHERE name = 'Angemon' OR name = 'Boarmon';

COMMIT;
