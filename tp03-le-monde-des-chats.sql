DROP DATABASE IF EXISTS zoo;

CREATE DATABASE zoo CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

USE zoo;

CREATE TABLE chats (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(255) NOT NULL, 
    yeux VARCHAR (255) NOT NULL,
    age INT NOT NULL 
)
ENGINE=InnoDB;

/*1️⃣ - Ajouter les données*/

INSERT INTO chats (nom, yeux, age)
VALUES
    ('Maine Coon', 'marron', 20),
    ('Siamois', 'bleu', 15),
    ('Bengal', 'marron', 18),
    ('Scottish Fold', 'marron', 10);

/*2️⃣ - Afficher le chat avec l'id :2 */
SELECT * FROM chats
WHERE id=2;

/*3️⃣ - Trier les chats par nom et par age */
SELECT * FROM chats 
ORDER BY nom, age;

/*4️⃣ - Afficher les chats qui vive entre 11 et 19 ans */
SELECT * from chats
WHERE age BETWEEN 11 AND 19;

/*5️⃣ - Afficher le ou les chats dont le nom contient 'sia' */
SELECT * from chats
WHERE nom LIKE '%sia%';

/*6️⃣ - Afficher le ou les chats dont le nom contient 'a'*/
SELECT * from chats
WHERE nom LIKE '%a%';

/*7️⃣ - Afficher la moyenne d'age des chats*/
SELECT AVG(age) from chats;

/*8️⃣ - Afficher le nombre de chats dans la table*/
SELECT count(nom) FROM chats;

/*9️⃣ - Afficher le nombre de chat avec couleur d'yeux marron*/
SELECT count(nom) FROM chats
WHERE yeux = 'marron';

/*10 - Afficher le nombre de chat par couleur d'yeux*/
SELECT yeux, count(id) AS nb_chat FROM chats
GROUP BY yeux;

/*NOTES : COUNT majuscule, on évite '*' */