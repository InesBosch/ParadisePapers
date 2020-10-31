drop schema if exists ParadisePapers cascade;
create schema ParadisePapers;
set search_path to ParadisePapers;

-- The Human Development Index is defined as a rational number between 0 and 1 
-- The higher the value the higher the country's development
-- Reference: https://en.wikipedia.org/wiki/Human_Development_Index
create domain HDIRank as numeric(10,3) 
    default null 
    check(value>=0 and value<=1.0);

-- The Corruption Perception Index is defined as an integer number between 0 and 100
-- The lower the value the more corrupt the coutry 
-- Reference: https://en.wikipedia.org/wiki/Corruption_Perceptions_Index
create domain CPIndex as smallint
    default null
    check(value>=0 and value<=100);

create table Country (
	cID integer primary key,
	cName varchar(45) not null unique,
	population integer not null
);

create table Officer (
	oID integer primary key,
	cID integer not null,
	oName varchar(45),
	foreign key (cID) references Country
);

create table Entity (
	eID integer primary key,
	cID integer not null,
	jurisdictionID integer,
	incorporationDate date not null,
	closeDate date,
	foreign key (cID) references Country
);

create table Intermediary (
	iID integer primary key,
	cID integer not null,
	iName varchar(45),
	foreign key (cID) references Country
);

create table HumanDevelopment (
	cID integer primary key,
	hdiRank HDIRank,
	foreign key (cID) references Country
);

create table CorruptionPerception(
	cID integer primary key,
	cpindex CPIndex,
	foreign key (cID) references Country
);