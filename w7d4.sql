#Implementa una vista denominata Product al fine di creare unʼanagrafica (dimensione) prodotto completa. La vista, se interrogata o utilizzata come sorgente dati,
# deve esporre il nome prodotto, il nome della sottocategoria associata e il nome della categoria associata.
Select P.ProductKey, P.EnglishProductName, P.StandardCost,P.ListPrice, 
C.ProductCategoryKey, C.EnglishProductCategoryName, 
S.ProductSubcategoryKey, S.EnglishProductSubcategoryName
From dimproduct P
join dimproductsubcategory S on S.ProductSubcategoryKey = P.ProductSubcategoryKey
join dimproductcategory C on C.ProductCategoryKey = S.ProductCategoryKey
;

create view Product as (Select P.ProductKey, P.EnglishProductName, P.StandardCost,P.ListPrice, 
C.ProductCategoryKey, C.EnglishProductCategoryName, 
S.ProductSubcategoryKey, S.EnglishProductSubcategoryName
From dimproduct P
join dimproductsubcategory S on S.ProductSubcategoryKey = P.ProductSubcategoryKey
join dimproductcategory C on C.ProductCategoryKey = S.ProductCategoryKey
;


#Implementa una vista denominata Reseller al fine di creare unʼanagrafica (dimensione) reseller completa. La vista, se interrogata o utilizzata come sorgente dati,
# deve esporre il nome del reseller, il nome della città e il nome della regione

SELECT R.ResellerKey,
       R.ResellerName,
       G.GeographyKey,
       G.City,
       G.StateProvinceName AS Region
FROM DimReseller R
LEFT JOIN DimGeography G ON R.GeographyKey = G.GeographyKey;

create view reseller as (SELECT R.ResellerKey,
       R.ResellerName,
       G.GeographyKey,
       G.City,
       G.StateProvinceName AS Region
FROM DimReseller R
LEFT JOIN DimGeography G ON R.GeographyKey = G.GeographyKey
);

select*from reseller;








#Crea una vista denominata Sales che deve restituire la data dellʼordine, 
#il codice documento, la riga di corpo del documento, la quantità venduta, lʼimporto totale e il profitto.



SELECT 
 p.ProductKey,
 p.EnglishProductName,
 r.ResellerKey,
 v.OrderDate,
 v.SalesOrderNumber,
 v.SalesOrderLineNumber, 
 v.OrderQuantity, 
 v.SalesAmount, 
 v.TotalProductCost,
 (v.SalesAmount - v.TotalProductCost) AS Profitto
 FROM
 factresellersales v
 JOIN dimproduct p ON v.ProductKey = p.ProductKey
  JOIN dimreseller r ON  r.ResellerKey = v.ResellerKey
 ;
 
 
 
 Create View Sales as
 (SELECT 
 p.ProductKey,
 p.EnglishProductName,
 r.ResellerKey,
 v.OrderDate,
 v.SalesOrderNumber,
 v.SalesOrderLineNumber, 
 v.OrderQuantity, 
 v.SalesAmount, 
 v.TotalProductCost,
 (v.SalesAmount - v.TotalProductCost) AS Profitto
 FROM
 factresellersales v
 JOIN dimproduct p ON v.ProductKey = p.ProductKey
 JOIN dimreseller r ON  r.ResellerKey = v.ResellerKey
 );
 
select*from sales;
