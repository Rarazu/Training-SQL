-- DAY 1 => 20 Nov 2023


-- concat = penyambung karakter
use Northwind;
	select FirstName + ' ' + LastName as 'Full Name',
	TRIM(CONCAT(FirstName,' ',LastName)) as [Full Name 2], -- ini menggunakan fungsi
	CONCAT_WS(' ',FirstName,LastName) as [Full Name 3]
from Employees

-- tugas 
use Northwind;
select  
	TRIM(CONCAT(TitleOfCourtesy, ' ', FirstName,' ',LastName)) as [Full Name], 
	CONCAT(Address, ' , ', City,' -- ', UPPER(Country)),
	FORMAT(HireDate, 'dd-MM-yyyy') as [Hire Date]
from Employees
-- UPPER = Huruf Besar
-- LOWER = Huruf Kecil

--CAST (HireDate as date) AS [Hire Date]
-- trim = untuk menghilangkan spasi
select TRIM('   Hello SQL   ');
select RTRIM('   Hello SQL   '); -- trim kanan (right)
select LTRIM('   Hello SQL   '); -- trim kiri (left)

/**
cast() and convert() = merubah tipe data
perbedaan cast & convert
cast = ANSI Standart (lebih banyak db ug support)
convert = tdk support smua
cast() -> if tdk berhasil -> error -> message 
try_cast() -> if tdk berhasil -> error -> null
begitu pun convert dgn try_convert 
**/


select GETDATE()
-- perbedaan penulisan
select CAST(GETDATE() as varchar(50))
select CONVERT(varchar(50), GETDATE())
select '15' + 30

select TRY_CAST('hello' as int)

begin TRY
	select cast('hello' as int)
end TRY
begin catch
	Print 'Error Convert'
end catch

-- substring = ngambil
-- len = total
select SUBSTRING('HELLO',2,1)
select LEN('hello')
select SUBSTRING('hello',1,len('hello'))

-- replace =
select 
	FirstName, REPLACE(FirstName,'*.','_'),
	LastName, REPLACE(LastName,'_-','_')
from EmployeesUppercase

select DATENAME(weekday,GETDATE())
select ISDATE(GETDATE())

