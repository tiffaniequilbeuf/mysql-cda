/*A- Création de la base de film avec acteur*/
DROP DATABASE IF EXISTS film_avec_acteur;

CREATE DATABASE film_avec_acteur CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

/*B- Création de la table film*/
CREATE TABLE film (
        id INT NOT NULL AUTO_INCREMENT,
        nom VARCHAR(100) NOT NULL,
        PRIMARY KEY (id)
)
ENGINE = InnoDB;

/*C- Création de la table acteur*/
CREATE TABLE acteur (
        id INT NOT NULL AUTO_INCREMENT,
        prenom VARCHAR(100) NOT NULL,
        nom VARCHAR(100) NOT NULL,
        PRIMARY KEY (id)
)
ENGINE = InnoDB;

/*D- Création de la table pivot film_has_acteur*/
CREATE TABLE film_has_acteur (
    film_id INT,
    acteur_id INT,
    PRIMARY KEY (film_id, acteur_id)
)
ENGINE = InnoDB;

/*D' Lier les tables à la table pivot */
ALTER TABLE film_has_acteur ADD CONSTRAINT fk_film FOREIGN KEY (film_id) REFERENCES film(id);
ALTER TABLE film_has_acteur ADD CONSTRAINT fk_acteur FOREIGN KEY (acteur_id) REFERENCES acteur(id);

/*E- Insérer les données, les tables  : 
    - 1 acteur et film
    - 2 pivot */

/*1️⃣ Afficher tous les films de Léonardo DI CAPRIO */

/*2️⃣ Afficher le nombre de films par acteur */

/*3️⃣ Ajouter un film :TITANIC */

/*4️⃣ Trouver le film qui n'a pas d'acteur */

