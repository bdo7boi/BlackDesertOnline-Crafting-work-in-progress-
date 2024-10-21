USE blackdesertonlineproject;
SET GLOBAL local_infile=1;

SET FOREIGN_KEY_CHECKS = 0;



LOAD DATA LOCAL INFILE 'C:\\Users\\Provectus Alpha\\Desktop\\BDO_SQL Project\\BDO_Ingredients.csv'
INTO TABLE Ingredients
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(itemID, craftedItemID, quantity);


SET FOREIGN_KEY_CHECKS = 1;


