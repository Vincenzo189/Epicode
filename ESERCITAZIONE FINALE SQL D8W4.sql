#CREO NUOVO DATABASE DENOMINATO ToysGroup
CREATE DATABASE ToysGroup;

USE ToysGroup;

#Creo la tabella prodotti
CREATE TABLE Product (
ProductID INT AUTO_INCREMENT PRIMARY KEY,
ProductName VARCHAR (50),
Price DECIMAL (10,2),
CategoryID INT,
CategoryName VARCHAR (25)
);

#Creo la tabella Regioni
CREATE TABLE Region (
RegionID INT AUTO_INCREMENT PRIMARY KEY,
RegionName VARCHAR (50)
);

#Creo la tabella STATE
CREATE TABLE State (
StateID INT AUTO_INCREMENT PRIMARY KEY,
StateName VARCHAR (50),
RegionID INT,
FOREIGN KEY (RegionID) REFERENCES Region(RegionID)
);

#VOGLIO CREARE UNA TABELLA CONTENENTE LE VENDITE PER OGNI PRODOTTO DI TOYSGROUP TENENDO CONTO DEL PRODOTTOID E DELLO STATO ID COME FOREIGN KEY
CREATE TABLE Sales (
SalesID INT AUTO_INCREMENT PRIMARY KEY,
ProductID INT,
StateID INT,
SaleDate DATE,
Quantity INT,
TotalAmount DECIMAL (10,2),
FOREIGN KEY (ProductID) REFERENCES Product(ProductID),
FOREIGN KEY (StateID) REFERENCES State(StateID)
);

#VOGLIO POPOLARE LE VARIE TABELLE
INSERT INTO Product (ProductName, Price, CategoryID, CategoryName) VALUES
('Lego City Set', 29.99, 1, 'Costruzioni'),
('Puzzle 1000 pezzi', 15.50, 2, 'Puzzle'),
('Bambola Interattiva', 39.99, 3, 'Bambole'),
('Treno Elettrico', 49.90, 1, 'Costruzioni'),
('Puzzle Animali 500 pezzi', 12.00, 2, 'Puzzle'),
('Bambola Fashion', 24.99, 3, 'Bambole'),
('Lego Star Wars', 59.99, 1, 'Costruzioni'),
('Puzzle Mappa del Mondo', 18.75, 2, 'Puzzle'),
('Bambola Baby con accessori', 34.50, 3, 'Bambole'),
('Lego Technic Auto da corsa', 89.00, 1, 'Costruzioni');

INSERT INTO Region (RegionName) VALUES
('NorthEurope'),
('SouthEurope'),
('EastEurope'),
('WestEurope'),
('CentralEurope'),
('NorthEast'),
('SouthEast'),
('NorthWest'),
('SouthWest'),
('MidEurope');

INSERT INTO State (StateName, RegionID) VALUES
('Italia', 1),
('Spagna', 1),
('Grecia', 1),
('Portogallo', 1),
('Croazia', 1),
('Francia', 4),
('Germania', 5),
('Austria', 5),
('Svizzera', 5),
('Polonia', 3),
('Ungheria', 3),
('Svezia', 2),
('Norvegia', 2),
('Estonia', 6),
('Romania', 7);

INSERT INTO Sales (ProductID, StateID, SaleDate, Quantity, TotalAmount) VALUES
(1, 1, '2023-03-15', 120, 3598.80),
(2, 2, '2023-06-10', 80, 1240.00),
(3, 3, '2024-01-22', 75, 2999.25),
(4, 4, '2024-07-18', 90, 4491.00),
(5, 5, '2025-02-10', 60, 720.00),
(6, 6, '2025-04-25', 100, 2499.00),
(7, 7, '2023-11-30', 150, 8998.50),
(8, 8, '2024-03-05', 130, 2437.50),
(9, 9, '2023-09-12', 85, 2932.50),
(10, 10, '2025-01-08', 70, 6230.00),
(1, 11, '2023-12-22', 95, 2849.05),
(2, 12, '2024-06-14', 110, 1705.00),
(3, 13, '2025-05-01', 130, 5198.70),
(4, 14, '2023-10-10', 60, 2994.00),
(5, 15, '2024-04-20', 140, 1680.00),
(6, 1, '2024-11-01', 155, 3873.45),
(7, 2, '2025-06-01', 100, 5999.00),
(8, 3, '2023-08-05', 200, 3750.00),
(9, 4, '2023-07-17', 180, 6210.00),
(10, 5, '2024-02-14', 95, 8455.00);

#1)	Verificare che i campi definiti come PK siano univoci. In altre parole,
# scrivi una query per determinare l’univocità dei valori di ciascuna PK (una query per tabella implementata).


#UNA PRIMARY KEY NON DEVE AVERE CAMPI NULLI/VUOTI NE AVERE CAMPI DUPLICATI

#VERIFICA CAMPI VUOTI NELLE PK
SELECT * FROM Product WHERE ProductID IS NULL;
SELECT * FROM Region WHERE RegionID IS NULL;
SELECT * FROM State WHERE StateID IS NULL;
SELECT * FROM Sales WHERE SalesID IS NULL;

#VERIFICA CAMPI DUPLICATI

SELECT ProductID, COUNT(*) as VerificaDuplicati
FROM Product
GROUP BY ProductID
HAVING COUNT(*) > 1;

SELECT RegionID, COUNT(*) as VerificaDuplicati
FROM Region
GROUP BY RegionID
HAVING COUNT(*) > 1;

SELECT StateID, COUNT(*) as VerificaDuplicati
FROM State
GROUP BY StateID
HAVING COUNT(*) > 1;

SELECT StateID, COUNT(*) as VerificaDuplicati
FROM State
GROUP BY StateID
HAVING COUNT(*) > 1;

SELECT SalesID, COUNT(*) as VerificaDuplicati
FROM Sales
GROUP BY SalesID
HAVING COUNT(*) > 1;


#2)	Esporre l’elenco delle transazioni indicando nel result set il codice documento, la data, il nome del prodotto, la categoria del prodotto, il nome dello stato, 
# il nome della regione di vendita e un campo booleano valorizzato in base alla condizione che siano passati più di 180 giorni 
#dalla data vendita o meno# (>180 -> True, <= 180 -> False)


Select V.SalesID, V.SaleDate, P.ProductName, P.CategoryName, S.StateName, R.RegionName, if (datediff('2025-06-14', V.SaleDate) >180, 'VERO','FALSO') AS 180DaysAfterSales 
from Sales V
join Product P ON V.ProductID = P.ProductID
Join State S on V.StateID = S.StateID
join Region R on S.RegionID = R.RegionID;


#3)	Esporre l’elenco dei prodotti che hanno venduto, in totale, una quantità maggiore della media delle vendite realizzate nell’ultimo anno censito.
# (ogni valore della condizione deve risultare da una query e non deve essere inserito a mano).
# Nel result set devono comparire solo il codice prodotto e il totale venduto.

#ricerca ultimo anno censito
Select max(year(SaleDate)) as UltimoAnnoCensito
From sales;

#Vado a ricavere media vendite dell'ultimo anno censito

Select avg(Quantity) As MediaVendite
FROM Sales
where year(SaleDate) = 
(Select max(year(SaleDate)) as UltimoAnnoCensito
From sales
);

#RESULT SET

Select ProductID, sum(Quantity) as TotaleVenduto
From sales
group by ProductID
having TotaleVenduto > (Select avg(Quantity) As MediaVendite
FROM Sales
where year(SaleDate) = 
(Select max(year(SaleDate)) as UltimoAnnoCensito
From sales
));

#4)	Esporre l’elenco dei soli prodotti venduti e per ognuno di questi il fatturato totale per anno. 

Select P.ProductID, P.ProductName, sum(V.TotalAmount) as FatturatoTotale, year(V.SaleDate) as Anno
from Product P 
join Sales V on P.ProductID = V.ProductID
group by P.ProductID, year(V.SaleDate)
Order by Anno asc;

#5)	Esporre il fatturato totale per stato per anno. Ordina il risultato per data e per fatturato decrescente.

Select S.StateName, year(V.SaleDate) As Anno, sum(V.TotalAmount) as FatturatoTotale
from Sales V
join State S on V.StateID = S.StateID
group by S.StateName,  year(V.SaleDate)
Order By Anno desc, FatturatoTotale desc;


#6)	Rispondere alla seguente domanda: qual è la categoria di articoli maggiormente richiesta dal mercato?

#Vado a fare una join tra Prdoduct e Sales mostrato la quantità totale venduta per categoria ordinata in modo decrescente con Limit 1, mostrando quindi quella maggiormente richiesta.
SELECT P.CategoryName, SUM(V.Quantity) AS TotaleQuantitaVenduta
FROM Sales V
JOIN Product p ON V.ProductID = p.ProductID
GROUP BY P.CategoryName
ORDER BY TotaleQuantitaVenduta DESC
LIMIT 1;

#7)	Rispondere alla seguente domanda: quali sono i prodotti invenduti? Proponi due approcci risolutivi differenti.

#in questo primo caso vado a fare una join tra product e sales mostrando in output i soli risultati nulli tramite la condizione where.

SELECT p.ProductID, p.ProductName
FROM Product p
LEFT JOIN Sales V ON p.ProductID = V.ProductID
WHERE V.ProductID IS NULL;

#nel secondo caso, vado a mostrare come result set tutti i prodotti non contenuti in sales tramite la subquery select distint

SELECT DISTINCT ProductID
FROM PRODUCT;

SELECT ProductID, ProductName
FROM Product
WHERE ProductID NOT IN (
SELECT DISTINCT ProductID
FROM Sales
);


#8)	Creare una vista sui prodotti in modo tale da esporre una “versione denormalizzata”
# delle informazioni utili (codice prodotto, nome prodotto, nome categoria) 

Create View Prodotti AS 
select ProductID, ProductName, CategoryName 
from product;

Select * From prodotti;

#9)	Creare una vista per le informazioni geografiche 
create view InfoGeografiche as
select S.StateID, S.StateName, R.RegionID, R.RegionName
From State S 
join Region R on S.RegionID = R.RegionID;


Select*From InfoGeografiche;

