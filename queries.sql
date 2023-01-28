/*Queries that provide answers to the questions from all projects.*/

-- Find all animals whose name ends in "mon".

SELECT * from animals WHERE name LIKE '%mon';

-- List the name of all animals born between 2016 and 2019.

SELECT name from animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';

-- List the name of all animals that are neutered and have less than 3 escape attempts.

SELECT name from animals WHERE neutered = TRUE AND escape_attempts < 3;

-- List the date of birth of all animals named either "Agumon" or "Pikachu".

SELECT date_of_birth from animals WHERE name IN ('Agumon', 'Pikachu');

-- List name and escape attempts of animals that weigh more than 10.5kg

SELECT name, escape_attempts from animals WHERE weight_kg > 10.5;

-- Find all animals that are neutered.

SELECT * from animals WHERE neutered = TRUE;

-- Find all animals not named Gabumon.

SELECT * from animals WHERE name != 'Gabumon';

-- Find all animals with a weight between 10.4kg and 17.3kg (including the animals with the weights that equals precisely 10.4kg or 17.3kg)

SELECT * from animals WHERE weight_kg BETWEEN 10.4 AND 17.3;

-----------------------------------------------
-----------------------------------------------

BEGIN;

UPDATE animals
SET species = 'unspecified';

ROLLBACK;

BEGIN;

UPDATE animals
SET species = 'digimon'
WHERE name LIKE '%mon';

UPDATE animals
SET species = 'unspecified'
WHERE species IS NULL;

COMMIT;

BEGIN;

DELETE from animals;

ROLLBACK;

BEGIN;

DELETE from animals
WHERE date_of_birth > '2022-01-01';

SAVEPOINT sp1;

UPDATE animals
SET weight_kg = weight_kg * -1;

ROLLBACK to sp1;

UPDATE animals
SET weight_kg = weight_kg * -1
WHERE weight_kg < 0;

COMMIT;
-----------------------------------------------
-----------------------------------------------

-- How many animals are there?

SELECT COUNT(*) from animals;

-- How many animals have never tried to escape?

SELECT COUNT(*) from animals WHERE escape_attempts = 0;

-- What is the average weight of animals?

SELECT AVG(weight_kg) from animals;

-- Who escapes the most, neutered or not neutered animals?

SELECT neutered, SUM(escape_attempts) from animals GROUP BY neutered;

-- What is the minimum and maximum weight of each type of animal?

SELECT species, MIN(weight_kg), MAX(weight_kg) from animals GROUP BY species;

-- What is the average number of escape attempts per animal type of those born between 1990 and 2000?

SELECT species, AVG(escape_attempts) from animals WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31' GROUP BY species;

-------------------------------------
-------------------------------------

-- What animals belong to Melody Pond?

SELECT name, full_name FROM owners O JOIN animals A ON A.owner_id = O.id WHERE full_name ='Melody Pond ';

-- List of all animals that are pokemon (their type is Pokemon).

SELECT A.name, S.name FROM animals A JOIN species S ON A.species_id = S.id WHERE S.name ='Pokemon';

-- List all owners and their animals, remember to include those that don't own any animal.

SELECT full_name, name FROM owners O LEFT JOIN animals A ON A.owner_id = O.id;

-- How many animals are there per species?

SELECT  S.name, COUNT(A.name)FROM animals A JOIN species S ON A.species_id = S.id GROUP BY S.id;

-- List all Digimon owned by Jennifer Orwell.

SELECT  A.name, S.name, O.full_name FROM animals A 
JOIN species S ON A.species_id = S.id 
JOIN owners O ON A.owner_id = O.id 
WHERE S.name = 'Digimon' AND O.full_name= 'Jennifer Orwell';

-- List all animals owned by Dean Winchester that haven't tried to escape.

SELECT  A.name, O.full_name FROM animals A 
JOIN owners O ON A.owner_id = O.id
WHERE A.escape_attempts = 0 AND O.full_name= 'Dean Winchester';

-- Who owns the most animals?


SELECT full_name, count FROM (SELECT O.full_name, count FROM (SELECT owner_id, COUNT(owner_id) FROM animals
GROUP BY owner_id) A JOIN owners O ON A.owner_id = O.id) AS J1 JOIN
(SELECT  MAX(count) as max FROM (SELECT owner_id, COUNT(owner_id) FROM animals
GROUP BY owner_id) C) AS J2 ON J1.count = J2.max;
