SET SEARCH_PATH TO paradisepapers, public;

-- How many entities and individuals were involved per country and what is the percentage of the population that is corrupt?
DROP TABLE IF EXISTS q1 cascade;

CREATE TABLE q1 (
    num_entities INT,
    num_individuals INT,
    percentage_individuals FLOAT,
    cID varchar(3),
    cName varchar(45)
);

DROP VIEW num_entities IF EXISTS CASCADE;
DROP VIEW num_individuals IF EXISTS CASCADE;
DROP VIEW percentage_individuals IF EXISTS CASCADE;

create view num_entities as 
select (CASE
    WHEN count(e.eid) IS NOT NULL THEN count(e.eid)
    ELSE 0
    END)as num_entities,c.cID as cID,cName as cName
from country c left join entity e on c.cID=e.jurisdictionID
group by c.cID;

create view num_individuals as 
select (CASE
    WHEN count(i.iid)+count(o.oid) IS NOT NULL THEN count(i.iid)+count(o.oid)
    ELSE 0
    END)as num_individuals,c.cID as cID,cName as cName
from country c left join officer o on c.cID=o.cID left join Intermediary i on i.cID = c.cID
group by c.cID;

create view percentage_individuals as 
select num_individuals.num_individuals/(c.population*1000)*100 as percentage_individuals, c.cID
from num_individuals left join country c on num_individuals.cID = c.cID
order by percentage_individuals desc;

insert into q1
select num_entities.num_entities, num_individuals.num_individuals, percentage_individuals.percentage_individuals,
num_entities.cID as cID,num_entities.cName as cName from 
num_entities,num_individuals,percentage_individuals
where num_entities.cID = num_individuals.cID and num_entities.cID = percentage_individuals.cID
order by percentage_individuals.percentage_individuals desc;


-- How many countries were involved and what is the biggest tax haven?
DROP TABLE IF EXISTS q2 cascade;

CREATE TABLE q2 (
    num_countries INT
);

-- Number of countries involved
insert into q2
select count(distinct ni.cID) as num_countries
from num_individuals ni,num_entities ne
where ni.num_individuals > 0 or ne.num_entities > 0 and ni.cID = ne.cID;

-- Biggest tax haven
select max(percentage_individuals) as max_percentage, cID, cName as biggest_tax_haven
from q1
group by cID,cName
order by max_percentage desc
limit 1;

-- Upon comparing the human development index, the corruption perception index, and the percentage of the population that is corrupt,
-- can we reach a conclusion about how they are related?
DROP TABLE IF EXISTS q3 cascade;

CREATE TABLE q3 (
    cID varchar(3),
    cName varchar(45),
    hdiRank hdiRank,
    cpindex CPIndex,
    percentage_individuals FLOAT
);

insert into q3
select q1.cID,q1.cName,h.hdiRank,cp.cpindex,q1.percentage_individuals
from q1,humandevelopment h, corruptionperception cp 
where q1.cID = cp.cID and q1.cName=h.cName
order by q1.percentage_individuals desc;