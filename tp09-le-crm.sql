/*PARTIE 1 - Créer la base de donnée*/
DROP DATABASE IF EXISTS le_crm;

CREATE DATABASE le_crm CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

USE le_crm;

CREATE TABLE clients (
    id INT NOT NULL AUTO_INCREMENT,
    client VARCHAR(255) NOT NULL,
    CONSTRAINT pk_clients PRIMARY KEY(id)
)ENGINE=InnoDB;

CREATE TABLE projets (
    id INT NOT NULL AUTO_INCREMENT,
    designation VARCHAR(255),
    version INT,
    client_id INT NOT NULL,
    CONSTRAINT pk_projets PRIMARY KEY(id)
)ENGINE=InnoDB;

CREATE TABLE devis (
    numero_devis VARCHAR(255) NOT NULL,
    montant INT UNSIGNED,
    projet_id INT NOT NULL,
    CONSTRAINT pk_devis PRIMARY KEY(numero_devis)
)ENGINE=InnoDB;

CREATE TABLE factures (
    numero_facture VARCHAR(255) NOT NULL,
    info VARCHAR(255),
    total INT UNSIGNED,
    date_edition DATE NOT NULL,
    date_paiement DATE,
    devis_id VARCHAR(255),
    CONSTRAINT pk_factures PRIMARY KEY(numero_facture)
)ENGINE=InnoDB;

/*[OneToMany] Un client peut avoir plusieurs projet*/
ALTER TABLE projets ADD CONSTRAINT fk_projets_clients FOREIGN KEY (client_id) REFERENCES clients(id);

/*[OneToMany] Un projet peut avoir plusieurs devis*/
ALTER TABLE devis ADD CONSTRAINT fk_devis_projets FOREIGN KEY (projet_id) REFERENCES projets(id);

/*[OneToMany] Un devis peut avoir plusieurs factures*/
ALTER TABLE factures ADD CONSTRAINT fk_factures_devis FOREIGN KEY (devis_id) REFERENCES devis(numero_devis);


/*PARTIE 1 - Ajouter les données*/

INSERT INTO clients (client) VALUES 
('Mairie de Rennes'),
('Neo Soft'),
('Sopra'),
('Accenture'),
('Amazon');

/*Génération avec dbdiagram.io
https://dbdiagram.io/d/TP09-le-crm-67518ac7e9daa85acac3c099
*/
