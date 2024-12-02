/*1️⃣ Création de la base de données spa*/

DROP DATABASE IF EXISTS spa;

CREATE DATABASE spa CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

USE spa;

/*2️⃣ Création de la table chat*/
CREATE TABLE chats (
    id INT NOT NULL AUTO_INCREMENT,
    nom VARCHAR(255) NOT NULL, 
    yeux_id INT NOT NULL, 
    age INT NOT NULL,
    PRIMARY KEY (ID)
)
ENGINE=InnoDB;

/*3️⃣ Creation de la table couleur*/
CREATE TABLE couleurs (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(255) NOT NULL
)
ENGINE=InnoDB;

ALTER TABLE chats ADD CONSTRAINT FOREIGN KEY chats(yeux_id) REFERENCES couleurs(nom);

/*4️⃣ Insérer les données*/
INSERT INTO chats (nom, yeux_id, age)
VALUES
    ('Maine Coon', 1, 20),
    ('Siamois', 2, 15),
    ('Bengal', 1, 18),
    ('Scottish Fold', 1, 10);

INSERT INTO couleurs(nom)
VALUES
    ('marron'),
    ('bleu');