#Team_ Project 
#Database Creation file 
#Notes: If changes need to be made to design, please add comment and make change in database design: https://lucid.app/lucidchart/7184eecd-2be3-4a9c-980e-153cd7cb40c1/edit?invitationId=inv_97aa72d9-8241-4889-939a-19b138899679&page=0_0#
#
#
##############################################################################################
use group_project_team8;

create table Garden (
gardenID			Int 		NOT NULL AUTO_INCREMENT,
gardenLocation 		Char(35) 	NOT NULL,
CONSTRAINT			gardenPK	PRIMARY KEY(gardenID)
);
# Changes: removed syntax error


create table Bed (
bedNo			Int 			NOT NULL, 
gardenID		Int				NOT NULL, 
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
				REFERENCES Garden(gardenID)
                ON UPDATE CASCADE
				ON DELETE RESTRICT
); 
# Changes:
# Removed auto_increment from primary key, it is not a surrogate key and gardens have set number of beds
# Added DELETE restriction 
# Added ON UPDATE CASCADE
	
create table Crop_Info (
cropID 			Int				NOT NULL auto_increment,
cropName		Char(35)		not null,
cropFamily		char(35) 		not null,
soilType		char(25)		null,
sunNeeds		char(25)		null,
variety			char(25)		not null,
seasonID		int				not null, 
constraint		cropInfoPK		primary key(cropID),
constraint 		cropFK			foreign key(cropName) references Current_Crop(cropName),
constraint 		seasonFK		foreign key(seasonID) references Season(seasonID),
constraint		cropAK			foreign key(cropFamily) references Current_Crops(cropFamily),
constraint 		cropFamilyValues check 
				(cropFamily in ('Alliaceae','non-rotation crop','Solanaceae','Umbelliferea','Cucurbits','Chenopodiaceae','Legumes','Brassicas'))
);
#Changes:
#Added references for cropName to reference CurrentCrop
#Addeed references for seasonID to reference Season

create table Season (
seasonID 		int				not null auto_increment,
seasonName		char(10)		not null,
constraint		seasonPK		primary key(seasonID),
constraint		seasonAK		unique(seasonName),
constraint		seasonValues	check
				(seasonName in ('Spring','Summer','Fall','Winter','Year Round'))
);

create table Current_Crops (
cropName 		char(35)		not null,
plantStatus 	char(25) 		null,
yearPlanted		year			not null,
constraint 		currentCropPK	primary key(cropName),
constraint		currentCropFK	foreign key(cropFamily) references Crop_Info(cropFamily),
constraint		bedFK			foreign key(bedNo) references Bed(BedNo),
constraint 		cropIdFK		foreign key(cropID) references Crop_Info(cropID),
constraint		seasonID 		foreign key(seasonName) references Season(seasonName)
#concat seasonName and yearplanted to get semesterPlanted
);
#Added references

create table Reserver (
firstNmae		char(35)		not null,
lastName		char(35) 		not null,
email 			char(50) 		null,
semesterAssigned char(35) 		not null,
constraint		reserverPK		primary key(lastName),
constraint 		reserverNameAK	unique(firstName),
constraint 		reserverEmailAK	unique(email),
constraint		reserverFK		foreign key(bedNo) references Bed(bedNo)
);
#Added references to reserverFK

create table Inventory (
productName		char(50) 		not null,
quantityInGarden int 			null,
constraint		inventoryPK		primary key(productName),
constraint		inventoryFK 	foreign key(productID) references InventoryTransactions(productID)
);
#Changes foreign key name from productID to -> inventoryFK
#Added reference to inventoryFK

create table InventoryTransactions (
productID		int				not null auto_increment,
quantityPurchased int			not null,
datePurchased	date			not null,
price			decimal(10,2)	not null,
constraint		InventoryTransPK primary key(productID),
constraint 		InventoryTransAK unique(datePurchased),
constraint		InventoryTransFK foreign key(productName) references Inventory(productName)
);
#Added reference to InventoryTransFK

create table FoodWaste (
dateReported	date			not null,
wasteType		char(20)		not null,
weight			int				not null,
constraint		FoodWastePK		primary key(dateReported),
constraint 		FoodWasteValue	check
				(wasteType in ('Produce','Coffee Grounds'))
);
#Removed unique constraint on waste type 
