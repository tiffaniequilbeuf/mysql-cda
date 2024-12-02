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

/* corrections ou notes éventuelles 
if not exists pas nécessaire
contrainte pas au bon endroit

Alter uniquement sur cette table
*/