/*BASE : Créer la base de donnée*/
DROP DATABASE IF EXISTS location_ski;

CREATE DATABASE location_ski CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

USE location_ski;

CREATE TABLE clients (
    no_client INT NOT NULL AUTO_INCREMENT,
    nom VARCHAR(30) NOT NULL, 
    prenom VARCHAR(30),
    adresse VARCHAR(120),
    code_postal VARCHAR(5) NOT NULL,
    ville VARCHAR(80) NOT NULL, 
    CONSTRAINT pk_clients PRIMARY KEY(no_client)
)ENGINE=InnoDB;

CREATE TABLE fiches (
        no_fiche INT NOT NULL AUTO_INCREMENT,
        no_client INT NOT NULL,
        date_creation DATE NOT NULL,
        date_paiement DATE,
        etat ENUM ('EC', 'RE', 'SO') NOT NULL,
        CONSTRAINT pk_fiches PRIMARY KEY(no_fiche)
)ENGINE=InnoDB;*

CREATE TABLE lignes_fiche (
        no_ligne INT NOT NULL AUTO_INCREMENT,
        no_fiche INT NOT NULL,
        reference_article VARCHAR(8) NOT NULL,
        depart DATE NOT NULL,
        retour DATE,
        CONSTRAINT pk_lignes_fic PRIMARY KEY(no_ligne)
)ENGINE=InnoDB;

CREATE TABLE articles (
    reference_article CHAR(8) NOT NULL,
    designation VARCHAR(80) NOT NULL,
    code_gamme CHAR(5),                                     
    code_categorie CHAR(5),                                 
    CONSTRAINT pk_articles PRIMARY KEY(reference_article)
)ENGINE=InnoDB;

CREATE TABLE categories (
    code_categorie CHAR(5) NOT NULL,                        /* /!\ FK*/
    libelle VARCHAR(30) NOT NULL,
    CONSTRAINT pk_categories PRIMARY KEY(code_categorie)
)ENGINE=InnoDB;

CREATE TABLE gammes (
    code_gamme CHAR(5) NOT NULL,                           /* /!\ FK*/   
    libelle VARCHAR(30) NOT NULL,
    CONSTRAINT pk_gamme PRIMARY KEY(code_gamme)
)ENGINE=InnoDB;

/*Table pivot ? */
CREATE TABLE grille_tarifs (
    code_gamme CHAR(5) NOT NULL,                         /* /!\ FK*/
    code_categorie CHAR(5) NOT NULL,                     /* /!\ FK*/
    code_tarif CHAR(5),
    CONSTRAINT pk_grille_tarifs PRIMARY KEY(code_gamme, code_categorie)
)ENGINE=InnoDB;

CREATE TABLE tarifs (
    code_tarif CHAR(5) NOT NULL,
    libelle VARCHAR(30) NOT NULL,
    prix_jour DECIMAL(5, 0),
    CONSTRAINT pk_tarifs PRIMARY KEY(code_tarif)
)ENGINE=InnoDB;

/*----------FIN DES SAISIS DANS PHPMYADMIN -------------------------*/

/*[OneToMany] Un client peut avoir plusieurs fiches*/
ALTER TABLE fiches ADD CONSTRAINT FOREIGN KEY (no_client) REFERENCES clients(no_client);

/*[OneToMany] Un fiche peut avoir plusieurs lignes sur une fiche*/
ALTER TABLE lignes_fiche ADD CONSTRAINT FOREIGN KEY (no_fiche) REFERENCES fiches(no_fiche);

/*[OneToMany] Une reference d'article peut être dans plusieurs lignes de la fiche */
ALTER TABLE lignes_fiche ADD CONSTRAINT FOREIGN KEY (reference_article) REFERENCES articles(reference_article);

/*[OneToMany] Un code categorie peut être dans plusieurs articles ET dans plusieurs grilles tarifaires */
ALTER Table categories ADD CONSTRAINT fk_categories_code_categorie FOREIGN KEY (code_categorie) REFERENCES articles(code_categorie);
ALTER Table categories ADD CONSTRAINT fk_categories_code_categorie FOREIGN KEY (code_categorie) REFERENCES grille_tarifs(code_categorie);

/*[OneToMany] Un code gamme peut être dans plusieurs articles ET dans plusieurs grilles tarifaires */
ALTER Table gammes ADD CONSTRAINT fk_gamme_code_gamme FOREIGN KEY (code_gamme) REFERENCES articles(code_gamme);
ALTER Table gammes ADD CONSTRAINT fk_categories_code_categorie FOREIGN KEY (code_gamme) REFERENCES grille_tarifs(code_gamme);

/*[OneToMany] Un code tarif peut être dans plusieurs grilles tarifaires */
ALTER Table tarifs ADD CONSTRAINT fk_tarifs_code_tarif FOREIGN KEY (code_tarif) REFERENCES grille_tarifs(code_tarif);



