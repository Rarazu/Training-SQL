-- Day 2 ->  21 Nov 2023
use Northwind;

-- CASE
select
	case when 1=5 then
		'1 equals 5'
	else
		'1 dosnt equals 5 '
	end as resullt

-- DATE FORMAT
select 
	DATEPART(YEAR,Birthdate), -- datepart = mengambil tahun/bulan/hari saja, if bulan ->  MONTH, hari -> DAY
	YEAR(BirthDate), -- atau bisa lgsg dpt ini, berlaku untuk MONTH & DAY
	DATEPART(MONTH,Birthdate),
	DATEPART(DAY,Birthdate),
	DATENAME(WEEKDAY,Birthdate), -- datename = nama hari / bulan
	DATENAME(MONTH,Birthdate),
	DATEADD(DAY,1,Birthdate), -- tambah 1 hari/bulan/tahun
	Format(DATEADD(DAY,1,BirthDate), 'dd-MM-yyyy'),
	Format(GETDATE(), 'd','en-US'), -- eng format (/)
	Format(GETDATE(), 'D','en-US'), -- eng format (word)
	Format(GETDATE(), 'D','id-ID') -- id format (kata)
from Employees

select isdate('hello') -- is = memastikan
select ISNUMERIC(90)

-- penggunaan CASE dan ISDATE
select
	 case when ISDATE(HireDate) = 1 then
		'HireDate is available'
	else 
		'Doesnt Exist'
	end as ShipTime
from Employees

select DATEDIFF(YEAR,GETDATE(), '01/01/2000') -- DATEDIFF = selisih tahun / bulan / hari

--- JOIN ---
-- join = inner join
-- disarankan Inner Join karena lebih eksplisit
select * from [Order Details]

-- inner join = irisan
select * from Orders o inner join [Order Details] od
on o.OrderID = od.OrderID
order by o.OrderID

-- left join = yg sebelah kiri 
select 
	p.ProductName,
	FORMAT(od.UnitPrice, 'C','id-ID') as UnitPrice,
	od.Quantity,
	od.Discount
from Products p 
	left join [Order Details] od on od.ProductID = p.ProductID
	left join Orders o on o.OrderID = od.OrderID

select
	o.OrderID,
	format(o.ShippedDate,'d','id-ID') as ShipepedDate,
	o.ShipAddress,
	p.ProductName,
	format(od.UnitPrice,'C','id-ID') as UnitPrice,
	od.Quantity,
	od.Discount
from Products p 
	right join [Order Details] od on p.ProductID = od.ProductID
	right join Orders o on od.OrderID = o.OrderID

-- full outer join = semua kepanggil / tampil semua, yang tidak masuk irisan juga akan kepanggil
select
	o.OrderID,
	format(o.ShippedDate,'d','id-ID') as ShipepedDate,
	o.ShipAddress,
	p.ProductName,
	format(od.UnitPrice,'C','id-ID') as UnitPrice,
	od.Quantity,
	od.Discount
from Products p 
	full outer join [Order Details] od on p.ProductID = od.ProductID
	full outer join Orders o on od.OrderID = o.OrderID

-- self join
select 
	pc.CompanyName as ParentCompany,c.*
from Customers c left join Customers pc
	on c.ParentCompanyID = pc.CustomerID
	order by pc.CompanyName desc

	select * from Employees


-- tugas : 1. concat fullname lastname 
	-- 2. case si no manager
select 
	e.EmployeeID, 
	CONCAT(e.LastName,', ',e.FirstName) as [Employee],
	CASE when e.ReportsTo IS NOT NULL
		then CONCAT(rt.LastName,', ',rt.FirstName)
		else  'No Manager Assigned'
	end as Manager
from Employees e left join Employees rt
on e.ReportsTo = rt.EmployeeID
