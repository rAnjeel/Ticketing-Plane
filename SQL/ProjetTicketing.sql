-- Création de la base de données
CREATE DATABASE ticketing;

-- Se connecter à la base de données
\c ticketing

CREATE TABLE Role(
   id_role INTEGER,
   nom VARCHAR(150)  NOT NULL,
   PRIMARY KEY(id_role)
);

CREATE TABLE VilleDesservie(
   id_ville INTEGER,
   nom VARCHAR(250)  NOT NULL,
   pays VARCHAR(150)  NOT NULL,
   code_aeroport INTEGER,
   PRIMARY KEY(id_ville)
);

CREATE TABLE Modele(
   id_modele INTEGER,
   nom VARCHAR(50)  NOT NULL,
   PRIMARY KEY(id_modele),
   UNIQUE(nom)
);

CREATE TABLE TypeSiege(
   id_type INTEGER,
   nom VARCHAR(150)  NOT NULL,
   PRIMARY KEY(id_type),
   UNIQUE(nom)
);

CREATE TABLE Vol(
   id_vol INTEGER,
   date_depart TIMESTAMP NOT NULL,
   date_arrivee TIMESTAMP NOT NULL,
   id_ville_depart INTEGER NOT NULL,
   id_ville_arrivee INTEGER NOT NULL,
   PRIMARY KEY(id_vol),
   FOREIGN KEY(id_ville_depart) REFERENCES VilleDesservie(id_ville),
   FOREIGN KEY(id_ville_arrivee) REFERENCES VilleDesservie(id_ville)
);

CREATE TABLE Utilisateur(
   id_utilisateur INTEGER,
   email VARCHAR(150)  NOT NULL,
   mdp VARCHAR(50)  NOT NULL,
   id_role INTEGER,
   PRIMARY KEY(id_utilisateur),
   UNIQUE(email),
   FOREIGN KEY(id_role) REFERENCES Role(id_role)
);

CREATE TABLE Avion(
   id_avion INTEGER,
   immatriculation VARCHAR(50) NOT NULL,   
   date_fabrication DATE NOT NULL,
   id_ville_base INTEGER,
   id_modele INTEGER NOT NULL,
   PRIMARY KEY(id_avion),
   UNIQUE(immatriculation),
   FOREIGN KEY(id_ville_base) REFERENCES VilleDesservie(id_ville),
   FOREIGN KEY(id_modele) REFERENCES Modele(id_modele)
);

CREATE TABLE AvionTypeSiege(
   id_avion INTEGER,
   id_type INTEGER,
   nb_sieges VARCHAR(50) ,
   PRIMARY KEY(id_avion, id_type),
   FOREIGN KEY(id_avion) REFERENCES Avion(id_avion),
   FOREIGN KEY(id_type) REFERENCES TypeSiege(id_type)
);

CREATE TABLE PassagersVol(
   id_utilisateur INTEGER,
   id_vol INTEGER,
   PRIMARY KEY(id_utilisateur, id_vol),
   FOREIGN KEY(id_utilisateur) REFERENCES Utilisateur(id_utilisateur),
   FOREIGN KEY(id_vol) REFERENCES Vol(id_vol)
);
