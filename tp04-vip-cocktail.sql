DROP DATABASE IF EXISTS invitation;

CREATE DATABASE IF NOT EXISTS invitation CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

USE invitation;

CREATE TABLE personne (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    prenom VARCHAR(255) NOT NULL, 
    nom VARCHAR(255) NOT NULL, 
    age INT UNSIGNED,
    date_inscription DATE,
    etat TINYINT(1) NOT NULL DEFAULT 0,
    statut ENUM ('membre', 'non-membre') NOT NULL DEFAULT 'non-membre',
    CV TEXT,
    salaire_annuel INT UNSIGNED
)
ENGINE=InnoDB;

RENAME TABLE personne TO inv_personne;

/*1️⃣ - Ajouter les données*/

INSERT INTO inv_personne (prenom, nom, age, date_inscription, etat, statut, cv, salaire_annuel)
VALUES
    ('Brad', 'PITT', 60, '1970-01-01', 1, 'non-membre', 'lorem ipsum', 2000000),
    ('George', 'CLONEY', 62, '1999-01-01', 1, 'membre', 'juste beau', 4000000),
    ('Jean', 'DUJARDIN', 51, '1994-01-01', 1, 'membre', 'brice de nice', 1000000);

/* 2️⃣ - Afficher le plus gros salaire (avec MAX) */
SELECT MAX(salaire_annuel) AS 'plus_gros_salaire' FROM inv_personne;

/* 3️⃣ - Afficher le plus petit chiffre d'affaire (avec MIN)*/
SELECT MIN(salaire_annuel) AS 'plus_petit_salaire' FROM inv_personne;

/*4️⃣ - Afficher le nom de l'acteur (et son salaire) qui a le plus petit salaire avec LIMIT & ORDER BY*/
SELECT prenom, nom, salaire_annuel AS salaire FROM inv_personne
ORDER BY salaire ASC
LIMIT 1;

/*5️⃣ - Afficher le nom de l'acteur (et son salaire) qui a le plus gros salaire avec LIMIT & ORDER BY*/
SELECT prenom, nom, salaire_annuel AS 'salaire' FROM inv_personne
ORDER BY salaire DESC
LIMIT 1;

/*6️⃣ - Afficher le salaire moyen*/
SELECT AVG(salaire_annuel) AS 'salaire_moyen' FROM inv_personne;
/*CORRECTION, possible d'ajouter CAST*/
SELECT ROUND(AVG(salaire_annuel)) AS 'salaire_moyen' FROM inv_personne;
SELECT CAST(AVG(salaire_annuel) AS DECIMAL (10,1)) AS 'salaire_moyen' FROM inv_personne;

/*7️⃣ - Afficher le nombre de personnes*/
SELECT count(prenom) AS 'nb_personnes' FROM inv_personne;

/*8️⃣ - Afficher les acteurs avec un salaire entre 1 000 000 et 4 000 000 avec BETWEEN*/
SELECT id, prenom, nom, salaire_annuel FROM inv_personne
WHERE salaire_annuel BETWEEN 1000001 AND 3999999;

/* 9️⃣ Proposer une requete avec UPPER() & LOWER()*/
SELECT id, prenom, LOWER(nom) from inv_personne
WHERE nom = 'Pitt';

SELECT id, UPPER(prenom), LOWER(nom) from inv_personne
WHERE nom = 'Pitt';

/*10 - Afficher les personnes dont le prenom contient 'bra'*/
SELECT id, prenom, nom, salaire_annuel FROM inv_personne
WHERE prenom LIKE '%bra%';

/*12 - Trier par age les membres*/
SELECT prenom, nom, age FROM inv_personne
WHERE statut = 'membre'
ORDER BY age;

/*13 - Afficher le nombre d'acteurs "membre"*/
Select COUNT(*) AS nb_membres FROM inv_personne
WHERE statut='membre';

/*CORRECTION*/
Select COUNT(id) AS 'nombre de membres' FROM inv_personne
WHERE statut='membre';

/*14 - Afficher le nombre des membres et d'acteur "non membre" (non fini)*/
Select statut FROM inv_personne;

/*Correction, utilisation de l'alias dans la suite de la requête. Si l'alias est une chaine de caractère je ne peux pas m'en servir plus tard. */
SELECT statut AS "membre", ,COUNT(id) AS nb_membres FROM inv_personne
GROUP BY statut
ORDER BY nb_membres DESC;

