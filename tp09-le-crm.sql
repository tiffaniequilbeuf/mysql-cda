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

INSERT INTO projets (designation, version, client_id) VALUES
('Creation de site internet', 1, 1),
('Creation de site internet', 2, 1),
('Logiciel CRM', 1, 2),
('Logiciel de devis', 1, 3),
('Site internet ecommerce', 1, 4),
('logiciel ERP', 1, 5),
('logiciel Gestion de Stock', 1, 6);

INSERT INTO devis (numero_devis, montant, projet_id) VALUES
('DEV2100A', 3000, 15),
('DEV2100B', 5000, 15),
('DEV2100C', 5000, 17),
('DEV2100D', 3000, 18),
('DEV2100E', 5000, 19),
('DEV2100F', 2000, 20),
('DEV2100G', 1000, 21);

INSERT INTO factures (numero_facture, info, total, date_edition, date_paiement, devis_id) VALUES
('FA001','Site internet partie 1', 1500, '2023-09-01', '2023-10-01', 'DEV2100A'),
('FA002','Site internet partie 2', 1500, '2023-09-20', NULL, 'DEV2100A'),
('FA003','Logiciel CRM', 5000, '2024-02-01', NULL, 'DEV2100C'),
('FA004','Logiciel devis', 3000, '2024-03-03', '2024-04-03', 'DEV2100D'),
('FA005','Site internet ecommerce', 5000, '2023-03-01', NULL, 'DEV2100E'),
('FA006','logiciel ERP', 2000, '2023-03-01', NULL, 'DEV2100F');


/*Génération avec dbdiagram.io
https://dbdiagram.io/d/TP09-le-crm-67518ac7e9daa85acac3c099
*/

/*1️⃣ Afficher toutes les factures avec le nom des clients*/
SELECT 
client AS 'Nom du client',
numero_facture,
info,
total,
date_edition AS 'date edition',
date_paiement AS 'date du paiement'
FROM factures AS f
JOIN devis AS d ON f.devis_id = d.numero_devis
JOIN projets AS p ON d.projet_id = p.id
JOIN clients AS c ON p.client_id = c.id;

/*2️⃣ Afficher le nombre de factures par client*/
SELECT 
c.client AS 'Nom du client',
COUNT(numero_facture) AS 'nombre de factures'
FROM clients AS c
LEFT JOIN projets AS p ON p.client_id = c.id
LEFT JOIN devis AS d ON d.projet_id = p.id
LEFT JOIN factures AS f ON f.devis_id = d.numero_devis
GROUP BY client;

/*Pas recommandé en right, c'est 0.2% des requests*/
SELECT 
c.client AS 'Nom du client',
COALESCE(COUNT(numero_facture)) AS 'nombre de factures'
FROM factures AS f
RIGHT JOIN devis AS d ON f.devis_id = d.numero_devis
RIGHT JOIN projets AS p ON d.projet_id = p.id
RIGHT JOIN clients AS c ON p.client_id = c.id
GROUP BY client;

/*3️⃣ Afficher le chiffre d'affaire par client*/
SELECT 
c.client AS 'Nom du client',
SUM(total)
FROM clients AS c 
LEFT JOIN projets AS p ON p.client_id = c.id
LEFT JOIN devis AS d ON d.projet_id = p.id
LEFT JOIN factures AS f ON f.devis_id = d.numero_devis
GROUP BY client;

/*4️⃣ Afficher le CA total*/
SELECT SUM(total) AS 'CA Total'
FROM clients AS c 
LEFT JOIN projets AS p ON p.client_id = c.id
LEFT JOIN devis AS d ON d.projet_id = p.id
LEFT JOIN factures AS f ON f.devis_id = d.numero_devis;

/*5️⃣ Afficher la somme des factures en attente de paiement
ça veut dire date de paiement à null*/
SELECT SUM(total) AS 'Total factures'
FROM clients AS c 
LEFT JOIN projets AS p ON p.client_id = c.id
LEFT JOIN devis AS d ON d.projet_id = p.id
LEFT JOIN factures AS f ON f.devis_id = d.numero_devis
WHERE date_paiement IS NULL;

/*6️⃣ Afficher les factures en retard de paiment 30 jours max
Avec le nombre de jours de retard*/
SELECT DATEDIFF(NOW(), date_edition) AS 'Nombre de jour'
FROM clients AS c 
JOIN projets AS p ON p.client_id = c.id
JOIN devis AS d ON d.projet_id = p.id
JOIN factures AS f ON f.devis_id = d.numero_devis
WHERE date_paiement IS NULL;

SELECT COALESCE(DATEDIFF(NOW(), date_edition)) AS 'Nombre de jour'
FROM devis AS d
INNER JOIN factures AS f ON f.devis_id = d.numero_devis
WHERE date_paiement IS NULL;

/*Mes essais : date edition + 30j < today*/

SELECT 
numero_facture, 
date_edition, 
ADDDATE(date_edition, INTERVAL 30 DAY) AS 'retard', 
NOW() AS 'today',
DATEDIFF(NOW(), ADDDATE(date_edition, INTERVAL 30 DAY)) AS 'Nombre de jour'
FROM factures
WHERE date_paiement IS NULL
AND ADDDATE(date_edition, INTERVAL 30 DAY) <= NOW();

SELECT 
numero_facture, 
DATEDIFF(
    NOW(), 
    DATE_ADD(date_edition, INTERVAL 30 DAY)
    ) 
AS 'Nombre de jour'
FROM factures
WHERE DATEDIFF (NOW(), date_edition) > 30
AND date_paiement IS NULL;

/*Essai Quentin*/
SELECT 
numero_facture, 
DATEDIFF(
    CURRENT_DATE, 
    DATE_ADD(date_edition, INTERVAL 30 DAY)
    ) 
AS 'Nombre de jour'
FROM factures
WHERE DATEDIFF (CURRENT_DATE, date_edition) > 30
AND date_paiement IS NULL;

/*celle de JFV*/
SELECT numero_facture,
DATEDIFF(CURDATE(),date_edition) AS nb_jours
FROM factures 
WHERE date_paiement IS NULL
AND DATEDIFF(CURDATE(),date_edition)  > 30;