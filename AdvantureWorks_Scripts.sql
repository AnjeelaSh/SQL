--Show the first name and the email address of customer with CompanyName 'Bike World'
SELECT FirstName, EmailAddress
FROM Customer
WHERE CompanyName = 'Bike World'

--Show the CompanyName for all customers with an address in City 'Dallas'.
SELECT c.CompanyName
FROM Customer AS c
	JOIN CustomerAddress AS ca
		ON c.customerId = ca.customerID
	JOIN Address AS a
		ON a.city = 'Dallas'
		AND ca.addressID = a.addressId

--How many items with ListPrice more than $1000 have been sold?
SELECT Count(*) AS ProductCount
FROM Product
WHERE ListPrice > 1000

--Give the CompanyName of those customers with orders over $100000. Include the subtotal plus tax plus freight.
SELECT c.CompanyName
FROM Customer AS c
	JOIN SalesOrderHeader AS s
		ON c.CustomerId = s.CustomerId
WHERE (s.Subtotal + s.Taxamt + s.Freight) > 100000

--Find the number of left racing socks ('Racing Socks, L') ordered by CompanyName 'Riding Cycles'
SELECT c.CompanyName, p.Name, sod.OrderQty
FROM Product AS p
	JOIN SalesOrderDetail AS sod
		ON p.ProductID = SOD.ProductID
	JOIN SalesOrderHeader AS s
		ON sod.SalesOrderID = s.SalesOrderID
	JOIN Customer AS c
		ON s.CustomerID = c.CustomerID
WHERE p.Name = 'Racing Socks, L'
	AND c.CompanyName = 'Riding Cycles'

-- A "Single Item Order" is a customer order where only one item is ordered. Show the SalesOrderID and the UnitPrice for every Single Item Order.
SELECT SalesOrderID, UnitPrice, OrderQty
FROM SalesOrderDetail
WHERE OrderQty = 1

-- Where did the racing socks go? List the product name and the CompanyName for all Customers who ordered ProductModel 'Racing Socks'.
SELECT p.name, c.CompanyName
FROM ProductModel AS pm
	JOIN Product AS p
		ON pm.ProductModelID = p.ProductModelID
	JOIN SalesOrderDetail AS sod
		ON p.productID = sod.productID

--Show the product description for culture 'fr' for product with ProductID 736.
SELECT ProductID, Description, Culture
FROM Product AS p
	JOIN ProductModel AS pm
		ON p.ProductModelID = pm.ProductModelID
	JOIN ProductModelProductDescription AS pmpd
		ON pm.ProductModelID = pmpd.ProductModelID
	JOIN ProductDescription AS pd
		ON pmpd.ProductDescriptionID = pd.ProductDescriptionID
WHERE p.ProductID = 736
	AND pmpd.culture = 'fr'

--Use the SubTotal value in SaleOrderHeader to list orders from the largest to the smallest. For each order show the CompanyName and the SubTotal and the total weight of the order.
SELECT SalesOrderID, CompanyName, SubTotal, Freight
FROM SalesOrderHeader AS soh
	JOIN Customer AS c
		ON soh.CustomerID = c.CustomerID
ORDER BY SubTotal DESC

--How many products in ProductCategory 'Cranksets' have been sold to an address in 'London'?
SELECT pc.Name AS ProductCategoryName, a.city, count(*) AS CountOfPrdSale
FROM ProductCategory AS pc
	JOIN Product AS p
		ON pc.ProductCategoryID = p.ProductCategoryID
	JOIN SalesOrderDetail AS sod
		ON p.ProductID = sod.ProductID
	JOIN SalesOrderHeader AS soh
		ON sod.SalesOrderID = soh.SalesOrderID
	JOIN Address AS a
		ON soh.BillToAddressID = a.AddressID
WHERE pc.Name = 'Cranksets'
	AND a.City = 'London'
GROUP BY pc.Name, a.city

--For every customer with a 'Main Office' in Dallas show AddressLine1 of the 'Main Office' and AddressLine1 of the 'Shipping' address - if there is no shipping address leave it blank. Use one row per customer.
SELECT c.FirstName + ' ' + c.LastName AS CustomerInfo, ab.city AS City, ab.AddressLine1 AS MainOfficeAddress, ash.Addressline1 AS ShippingAddress
FROM Customer AS c
	JOIN CustomerAddress AS ca
		ON c.CustomerID = ca.CustomerID
		AND ca.AddressType = 'Main Office'
	JOIN Address AS ab
		ON ca.AddressID = ab.AddressID
	LEFT JOIN CustomerAddress AS cas
		ON c.CustomerID = cas.CustomerID
		AND cas.AddressType = 'Shipping'
	LEFT JOIN Address AS ash
		ON cas.AddressID = ash.AddressID
WHERE ab.city = 'Dallas'

