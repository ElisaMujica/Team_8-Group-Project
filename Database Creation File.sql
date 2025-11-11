#Team_ Project 
#Database Creation file 
#Notes: If changes need to be made to design, please add comment and make change in database design: https://lucid.app/lucidchart/7184eecd-2be3-4a9c-980e-153cd7cb40c1/edit?invitationId=inv_97aa72d9-8241-4889-939a-19b138899679&page=0_0#
#
#
##############################################################################################
create table Garden (
gardenID			Int 		NOT NULL AUTO_INCREMENT,
gardenLocation 		Char(35) 		NOT NULL,
CONSTRAINT			gardenPK	PRIMARY KEY(gardenID),
CONSTRAINT 			bedFK 		FOREIGN KEY(bedNo)

# ADD FURTHER CONSTRAINTS
);

create table Bed (
bedNo			Int 			NOT NULL,
size 			Int 			NULL,
soilType		Char(10)		NULL,
bedStatus 		Char(35)		NULL,
CONSTRAINT		bedPK 			PRIMARY KEY(bedNo),
CONSTRAINT		soilTypeValues 	CHECK 
				(soilType in ('sand-loamy', 'silt-loamy', 'sandy', 'loamy','clay-loamy','clay')),
CONSTRAINT 	 	bedStatusValues	CHECK 
				(bedStatus IN ('Planted', 'Turned', 'Cover Crop', 'Reserved', 'Fertilized')),
CONSTRAINT		bedAK			UNIQUE(bedUser),
CONSTRAINT		gardenFK		FOREIGN KEY(gardenID)
);


