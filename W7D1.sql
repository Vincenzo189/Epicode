# PUNTO 1. Scrivi una query per verificare che il campo ProductKey nella tabella DimProduct sia una chiave primaria. 
#Quali considerazioni/ragionamenti è necessario che tu faccia?

#Una chiave primaria deve essere univoca e non nulla. Quindi procedo al conteggio dei campi nulli e dei campi vuoti al fine di individuarli.

describe dimproduct;

#INDIVIDUARE CAMPI NULLI
Select count(*)
From dimproduct
where ProductKey is null;

#INDIVIDUARE CAMPI DUPLICATI
SELECT distinct ProductKey, COUNT(ProductKey) as NoProductKey
FROM dimproduct 
GROUP BY ProductKey
having COUNT(ProductKey) > 1;

#Scrivi una query per verificare che la combinazione dei campi SalesOrderNumber e SalesOrderLineNumber sia una PK.

#rifacendo lo stesso ragionamento precendete vado a capire se i due attributi sono univoci e nulli

#così vedo i campi nulli
select count(*)
from factresellersales
where SalesOrderNumber is null or SalesOrderLineNumber is null;

#così vedo i campi duplicati

select distinct SalesOrderNumber, SalesOrderLineNumber, 
count(SalesOrderNumber AND SalesOrderLineNumber) as N_rdine
From factresellersales
group by SalesOrderNumber,SalesOrderLineNumber
having count(SalesOrderNumber AND SalesOrderLineNumber) >1 ;
#la combinazione di entrambe le rende una chiave primaria

#punto 3 Conta il numero transazioni (SalesOrderLineNumber) realizzate ogni giorno a partire dal 1 Gennaio 2020.
#in questo caso vado appunto a contare le transazioni raggrupppandole per data

Select count(SalesOrderLineNumber)as N_Transazioni, orderdate
from factresellersales
group by OrderDate
having orderdate >= "2020-01-01"
order by orderdate asc;

#PUNTO4
#Calcola il fatturato totale (FactResellerSales.SalesAmount), la quantità totale venduta (FactResellerSales.OrderQuantity) 
#e il prezzo medio di vendita (FactResellerSales.UnitPrice) per prodotto (DimProduct) a partire dal 1 Gennaio 2020. 
#Il result set deve esporre pertanto il nome del prodotto, il fatturato totale, la quantità totale venduta e il prezzo medio di vendita.
# I campi in output devono essere parlanti!

#devo fare una join tra factresellersales e dimproduct per espporre il result set

select 
P.Productkey, P.EnglishProductName,
sum(S.SalesAmount) as Fatturato_Totale, sum(S.OrderQuantity) as Qty_Totale_Venduta, ROUND (avg (S.UnitPrice),2) as AVG_Unite_Price, S.OrderDate
From factresellersales S
join dimproduct P on P.ProductKey = S.ProductKey
group by S.OrderDate
having S.orderdate >= "2020-01-01"
order by OrderDate Asc;

#PUNTO 5
#Calcola il fatturato totale (SalesAmount) e la quantità totale venduta (OrderQuantity) per Categoria prodotto(DimProductCategory). 
select C.EnglishProductCategoryName as Categoria_Prodotto, sum(S.SalesAmount) as Fatturato_Totale, sum(S.OrderQuantity) as Totale_Vendite
From dimproduct P 
join  dimproductsubcategory X on P.ProductSubcategoryKey = X.ProductSubcategoryKey
join dimproductcategory C on X.ProductCategoryKey = C.ProductCategoryKey
join factresellersales S on P.ProductKey = S.ProductKey
group by  C.EnglishProductCategoryName
order by Fatturato_Totale Desc;

#punto 5
#Calcola il fatturato totale per area città DimGeography.City) realizzato a partire dal 1 Gennaio 2020.
# Il result set deve esporre lʼelenco delle città con fatturato realizzato superiore a 60K.

Select G.City, S.Orderdate, sum(S.salesamount) as Fatturato_Totale
From dimgeography G 
join factresellersales S on G.SalesTerritoryKey = S.SalesTerritoryKey
where S.OrderDate >= '2020-01-01'
group by G.City
having Fatturato_Totale > 60000
order by Fatturato_Totale Desc;





