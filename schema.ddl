drop schema if exists ParadisePapers cascade;
create schema ParadisePapers;
set search_path to ParadisePapers;

-- The Human Development Index is defined as a rational number between 0 and 1 
-- The higher the value the higher the country's development
-- We will be using the country rank, as per their index rather than the index itself
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

-- A country in the world that is recognized by the United Nations (UN)
create table Country (
	-- A country's official name
	cName varchar(45) not null unique,
	-- A country's ISO 3166-1 alpha-3 code
	-- (or alpha-2 code if alpha-3 code is unavailable)
	cID varchar(3) primary key,
	-- A country's latest population 
	-- Recorded in thousands (i.e. 83 million = 83000 thousands)
	population float not null
);

-- An officer of an entity; a person who plays a role in an entity
-- e.g. Entity founder or CEO
create table Officer (
	oID integer primary key,
	-- Officer's full name
	-- Due to nature of dataset, formatting is not consistent
	oName varchar(100) not null,
	-- The country code of an officer's country of residence
	cID varchar(3) not null,
	foreign key (cID) references Country
);

-- An entity/a company
-- "A company, trust or fund created by an agent in a low-tax jurisdiction 
-- that often attracts non-resident clients through preferential tax treatment"
-- Reference: offshoreleaks.icij.org/pages/faq
create table Entity (
	eID integer primary key,
	-- The name of an entity 
	eName varchar(100) not null,
	-- The country code of the country where the entity operates
	jurisdictionID varchar(3) not null,
	foreign key (jurisdictionID) references Country
);

-- An intermediary for an entity and an officer
-- "A go-between for someone seeking an offshore corporation and an offshore service provider 
-- usually a law-firm or a middleman that asks an offshore service provider to create an offshore firm for a client"
-- Reference: offshoreleaks.icij.org/pages/faq
create table Intermediary (
	iID integer primary key,
	-- Intermediaries name
	-- Due to nature of dataset, formatting is not consistent
	iName varchar(100),
	-- The country code of an intermediary's country of residence
	cID varchar(3) not null,
	foreign key (cID) references Country
);

-- Every UN member ranked by their level of human development
create table HumanDevelopment (
	-- A country's rank in 2018
	hdiRank HDIRank,
	-- A country's official name according to the UN
	cName varchar(45) primary key
);

-- Transparency International's corruption perception index 
create table CorruptionPerception(
	-- A country's code
	cID varchar(3) primary key,
	-- A country's perceived corruption
	cpindex CPIndex,
	foreign key (cID) references Country
);