CREATE DATABASE IF NOT EXISTS group_project_team8;
USE group_project_team8;


DROP TABLE IF EXISTS Crop_Info;
CREATE TABLE Crop_Info (
  cropID int NOT NULL AUTO_INCREMENT,
  cropName char(35) NOT NULL,
  cropFamily char(35) NOT NULL,
  soilType char(25) DEFAULT NULL,
  sunNeeds char(25) DEFAULT NULL,
  variety char(25) NOT NULL,
  CONSTRAINT cropInfoPK PRIMARY KEY (cropID),
  CONSTRAINT cropFamilyValues CHECK (cropFamily in ('Alliaceae','non-rotation crop','Solanaceae','Umbelliferea','Cucurbits','Chenopodiaceae','Legumes','Brassicas'))
);

--
-- Table structure for table Season
--

DROP TABLE IF EXISTS Season;

CREATE TABLE Season (
  seasonID int NOT NULL AUTO_INCREMENT,
  seasonName char(10) NOT NULL,
  CONSTRAINT seasonPK PRIMARY KEY (seasonID),
  UNIQUE KEY seasonAK (seasonName),
  CONSTRAINT seasonValues CHECK (seasonName in ('Spring','Summer','Fall','Winter','Year Round'))
);


-- Table structure for table Crop_Season
--

DROP TABLE IF EXISTS Crop_Season;
CREATE TABLE Crop_Season (
  cropID int NOT NULL,
  seasonID int NOT NULL,
  CONSTRAINT Crop_SeasonPK PRIMARY KEY (cropID,seasonID),
  CONSTRAINT Crop_InfoFK FOREIGN KEY (cropID) REFERENCES Crop_Info (cropID),
  CONSTRAINT SeasonFK FOREIGN KEY (seasonID) REFERENCES Season (seasonID)
);

-- Table structure for table Current_Crops
--

DROP TABLE IF EXISTS Current_Crops;

CREATE TABLE Current_Crops (
  cropName char(35) NOT NULL,
  plantStatus char(25) DEFAULT NULL,
  cropID int NOT NULL,
  CONSTRAINT currentCropPK PRIMARY KEY (cropName),
  CONSTRAINT cropIdFK FOREIGN KEY (cropID) REFERENCES Crop_Info (cropID)
);


Create TABLE Garden (
    gardenID INT NOT NULL AUTO_INCREMENT,
    gardenName char(30) NOT NULL,
    gardenLocation Char(30),
    CONSTRAINT gardenPK PRIMARY KEY (gardenID)
);

CREATE TABLE Bed (
    bedNO char(5) NOT NULL,
    size decimal(10, 2) NOT NULL,
    soilType char(10) NOT NULL,
    bedStatus char(35) NOT NULL,
    gardenID INT NOT NULL,
    CONSTRAINT bedPK PRIMARY KEY (bedNO),
    CONSTRAINT bedSize CHECK (size > 0),
    CONSTRAINT bedSoilType CHECK (soilType IN ('sand-loamy', 'silt-loamy', 'sandy', 'loamy','clay-loamy','clay')),
    CONSTRAINT bedStatus CHECK (bedStatus IN ('Planted', 'Turned', 'Cover Crop', 'Reserved', 'Fertilized') ),
    CONSTRAINT gardenFK FOREIGN KEY (gardenID) REFERENCES Garden (gardenID)
);


CREATE TABLE Growing_Bed(
  cropName char(35) NOT NULL,
  bedNO char(5) NOT NULL,
  datePlanted DATE NOT NULL,
  dateHarvested DATE NULL,
  issuesEncountered TEXT NULL,
  CONSTRAINT Growing_BedPK PRIMARY KEY (cropName, bedNO, datePlanted),
  CONSTRAINT Current_CropsFK FOREIGN KEY (cropName) REFERENCES Current_Crops(cropName)
        ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT BedFK FOREIGN KEY (bedNO) REFERENCES Bed(bedNO)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT ValidHarvestDate CHECK (dateHarvested IS NULL OR dateHarvested >= datePlanted)
);


