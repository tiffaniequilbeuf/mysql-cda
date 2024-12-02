/*1️⃣ Création de la base de données netflix*/
DROP DATABASE IF EXISTS netflix;

CREATE DATABASE netflix CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

USE netflix;

/*2️⃣ Création de la table film*/
CREATE TABLE film (
        id INT NOT NULL AUTO_INCREMENT,
        titre VARCHAR(255) NOT NULL,
        sortie DATE NOT NULL, 
        categ_id INT,
        PRIMARY KEY (id)
)
ENGINE = InnoDB;

/*3️⃣ Création de la table categ */
CREATE TABLE categ (
    id INT NOT NULL AUTO_INCREMENT,
    nom VARCHAR(30) NOT NULL,
    PRIMARY KEY (id)
)ENGINE = InnoDB;

ALTER TABLE film ADD CONSTRAINT FOREIGN KEY (categ_id) REFERENCES categ(id);

/*4️⃣ Insérer les données, les tables sans liaisons en premier -> comme Laravel*/
INSERT INTO categ(nom)
VALUES
    ('Sciences Fiction'),
    ('Thriller');

INSERT INTO film(titre, sortie, categ_id)
VALUES 
    ('Star Wars', '1977/05/25', 1),
    ('The Matrix', '1999/06/23', 1),
    ('Pulpe Fiction', '1994/10/26', 2);


