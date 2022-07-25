libname project '~';
filename reffile '/home/u59396653/BAN 130/Project/AdventureWorks.xlsx';
* 1. Data Import;
* Import Product sheet;
proc import
	datafile=reffile
	dbms=xlsx
	out=project.Product;
	sheet='Product';
	getnames=yes;
run;
* Import SalesOrderDetail sheet;
proc import
	datafile=reffile
	dbms=xlsx
	out=project.SalesOrderDetail;
	sheet='SalesOrderDetail';
	getnames=yes;
run;
* Import SalesOrderHeader sheet;
proc import
	datafile=reffile
	dbms=xlsx
	out=project.SalesOrderHeader;
	sheet='SalesOrderHeader';
	getnames=yes;
run;
* Import SalesTerritory sheet;
proc import
	datafile=reffile
	dbms=xlsx
	out=project.SalesTerritory;
	sheet='SalesTerritory';
	getnames=yes;
run;
* 2. Data Cleaning;
* SalesOrderHeader_Clean;
data project.SalesOrderHeader_Clean;
	set 	project.SalesOrderHeader(keep=SalesOrderID TotalDue OnlineOrderFlag OrderDate TerritoryID);
			NumTotalDue=input(TotalDue,dollar16.2);
			NumOnlineOrderFlag=input(OnlineOrderFlag,8.);
			DateOrderDate=input(OrderDate,anydtdte10.);
			NumTerritoryID=input(TerritoryID,8.);
	format	NumTotalDue dollar16.2
			DateOrderDate mmddyy10.;
	drop	TotalDue
			OnlineOrderFlag
			OrderDate
			TerritoryID;
	rename	NumTotalDue=TotalDue
			NumOnlineOrderFlag=OnlineOrderFlag
			DateOrderDate=OrderDate
			NumTerritoryID=TerritoryID;
run;
* Territory_Clean;
data project.Territory_Clean;
	set 	project.SalesTerritory(keep=TerritoryID Name CountryRegionCode Group SalesYTD);
			NumSalesYTD=input(SalesYTD,dollar16.2);
			NumTerritoryID=input(TerritoryID,8.);
	format	NumSalesYTD dollar16.2
			NumTerritoryID 8.;
	drop	SalesYTD TerritoryID;
	rename	NumSalesYTD=SalesYTD NumTerritoryID=TerritoryID;
run;
* Joining & Merging;
proc sort
	data=project.SalesOrderHeader_Clean;
	by TerritoryID;
run;
proc sort
	data=project.territory_clean;
	by TerritoryID;
run;
data project.SalesDetails;
	merge	project.SalesOrderHeader_Clean(in=Q1)
			project.territory_clean(in=Q2);
	by		TerritoryID;
	if 		Q1 = 1 and Q2 =1;
run;
proc print data=project.SalesDetails(obs=10); run;
* Sales Analysis;
proc sort
	data=project.SalesDetails
	out=project.SortedSalesDetails;
	by TerritoryID;
run;
data project.SalesAnalysis(drop=TotalDue TerritoryID SalesOrderID OnlineOrderFlag OrderDate);
	retain	Name CountryRegionCode Group SalesYTD SubTotal;
	format	SubTotal dollar16.2;
	set		project.SortedSalesDetails;
	by		TerritoryID;
	if		First.TerritoryID then SubTotal=0;
			SubTotal + TotalDue;
	if		Last.TerritoryID;   
run;
proc print data=project.SalesAnalysis noobs; run;
* Part 4 Data Analysis:
* What is the Total Due for all the North American Regions?;
proc tabulate
	data=project.SalesAnalysis;
	class Group;
	var Subtotal;
	table Subtotal=' '*f=dollar16.2, Group='All Regions' / rts=25 row=float;
	keylabel sum='Total Due';
run;
proc tabulate
	data=project.SalesAnalysis;
	class Group;
	var Subtotal;
	table Subtotal=' '*f=dollar16.2, Group='Only North America Regions' / rts=25 row=float;
	keylabel sum='Total Due';
	where Group='North America';
run;
* What is the total Sales YTD for U.S.?;
proc tabulate
	data=project.SalesAnalysis;
	class CountryRegionCode;
	var SalesYTD;
	table SalesYTD=' '*f=dollar16.2, CountryRegionCode='By Country Region Code' / rts=25 row=float;
	keylabel sum='Sales YTD';
run;
proc tabulate
	data=project.SalesAnalysis;
	class CountryRegionCode;
	var SalesYTD;
	table SalesYTD=' '*f=dollar16.2, CountryRegionCode='By Country Region Code' / rts=25 row=float;
	keylabel sum='Sales YTD';
	where CountryRegionCode='US';
run;
* How much is due from France and Germany?;
proc tabulate
	data=project.SalesAnalysis;
	class Name;
	var Subtotal;
	table Subtotal=' '*f=dollar16.2, Name='Total Amount Due' / rts=25 row=float;
	keylabel sum='Total Due';
	where Name in('France','Germany');
run;
* What is the total Sales YTD for Europe?;	
proc tabulate
	data=project.SalesAnalysis;
	class Group;
	var SalesYTD;
	table SalesYTD=' '*f=dollar16.2, Group='Total Sales YTD' / rts=25 row=float;
	keylabel sum='Total Due';
run;	
proc tabulate
	data=project.SalesAnalysis;
	class Group;
	var SalesYTD;
	table SalesYTD=' '*f=dollar16.2, Group='Total Sales YTD In Europe' / rts=25 row=float;
	keylabel sum='Total Due';
	where Group='Europe';
run;	
* How many total territories in U.S?;
proc format;
	value Territoryfmt
	low-high='Territories';
run;
proc tabulate
	data=project.SalesDetails;
	format TerritoryID Territoryfmt.;
	class CountryRegionCode TerritoryID;
	table TerritoryID=' ', CountryRegionCode='Country Code' / rts=25 row=float;
	keylabel n=' ';
run;
proc tabulate
	data=project.SalesDetails;
	format TerritoryID Territoryfmt.;
	class CountryRegionCode TerritoryID;
	table TerritoryID=' ', CountryRegionCode='Country Code' / rts=25 row=float;
	keylabel n=' ';
	where CountryRegionCode='US';
run;
* Chart;
proc format;
	value 	$CountryRegionName
			'US'='United States'
			'CA'='Canada'
			'AU'='Australia'
			'GB'='United Kingdom'
			'FR'='France'
			'DE'='Germany';
run;
title'Total Due BY Country';
proc gchart
	data=project.SalesDetails;
	format CountryRegionCode $CountryRegionName.;
	label  CountryRegionCode='Country'
			TotalDue="Total Due in USD";
	vbar CountryRegionCode/ sumvar=TotalDue descending noframe;
run;
title'Total Due & Percentages in The US by Region';
proc gchart
	data=project.SalesDetails;
	pie Name/ sumvar=TotalDue descending clockwise angle=90 percent=inside noheading;
	where CountryRegionCode='US';
run;
quit;