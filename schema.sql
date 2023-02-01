/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
    id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    date_of_birth DATE,
    escape_attempts INT,
    neutered BOOLEAN,
    weight_kg DECIMAL
);

ALTER TABLE animals 
ADD COLUMN species VARCHAR(100);

-------------------------------------------------
-------------------------------------------------

CREATE TABLE owners (
    id INT GENERATED ALWAYS AS IDENTITY,
    full_name VARCHAR(100),
    age INT,
    PRIMARY KEY(id)
);

CREATE TABLE species (
    id INT GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(100),
    PRIMARY KEY(id)
);

ALTER TABLE animals 
DROP COLUMN species;

ALTER TABLE animals
ADD COLUMN species_id INT,
ADD COLUMN owner_id INT;

ALTER TABLE animals
ADD CONSTRAINT fk_species
FOREIGN KEY (species_id)
REFERENCES species (id)
ON DELETE CASCADE;

ALTER TABLE animals
ADD CONSTRAINT fk_owner
FOREIGN KEY (owner_id)
REFERENCES owners (id)
ON DELETE CASCADE;

-------------------------------------------------
-------------------------------------------------

CREATE TABLE vets (
    id INT GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(100),
    age INT,
    date_of_graduation DATE,
    PRIMARY KEY(id)
);

CREATE TABLE specializations (
    id INT GENERATED ALWAYS AS IDENTITY,
    vet_id INT,
    vet_name VARCHAR(100),
    species_id INT,
    PRIMARY KEY(id),
    CONSTRAINT fk_vet
    FOREIGN KEY (vet_id)
    REFERENCES vets (id)
    ON DELETE CASCADE,
    CONSTRAINT fk_species
    FOREIGN KEY (species_id)
    REFERENCES species (id)
    ON DELETE CASCADE
);

CREATE TABLE visits (
    id INT GENERATED ALWAYS AS IDENTITY,
    vet_id INT,
    vet_name VARCHAR(100),
    animal_id INT,
    animal VARCHAR(100),
    date_of_visit DATE,
    PRIMARY KEY(id),
    CONSTRAINT fk_vet
    FOREIGN KEY (vet_id)
    REFERENCES vets (id)
    ON DELETE CASCADE,
    CONSTRAINT fk_species
    FOREIGN KEY (animal_id)
    REFERENCES animals (id)
    ON DELETE CASCADE
);