#voglio vedere gli attributi sia di dimproduct sia di dimproductsubcategory e capire il campo è in comune
select * from dimproduct;
select * from dimproductsubcategory;

#per mostrare le sottocategorie vado a fare una inner join tra dimproduct e dimproductsubcategory
select P.ProductKey, P.ProductAlternateKey, P.EnglishProductName, P.StandardCost, P.FinishedGoodsFlag, P.ListPrice,
S.ProductSubcategoryKey, S.EnglishProductSubcategoryName
from dimproduct P
join dimproductsubcategory S on P.productsubcategorykey = S.productsubcategorykey; 

#mostro prima dimproductcategory per studiare l'entità
select * from dimproductcategory;

#mostro categorie e sottocategorie facendo una inner join tra dimproduct e dimproductsubcategory ed un'altra inner join tra dimproduct e dimproductcategory
select P.ProductKey, P.ProductAlternateKey, P.EnglishProductName, P.StandardCost, P.FinishedGoodsFlag, P.ListPrice,
S.ProductSubcategoryKey, S.EnglishProductSubcategoryName, C.ProductCategoryKey, C. EnglishproductCategoryName
From dimproduct P
Join dimproductsubcategory S on P.productsubcategorykey = S.productsubcategorykey
join dimproductcategory C on S.ProductCategorykey = C.productcategorykey;

#al fine di mostrare solo i prodotti venduti, mostro prima l'entità FactResellerSales

select * from factresellersales;

#per mostrare solo i prodotti venduti vado a fare una inner join tra dimproduct e factresellersales

select P.ProductKey, P.ProductAlternateKey, P.EnglishProductName, P.StandardCost, P.FinishedGoodsFlag, P.ListPrice, 
F.SalesOrderNumber,F.OrderDate, F.OrderQuantity, F.UnitPrice,F.TotalProductCost, F.SalesAmount
From dimproduct P
join factresellersales F on P.productkey = F.productkey;

#controllo le key distinte di factresellersales;
select distinct productkey from factresellersales; 

#uso il not in per mostrare solo i prodotti finiti e venduti
select distinct P.productkey, P.EnglishProductName, P.FinishedGoodsFlag FROM dimproduct P
where P.FinishedGoodsFlag = 1 and P.productkey not in (select distinct productkey from factresellersales
);

#faccio una join per mostrare le trasazioni di vendita indicando categoria di ciasciun prodotto venduto
select P.ProductKey, P.EnglishProductName, P.FinishedGoodsFlag, P.ListPrice, 
F.SalesOrderNumber, F.OrderDate, F.OrderQuantity, F.SalesOrderLineNumber, F.UnitPrice,F.TotalProductCost, F.SalesAmount
From dimproduct P
join factresellersales F on P.productkey = F.productkey
WHERE P.FinishedGoodsFlag = 1;



select P.ProductKey, P.EnglishProductName, P.FinishedGoodsFlag, P.ListPrice, 
F.SalesOrderNumber, F.OrderDate, F.OrderQuantity, F.SalesOrderLineNumber, F.UnitPrice,F.TotalProductCost, F.SalesAmount,
C.ProductCategoryKey, C.EnglishproductCategoryName
From dimproduct P
Join dimproductsubcategory S on P.productsubcategorykey = S.productsubcategorykey
join dimproductcategory C on S.ProductCategorykey = C.productcategorykey
join factresellersales F on P.productkey = F.productkey;


#esploro la tabella dimreseller

select*from dimreseller;

# esploro la tabella dimgeography
Select * from dimgeography;

#faccio una inner join per mostrare il reseller e la sua area geografica

Select R.ResellerKey, R.ResellerName, R.AddressLine1, R.ProductLine,
G.City, G.StateProvinceCode, G.EnglishCountryRegionName
from dimreseller R
join dimgeography G on R.Geographykey = G.Geographykey;

#Esponi lʼelenco delle transazioni di vendita. Il result set deve esporre i campi: SalesOrderNumber, SalesOrderLineNumber, OrderDate, UnitPrice, Quantity, TotalProductCost. 
#Il result set deve anche indicare il nome del prodotto, il nome della categoria del prodotto, il nome del reseller e lʼarea geografica.
select P.ProductKey, P.EnglishProductName, P.FinishedGoodsFlag,
S.EnglishProductSubcategoryName, 
C.EnglishProductCategoryName, 
V.SalesOrderNumber, V.OrderDate, V.OrderQuantity, V.UnitPrice, V.TotalProductCost, V.SalesAmount, 
R.ResellerName, R.BusinessType, R.ProductLine, R.AnnualSales, R.AnnualRevenue, R.YearOpened, 
G.City, G.StateProvinceName, G.EnglishCountryRegionName, G.PostalCode
from dimproduct P
join dimproductsubcategory S on P.productsubcategorykey = S.productsubcategorykey
join dimproductcategory C on S.ProductCategorykey = C.productcategorykey
join factresellersales V on P.ProductKey = V.ProductKey
join dimreseller R on V.ResellerKey = R.ResellerKey
join dimgeography G on R.GeographyKey = G.GeographyKey;





