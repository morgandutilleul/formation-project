create database projet;
show databases;
use projet;


create table Utilisateur (
  login varchar(30),
   mdp varchar(30),
   emailAdr varchar(50),
   primary key(login)
   );

desc Utilisateur;

create table Formation (
  nomFormation char(30),
    nbrStagiaire tinyint,
  	emailAdr char(50),
   	primary key(nomFormation)
   );

desc Formation;

create table Personne (
	emailAdr char(50) primary key,
	nom char(30),
	prenom char(30),
	typePersonne char(12) check(typePersonne in ('Stagiaire', 'Formateur', 'Gestionnaire')),
	nomFormation char(30),
	constraint FK_nomFormation_Personne foreign key(
		nomFormation) references Formation (nomFormation)
	);


alter table Formation
add constraint fk_Email_Formation foreign key (emailAdr) references Personne(emailAdr);

alter table Utilisateur
add constraint fk_Email_Utilisateur foreign key (emailAdr) references Personne(emailAdr);


create table Cours (
  nomCours char(30) primary key,
  dateDebut date,
  nbrJours tinyint,
  nomFormation char(30),
  constraint FK_nomFormation_Cours foreign key(
    nomFormation) references Formation (nomFormation)
  );

desc Cours;

create table CoursPersonne (
  nomCours char(30),
  emailAdr char(50),
  primary key (nomCours,emailAdr),
  constraint FK_nomCours_CoursPersonne foreign key(
  nomCours) references Cours (nomCours),
  constraint FK_emailAdr_CoursPersonne foreign key(
  emailAdr) references Personne (emailAdr)
  );


desc CoursPersonne;

create table DocumentCours (
  nomDoc char(30) primary key,
  nomCours char(30),
  constraint FK_nomCours_DocumentCours foreign key(
  nomCours) references Cours (nomCours)
  );

desc DocumentCours;

create table Qcm (
  nomQcm char(30) primary key,
  dureeQcm time,
  nomCours char(30),
  constraint FK_nomCours_Qcm foreign key(
  nomCours) references Cours (nomCours)
  );

desc Qcm;

create table Question (
  contenuQuestion varchar(500) primary key,
  nbrChoix tinyint,
  nomQcm char(30),
  constraint FK_nomCours_Question foreign key(
  nomQcm) references Qcm (nomQcm)
  );

desc Question;

create table Reponse (
  ContenuReponse varchar(500) primary key,
  indice char(1) check(indice in ('a', 'b', 'c', 'd', 'e')),
  etat boolean,
  contenuQuestion varchar(500),
  constraint FK_nomCours_Reponse foreign key(
  contenuQuestion) references Question (contenuQuestion)
  );

desc Reponse;

show tables;