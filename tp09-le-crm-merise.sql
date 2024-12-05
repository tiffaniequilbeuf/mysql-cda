#------------------------------------------------------------
#        Script MySQL.
#------------------------------------------------------------


#------------------------------------------------------------
# Table: client
#------------------------------------------------------------

CREATE TABLE client(
        id     Int  Auto_increment  NOT NULL ,
        client Varchar (255) NOT NULL
	,CONSTRAINT client_PK PRIMARY KEY (id)
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: projet
#------------------------------------------------------------

CREATE TABLE projet(
        id          Int  Auto_increment  NOT NULL ,
        designation Varchar (255) NOT NULL ,
        version     Int ,
        id_client   Int NOT NULL
	,CONSTRAINT projet_PK PRIMARY KEY (id)

	,CONSTRAINT projet_client_FK FOREIGN KEY (id_client) REFERENCES client(id)
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: devis
#------------------------------------------------------------

CREATE TABLE devis(
        numero_devis Varchar (255) NOT NULL ,
        montant      Int NOT NULL ,
        id           Int NOT NULL
	,CONSTRAINT devis_PK PRIMARY KEY (numero_devis)

	,CONSTRAINT devis_projet_FK FOREIGN KEY (id) REFERENCES projet(id)
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: facture
#------------------------------------------------------------

CREATE TABLE facture(
        numero_facture Varchar (255) NOT NULL ,
        info           Varchar (255) NOT NULL ,
        total          Int NOT NULL ,
        date_edition   Date NOT NULL ,
        date_paiement  Date NOT NULL ,
        numero_devis   Varchar (255) NOT NULL
	,CONSTRAINT facture_PK PRIMARY KEY (numero_facture)

	,CONSTRAINT facture_devis_FK FOREIGN KEY (numero_devis) REFERENCES devis(numero_devis)
)ENGINE=InnoDB;

