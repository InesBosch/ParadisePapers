# Paradise Papers Analysis
We are analyzing the consequences of widespread tax evasion, offshore investments, and corruption by developing a database using PostgreSQL. The Paradise Papers dataset, whose data was the collective effort of the German newspaper Süddeutsche Zeitung, the International Consortium of Investigative Journalists (ICIJ) and 95 media partners, is our focal point.

The UN Human Development Programme's Human Development Index dataset and the Transparency International Perceived Corruption dataset will also be used to provide further insight.
## Learning Goals
We wish to investigate the following questions in relation to the database that we will be creating:

    1. How many companies and individuals were unveiled in the Paradise Papers leak?
    2. How many countries were involved and what is the biggest tax haven?
    3. Can we compare the human development index with the corruption perception index and reach a conclusion about how they are correlated?
## Schema
Our database will contain the following 7 tables:

    1. Officer (oID, cID, oName)
A tuple in this relation contains an officer's (a person directly involved in a shell corporation) personal ID, country of residence ID, and name.

    2. Intermediary (iID, cID, iName) 
A tuple in this relation contains an intermediary's (a person who is indirectly involved in a shell corporation) personal ID, country of residence ID, and name.

    3. Entity (eID, cID, jurisdictionID)
A tuple in this relation contains an entity's (a shell corporation) ID, country of origin ID, and location of operation (jurisdiction) ID.

    4. Address (aID, address, cID)
A tuple in this relation contains the address of officers/intermediaries/entities with its ID, actual address and ID of the country.

    5. Country (cID, cName, population)
A tuple in this relation contains a given country's ID, name, and population.

    6. HumanDevelopment (cID,  HDIRank) 
A tuple in this relation contains a country's ID and human development index rank.

    7. CorruptionPerception (cID, CPIndex)
A tuple in this relation contains a country's ID and perceived corruption index.
## Todo
We are currently working on removing null values, redundant values and on the creation of the PostgreSQL database.
## Credits
Thanks to the ICIJ, the UN, and the Transparency International organizations for providing the open data for this project!

ICIJ dataset: https://offshoreleaks.icij.org/pages/database

UN HDI dataset: http://hdr.undp.org/en/data#

TI Corruption dataset: https://www.transparency.org/en/cpi/2018/results