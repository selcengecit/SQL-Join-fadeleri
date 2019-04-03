


--1.soru Employee tablosundaki �al��anlar�n hangi y�neticiye ba�l� oldu�unu listele
SELECT a.FirstName+' '+a.LastName AS M�d�r, b.FirstName+' '+b.LastName AS RaporVeren, a.ReportsTo,a.Title, a.EmployeeID
FROM Employees a
INNER JOIN Employees b
ON b.ReportsTo=a.EmployeeID
Group by a.FirstName,a.LastName,a.ReportsTo, a.Title, b.FirstName,b.LastName,a.EmployeeID
ORDER BY RaporVeren

 --En pahal� �r�n� sat�n alan ilk �� m��terileri listeleyin.
 SELECT TOP 3 od.UnitPrice, p.ProductName, c.CompanyName, c.CustomerID FROM Products p
 INNER JOIN [Order Details] od
 ON p.ProductID=od.ProductID 
 INNER JOIN Orders o
 ON od.OrderID=o.OrderID
 INNER JOIN Customers c
 ON o.CustomerID=c.CustomerID
  ORDER BY UnitPrice DESC
 
 --1996 y�l�ndaki sipari�lerin sevkiyat �irketinin i�inde i ve p harfleri ge�enleri OrderID sine
 --g�re listele

 SELECT DISTINCT s.CompanyName, YEAR( o.OrderDate) FROM Orders o
 INNER JOIN Shippers s
 ON O.ShipVia=s.ShipperID
WHERE (o.OrderDate BETWEEN '1996-01-01' and '1996-12-31') and s.CompanyName LIKE '%[ip]%'

--Ayn� kategorilere sahip �r�nlerin say�s�, Toplam fiyat� ve fiyat ortalamas�n� al�p buyukten 
--kucuge listeleyin
SELECT COUNT(p.ProductID) AS �r�nSay�s�, SUM(p.UnitPrice) AS BirimFiyat, AVG(p.UnitPrice) AS FiyatOrtalama,
c.CategoryName
FROM  Products p
INNER JOIN Categories c
On c.CategoryID=p.CategoryID 
GROUP BY c.CategoryName
ORDER BY FiyatOrtalama DESC

--her kategorinin en �ok sat�� yapan �r�n�n� listele -- do�ru cozum de�il.
SELECT  MAX(od.Quantity*od.UnitPrice) as Sat�stutar�, c.CategoryName FROM Categories c 
INNER JOIN Products p
ON c.CategoryID=p.CategoryID
INNER JOIN [Order Details] od
ON od.ProductID=p.ProductID
GROUP BY c.CategoryName 
ORDER BY Sat�stutar�
SELECT*FROM Categories

--Eastren Region �na kay�tl� olan t�m employee listesini getir

SELECT DISTINCT e.EmployeeID,e.LastName,e.FirstName, r.RegionDescription FROM Employees e
INNER JOIN EmployeeTerritories et
ON e.EmployeeID=et.EmployeeID
INNER JOIN Territories t
ON et.TerritoryID=t.TerritoryID
INNER JOIN Region r
ON r.RegionID=t.RegionID
WHERE r.RegionDescription='Eastern'

 --�irket adlar�n� ve yapm�� olduklar� toplam �ipari� tutar�n� listele
 SELECT c.CompanyName, SUM(od.Quantity*od.UnitPrice) as ToplamSiparis FROM Customers c
 INNER JOIN Orders o
 ON c.CustomerID=o.CustomerID
 INNER JOIN [Order Details] od
 ON o.OrderID=od.OrderID
 INNER JOIN Products p
 ON od.ProductID=p.ProductID
GROUP BY c.CompanyName
ORDER BY ToplamSiparis DESC

 --Hangi �irket hangi �r�nden ka� adet ald�
  SELECT c.CompanyName, SUM(od.Quantity) as AdetSay�s�,p.ProductName FROM Customers c
 INNER JOIN Orders o
 ON c.CustomerID=o.CustomerID
 INNER JOIN [Order Details] od
 ON o.OrderID=od.OrderID
 INNER JOIN Products p
 ON od.ProductID=p.ProductID
 GROUP BY c.CompanyName,p.ProductName
--ORDER BY AdetSay�s�


--En �ok sat�� yapan 3 Employen�n primini 200 yap ve listele
SELECT TOP 3 e.EmployeeID, SUM(od.Quantity*od.UnitPrice) AS Miktar,200 as [Prim] FROM Employees e
INNER JOIN Orders o
ON e.EmployeeID=o.EmployeeID
INNER JOIN [Order Details] od
ON o.OrderID=od.OrderID
Group by e.EmployeeID
ORDER BY Miktar DESC 

SELECT*FROM Employees

--Hangi b�lgede hangi �r�n category'e g�re en �ok sat�lm��t�r?
-- (En �ok sat�� yapan category)
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

--Kimseye rapor vermeyen �al��anlar�n sat�� yapt��� m��terilerin �lkelerini ve 
--o �lkeye ka� adet sat�� yapt���n� listeleyiniz

SELECT e.FirstName, c.Country,e.ReportsTo, SUM(od.Quantity)AS ToplamSat�s FROM [Order Details] od
INNER JOIN Orders o
ON od.OrderID=o.OrderID
INNER JOIN Employees e
ON o.EmployeeID=e.EmployeeID
INNER JOIN Customers c
ON c.CustomerID=o.CustomerID
WHERE e.ReportsTo is NULL
GROUP BY c.Country,e.ReportsTo,e.FirstName

--Products tablosunda �UnitPrice� lar� ortalaman�n �zerinde olan �r�n adlar� nelerdir
 --ve hangi �lkelere sat�lm��t�r?
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

 --Herhangi bir kategoride en �ok sat�� yapan
 -- 5 firmay� uygun g�rd���n�z alanlara g�re listeleyiniz

 SELECT TOP 5 C.CompanyName,SUM(od.Quantity) as ToplamSat�s FROM Products p
 INNER JOIN [Order Details] od
 ON p.ProductID=od.ProductID
 INNER JOIN Orders o
 ON od.OrderID=o.OrderID
 INNER JOIN Customers C
 ON o.CustomerID=C.CustomerID
GROUP BY c.CompanyName
ORDER BY SUM(od.Quantity) DESC

--�OrderDate� ve �RequiredDate� aras� 30 g�nden 
--fazla olanlar�n kategorisi ve miktar bilgilerini listeleyiniz
SELECt c.CategoryName,COUNT(*) AS Amount FROM Orders o
JOIN [Order Details] od
ON od.OrderID=o.OrderID
JOIN Products p 
ON p.ProductID=od.ProductID
JOIN Categories c
ON p.CategoryID=c.CategoryID
WHERE DATEDIFF(DAY,OrderDate,RequiredDate)>30
GROUP BY c.CategoryName