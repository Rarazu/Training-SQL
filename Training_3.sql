-- DAY 3 -> 22 Nov 2023
Use Northwind;
/** 
'D%' -> awalan d
'%D' -> akhiran d
**/

-- kalau mau null nya masuk kedalam operation (hasil run)
-- harus di off kan (set ansi_nulls off) -> kalo on ya ilang
set ansi_nulls off
select * from Orders where RequiredDate = null

-- NESTED SELECT query
select 
	CompanyName,
	OrderID,
	CONVERT(varchar,OrderDate,101) as OrderDate
from Customers c left join Orders o 
on c.CustomerID = o.CustomerID
where 
	c.CustomerID not in (select CustomerID from Orders) -- ini nested query (PROSES BERSARANG)
order by o.OrderID

-- buat nyari data sesuai yg ingin dicari
declare @searchval as varchar(max) -- deklarasikan nama dan tipe
set @searchval = '10268'  -- set isi variabel
select OrderID,CompanyName,CONVERT(varchar,OrderDate,105) as OrderDate
from Customers c left join Orders o
	 on o.CustomerID = c.CustomerID
where OrderID = @searchval

declare @cari as varchar(max)
set @cari = '%oms%'
select OrderID,CompanyName,CONVERT(varchar,OrderDate,105) as OrderDate
from Customers c left join Orders o
	 on o.CustomerID = c.CustomerID
where CompanyName like @cari

-- if = kondisi
DECLARE @num1 as INT, @num2 as INT, @numRows as INT
set @num1 = 15
set @num2 = 3

if ISNUMERIC(@num1)=1 and ISNUMERIC(@num2)=1 and @num2>0
	begin
		GOTO CaclValue
	end
else
	begin
		GOTO PrintMessage
	end

CaclValue:
	print CONCAT(@num1/@num2,char(13))
	GOTO ContinueProcessing
PrintMessage:
	print '@num2 = 0'

ContinueProcessing:
	print 'Begin here'

-- while = perulangan
declare @firstnum as INT
set @firstnum = 0

while @firstnum<10
	begin
		set @firstnum = @firstnum+1
		print concat('Number: ',@firstnum)
	end
print 'finished'

-- offset & fetch
select 
	CompanyName,
	OrderID,
	CONVERT(varchar,OrderDate,101) as OrderDate
from Customers c left join Orders o 
on c.CustomerID = o.CustomerID
order by o.OrderID
offset 10 rows 
fetch next 10 row only

-- TUGAS GABUNGAN DECLARE AND FETCH

-- TOP -> manampilkan data paling atas berapapun yg kita mau
-- select TOP(angka) field 1,field2,field
SELECT TOP(30) 
		CompanyName,
		COUNT(od.OrderId) AS NumberOfOrders
	FROM CUSTOMERS c
	JOIN Orders o ON c.CustomerID = o.CustomerID
	JOIN [Order Details] od ON o.OrderID = od.OrderID
	GROUP BY CompanyName
	ORDER BY NumberOfOrders DESC

-- analisis data / sistem agregat
/**
jumlah -> COUNT
total -> SUM
rata-rata -> AVG
terbesar -> MAX
terkecil -> MIN

filter stelah group by -> HAVING
**/

DECLARE @timesOrdered AS INT
SET @timesOrdered = 50

SELECT 
	p.ProductName,
	COUNT(od.ProductID)
FROM Products p
LEFT JOIN [Order Details] od ON p.ProductID = od.ProductID
group by p.ProductName
having count(od.ProductID) > @timesOrdered
order by count(od.ProductID) desc

SELECT 
	p.ProductName,
	COUNT(od.ProductID) AS TimesOrdered,
	CASE WHEN SUM(od.Quantity) IS NULL THEN
		0
	ELSE
	SUM(od.Quantity) END AS TotalOrdered
FROM Products p
LEFT JOIN [Order Details] od ON p.ProductID = od.ProductID
group by p.ProductName
having count(od.ProductID) > 50 and sum(od.Quantity) > 1000
order by count(od.ProductID) desc

SELECT 
	c.CompanyName,
	SUBSTRING(FORMAT(MAX(o.OrderDate),'MMM dd yyyy'),1,11) As LastOrderPlaced,
	SUBSTRING(FORMAT(MIN(o.OrderDate),'MMM dd yyyy'),1,11) AS FirstOrderPlace,
	FORMAT(AVG(od.Quantity * od.UnitPrice), 'c', 'en-us') AS AverageOrderAmount
FROM Customers c
LEFT JOIN Orders o ON o.CustomerID = c.CustomerID
LEFT JOIN [Order Details] od ON o.OrderID = od.OrderID
GROUP BY c.CompanyName
ORDER BY AVG(od.Quantity * od.UnitPrice) DESC

	

