----ilk örnek
SELECT p.ProductName, SUM(Quantity) AS miktar ,MIN(Quantity) as minmiktar,
MAX(Quantity) as maxmiktar, COUNT(o.OrderID)  as sipariþsayýsý
FROM Customers c
INNER JOIN Orders o
ON c.CustomerID=o.CustomerID
INNER JOIN  [Order Details] od
On o.OrderID=od.OrderID
INNER JOIN Products p
On od.ProductID=p.ProductID 
Group By  p.ProductName
HAVING COUNT(*)>1
Order By p.ProductName

