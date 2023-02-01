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

--------------------------------------------
--------------------------------------------

-- Who was the last animal seen by William Tatcher?

SELECT animal, date_of_visit from visits WHERE vet_name = 'William Tatcher' ORDER BY date_of_visit DESC LIMIT 1;

-- How many different animals did Stephanie Mendez see?

SELECT vet_name, COUNT (DISTINCT animal) from visits GROUP BY vet_name HAVING vet_name = 'Stephanie Mendez';

-- List all vets and their specialties, including vets with no specialties.

SELECT v.name, sp.name as speciality from vets v LEFT JOIN specializations s ON  v.id = s.vet_id
LEFT JOIN species sp ON s.species_id = sp.id;

-- List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.

SELECT vet_name, animal, date_of_visit from visits WHERE vet_name = 'Stephanie Mendez' AND date_of_visit BETWEEN '2020-04-01' AND '2020-08-30';

-- What animal has the most visits to vets?

SELECT animal, COUNT(animal) as number_of_visits from visits GROUP BY animal ORDER BY COUNT(animal) DESC LIMIT 1;

-- Who was Maisy Smith's first visit?

SELECT animal, date_of_visit from visits WHERE vet_name = 'Maisy Smith' ORDER BY date_of_visit LIMIT 1;

-- Details for most recent visit: animal information, vet information, and date of visit.

SELECT * from visits V LEFT join animals A on V.animal_id = A.id ORDER BY date_of_visit DESC LIMIT 1;

-- How many visits were with a vet that did not specialize in that animal's species?

SELECT V.vet_name, V.date_of_visit, A.name, A.species_id, S.species_id from visits V join animals A on V.animal_id = A.id Left join specializations S on V.vet_id = S.vet_id WHERE A.species_id = S.species_id OR S.species_id IS NULL ORDER BY date_of_visit DESC;

-- What specialty should Maisy Smith consider getting? Look for the species she gets the most.

SELECT V.vet_name, S.name as consider_specialalization_in, COUNT(S.name) as number_of_vsits from visits V join animals A on V.animal_id = A.id Left join species S on A.species_id = S.id WHERE V.vet_name = 'Maisy Smith' GROUP BY S.name, V.vet_name ORDER BY COUNT(S.name) DESC LIMIT 1;