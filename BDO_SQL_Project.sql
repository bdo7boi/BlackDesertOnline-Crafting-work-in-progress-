/*This database replicates the storage system in Black Desert Online. Each Player will have an assigned storage and items they
possess will be tied to their unique storage. Items will each have a unique recipe(if craftable) that designates the
required items and quantities in order to craft that item. Craftable items will also have a "bonus procs" that can be 
rewarded alongside a crafted item at a small chance that has increased market price. The purpose of this project will be to 
replicate the crafting system in Black Desert Online in order to identify areas in the crafting ecosystem that can be altered
to maximize profit. 
*/
DROP DATABASE IF EXISTS BlackDesertOnlineProject;
CREATE DATABASE BlackDesertOnlineProject;
USE BlackDesertOnlineProject;

#table that will hold player ID's along with their in-game name
CREATE TABLE Player(
	playerID INT AUTO_INCREMENT PRIMARY KEY,
    playerName VARCHAR(255),
    storageID INT
    #FOREIGN KEY(storageID) REFERENCES Storage(storageID)
);



#table that will hold the unique storage ID linked to each player.alter
CREATE TABLE Storage(
	storageID INT AUTO_INCREMENT PRIMARY KEY,
    storageName VARCHAR(255),
    playerID INT,
    FOREIGN KEY(playerID) REFERENCES Player(playerID)
);

ALTER TABLE Player ADD FOREIGN KEY(storageID) REFERENCES Storage(storageID);

#table that will hold the value of every unique item. Each item will have a boolean value that will check if it is craftable. 
#items that are not craftable return NULL craftRecipeID. certain items will have bonus items that generate alongside the crafted item.
CREATE TABLE Items(
	itemID INT PRIMARY KEY,
    itemName VARCHAR(255),
    marketPrice INT,
    isCraftable BOOLEAN,
    recipeID INT,
    bonusItemID int
    #FOREIGN KEY(craftRecipeID) REFERENCES Recipe(recipeID),
    #FOREIGN KEY(bonusItemID) REFERENCES BonusItem(bonusItemID)
);


CREATE TABLE Recipes(
	recipeID INT AUTO_INCREMENT PRIMARY KEY,
    craftedItemID INT,
    numOfIngredients INT
    #FOREIGN KEY(craftedItemID) REFERENCES Items(itemID),
    #FOREIGN KEY(ingredientID) REFERENCES Items(itemID)
);


CREATE TABLE ingredients(
	recipeID INT AUTO_INCREMENT PRIMARY KEY,
    craftedItemID INT,
    itemID INT,
    quantity INT,
    FOREIGN KEY(recipeID) REFERENCES Recipes(recipeID),
    FOREIGN KEY(itemID) REFERENCES Items(itemID)
    
);

ALTER TABLE Items ADD FOREIGN KEY(recipeID) REFERENCES Recipes(recipeID);

CREATE TABLE BonusItem(
	bonusItemID INT PRIMARY KEY,
    marketPrice INT,
    itemID INT,
    FOREIGN KEY(itemID) REFERENCES Items(itemID)
);

ALTER TABLE Items ADD FOREIGN KEY(bonusItemID) REFERENCES BonusItem(bonusItemID);

CREATE TABLE Storage_Items(
	storageID INT,
    itemID INT,
    quantity INT,
    PRIMARY KEY (storageID, itemID),
    FOREIGN KEY(storageID) REFERENCES Storage(storageID),
    FOREIGN KEY(itemID) REFERENCES Items(itemID)
);



