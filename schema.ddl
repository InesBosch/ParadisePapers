drop schema if exists ParadisePapers cascade;
create schema ParadisePapers;
set search_path to ParadisePapers;

-- The Human Development Index is defined as a rational number between 0 and 1 
-- The higher the value the higher the country's development
-- We will be using the country rank, as per their index
-- Reference: https://en.wikipedia.org/wiki/Human_Development_Index
create domain HDIRank as smallint 
    default null 
    check(value>=0 and value<=200);

-- The Corruption Perception Index is defined as an integer number between 0 and 100
-- The lower the value the more corrupt the coutry 
-- Reference: https://en.wikipedia.org/wiki/Corruption_Perceptions_Index
create domain CPIndex as smallint
    default null
    check(value>=0 and value<=100);

create table Country (
	cName varchar(45) not null unique,
	cID varchar(3) primary key,
	population float not null
);

create table Officer (
	oID integer primary key,
	oName varchar(100) not null,
	cID varchar(3) not null,
	foreign key (cID) references Country
);

create table Entity (
	eID integer primary key,
	eName varchar(100) not null,
	jurisdictionID varchar(3) not null,
	foreign key (jurisdictionID) references Country
);

create table Intermediary (
	iID integer primary key,
	iName varchar(100),
	cID varchar(3) not null,
	foreign key (cID) references Country
);

create table HumanDevelopment (
	hdiRank HDIRank,
	cName varchar(45) primary key
);

create table CorruptionPerception(
	cID varchar(3) primary key,
	cpindex CPIndex,
	foreign key (cID) references Country
);