


--1.soru Employee tablosundaki çalýþanlarýn hangi yöneticiye baðlý olduðunu listele
SELECT a.FirstName+' '+a.LastName AS Müdür, b.FirstName+' '+b.LastName AS RaporVeren, a.ReportsTo,a.Title, a.EmployeeID
FROM Employees a
INNER JOIN Employees b
ON b.ReportsTo=a.EmployeeID
Group by a.FirstName,a.LastName,a.ReportsTo, a.Title, b.FirstName,b.LastName,a.EmployeeID
ORDER BY RaporVeren

 --En pahalý ürünü satýn alan ilk üç müþterileri listeleyin.
 SELECT TOP 3 od.UnitPrice, p.ProductName, c.CompanyName, c.CustomerID FROM Products p
 INNER JOIN [Order Details] od
 ON p.ProductID=od.ProductID 
 INNER JOIN Orders o
 ON od.OrderID=o.OrderID
 INNER JOIN Customers c
 ON o.CustomerID=c.CustomerID
  ORDER BY UnitPrice DESC
 
 --1996 yýlýndaki sipariþlerin sevkiyat þirketinin içinde i ve p harfleri geçenleri OrderID sine
 --göre listele

 SELECT DISTINCT s.CompanyName, YEAR( o.OrderDate) FROM Orders o
 INNER JOIN Shippers s
 ON O.ShipVia=s.ShipperID
WHERE (o.OrderDate BETWEEN '1996-01-01' and '1996-12-31') and s.CompanyName LIKE '%[ip]%'

--Ayný kategorilere sahip ürünlerin sayýsý, Toplam fiyatý ve fiyat ortalamasýný alýp buyukten 
--kucuge listeleyin
SELECT COUNT(p.ProductID) AS ÜrünSayýsý, SUM(p.UnitPrice) AS BirimFiyat, AVG(p.UnitPrice) AS FiyatOrtalama,
c.CategoryName
FROM  Products p
INNER JOIN Categories c
On c.CategoryID=p.CategoryID 
GROUP BY c.CategoryName
ORDER BY FiyatOrtalama DESC

--her kategorinin en çok satýþ yapan ürününü listele -- doðru cozum deðil.
SELECT  MAX(od.Quantity*od.UnitPrice) as Satýstutarý, c.CategoryName FROM Categories c 
INNER JOIN Products p
ON c.CategoryID=p.CategoryID
INNER JOIN [Order Details] od
ON od.ProductID=p.ProductID
GROUP BY c.CategoryName 
ORDER BY Satýstutarý
SELECT*FROM Categories

--Eastren Region ýna kayýtlý olan tüm employee listesini getir

SELECT DISTINCT e.EmployeeID,e.LastName,e.FirstName, r.RegionDescription FROM Employees e
INNER JOIN EmployeeTerritories et
ON e.EmployeeID=et.EmployeeID
INNER JOIN Territories t
ON et.TerritoryID=t.TerritoryID
INNER JOIN Region r
ON r.RegionID=t.RegionID
WHERE r.RegionDescription='Eastern'

 --Þirket adlarýný ve yapmýþ olduklarý toplam þipariþ tutarýný listele
 SELECT c.CompanyName, SUM(od.Quantity*od.UnitPrice) as ToplamSiparis FROM Customers c
 INNER JOIN Orders o
 ON c.CustomerID=o.CustomerID
 INNER JOIN [Order Details] od
 ON o.OrderID=od.OrderID
 INNER JOIN Products p
 ON od.ProductID=p.ProductID
GROUP BY c.CompanyName
ORDER BY ToplamSiparis DESC

 --Hangi þirket hangi üründen kaç adet aldý
  SELECT c.CompanyName, SUM(od.Quantity) as AdetSayýsý,p.ProductName FROM Customers c
 INNER JOIN Orders o
 ON c.CustomerID=o.CustomerID
 INNER JOIN [Order Details] od
 ON o.OrderID=od.OrderID
 INNER JOIN Products p
 ON od.ProductID=p.ProductID
 GROUP BY c.CompanyName,p.ProductName
--ORDER BY AdetSayýsý


--En çok satýþ yapan 3 Employenýn primini 200 yap ve listele
SELECT TOP 3 e.EmployeeID, SUM(od.Quantity*od.UnitPrice) AS Miktar,200 as [Prim] FROM Employees e
INNER JOIN Orders o
ON e.EmployeeID=o.EmployeeID
INNER JOIN [Order Details] od
ON o.OrderID=od.OrderID
Group by e.EmployeeID
ORDER BY Miktar DESC 

SELECT*FROM Employees

--Hangi bölgede hangi ürün category'e göre en çok satýlmýþtýr?
-- (En çok satýþ yapan category)
SELECT DISTINCT c.Region, p.ProductName, ct.CategoryName FROM Customers c
INNER JOIN Orders o
ON c.CustomerID=o.CustomerID
INNER JOIN [Order Details] od
ON o.OrderID=od.OrderID
INNER JOIN  Products p
ON od.ProductID=p.ProductID
INNER JOIN Categories ct
ON ct.CategoryID=p.CategoryID
GROUP BY p.ProductName, ct.CategoryName,c.Region

--Kimseye rapor vermeyen çalýþanlarýn satýþ yaptýðý müþterilerin ülkelerini ve 
--o ülkeye kaç adet satýþ yaptýðýný listeleyiniz

SELECT e.FirstName, c.Country,e.ReportsTo, SUM(od.Quantity)AS ToplamSatýs FROM [Order Details] od
INNER JOIN Orders o
ON od.OrderID=o.OrderID
INNER JOIN Employees e
ON o.EmployeeID=e.EmployeeID
INNER JOIN Customers c
ON c.CustomerID=o.CustomerID
WHERE e.ReportsTo is NULL
GROUP BY c.Country,e.ReportsTo,e.FirstName

--Products tablosunda “UnitPrice” larý ortalamanýn üzerinde olan ürün adlarý nelerdir
 --ve hangi ülkelere satýlmýþtýr?
 SELECT  p.ProductName,c.Country, od.UnitPrice FROM Customers c
 INNER JOIN Orders o
 ON c.CustomerID=o.CustomerID
 INNER JOIN [Order Details] od
 ON o.OrderID=od.OrderID
 INNER JOIN Products p
 ON od.ProductID=p.ProductID
 WHERE p.UnitPrice > (SELECT AVG(UnitPrice) from Products)
 GROUP BY p.ProductName,c.Country, od.UnitPrice
 ORDER BY od.UnitPrice

 SELECT AVG(UnitPrice) From [Order Details]

 --Herhangi bir kategoride en çok satýþ yapan
 -- 5 firmayý uygun gördüðünüz alanlara göre listeleyiniz

 SELECT TOP 5 C.CompanyName,SUM(od.Quantity) as ToplamSatýs FROM Products p
 INNER JOIN [Order Details] od
 ON p.ProductID=od.ProductID
 INNER JOIN Orders o
 ON od.OrderID=o.OrderID
 INNER JOIN Customers C
 ON o.CustomerID=C.CustomerID
GROUP BY c.CompanyName
ORDER BY SUM(od.Quantity) DESC

--“OrderDate” ve “RequiredDate” arasý 30 günden 
--fazla olanlarýn kategorisi ve miktar bilgilerini listeleyiniz
SELECt c.CategoryName,COUNT(*) AS Amount FROM Orders o
JOIN [Order Details] od
ON od.OrderID=o.OrderID
JOIN Products p 
ON p.ProductID=od.ProductID
JOIN Categories c
ON p.CategoryID=c.CategoryID
WHERE DATEDIFF(DAY,OrderDate,RequiredDate)>30
GROUP BY c.CategoryName