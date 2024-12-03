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
    film_id INT NOT NULL,
    acteur_id INT NOT NULL,
    CONSTRAINT pk_film_has_acteur PRIMARY KEY (film_id, acteur_id)
)
ENGINE = InnoDB;

/*D' Lier les tables à la table pivot */
ALTER TABLE film_has_acteur ADD CONSTRAINT fk_film FOREIGN KEY (film_id) REFERENCES film(id);
ALTER TABLE film_has_acteur ADD CONSTRAINT fk_acteur FOREIGN KEY (acteur_id) REFERENCES acteur(id);

/*E- Insérer les données, les tables  : 
    - 1 acteur et film
    - 2 pivot */

INSERT INTO acteur(prenom, nom)
VALUES 
    ('Brad', 'PITT'),
    ('Léonardo', 'DICAPRIO');

INSERT INTO film(nom)
VALUES 
    ('Fight Club'),
    ('One Upon the Time');

INSERT INTO film_has_acteur(film_id, acteur_id)
VALUES 
    (1,1),
    (2,1),
    (2,2);


/*1️⃣ Afficher tous les films de Léonardo DI CAPRIO */
SELECT 
film.nom AS film,
acteur.prenom,
acteur.nom
FROM film
INNER JOIN film_has_acteur  ON film.id = film_has_acteur.film_id
INNER JOIN acteur ON acteur.id = film_has_acteur.acteur_id
WHERE acteur.nom = "DICAPRIO";

/*Note : je n'ai pas le même retour */

/*2️⃣ Afficher le nombre de films par acteur */

SELECT COUNT(film.nom) AS nb_film FROM film;    /*J'affiche le nombre de film*/
SELECT acteur.prenom, acteur.nom FROM acteur;   /*J'affiche la liste des acteurs*/

/*Resultat*/
SELECT acteur.prenom, acteur.nom, COUNT(film.nom) AS nb_film 
FROM film
INNER JOIN film_has_acteur  ON film.id = film_has_acteur.film_id
INNER JOIN acteur ON acteur.id = film_has_acteur.acteur_id
GROUP BY acteur.prenom, acteur.nom;

/*3️⃣ Ajouter un film :TITANIC */
INSERT INTO film(nom)
VALUES 
    ('Titanic');

/*4️⃣ Trouver le film qui n'a pas d'acteur */
SELECT film.nom 
FROM film
LEFT JOIN film_has_acteur ON film.id = film_has_acteur.film_id
WHERE film_has_acteur.acteur_id IS NULL;
