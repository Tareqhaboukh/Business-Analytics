proc import
	datafile='/home/u59396653/BAN 100/Assignment 1/CARS_1993.csv'
	out= 	cars_1993
	dbms= 	csv
	replace;
run;

title 'Frequency Distributions';
proc freq
	data=	work.cars_1993
	order=	freq;
	table  Manufacturer * Category;

title 'Frequency Distributions';

proc freq
	data=	work.cars_1993
	order=	freq;
	table 	Manufacturer
			Category
			Cylinders
			Passenger;
run;

proc freq 
	data=	work.cars_1993;
	table 	Air_Bags
			Drive_Train
			Manual
			Domestic /nocum;
run;

title 'Means';
proc means 
	mean median mode min max range q1 q3 qrange var std
	maxdec=1
	data=	work.cars_1993;
	variables 	Min_Price
				Mid_Price
				Max_Price
				City_Fuel
				Hwy_Fuel
				Average_Fuel
				Max_HP;
run;

title 'Variables Corralating with Mid_Price ';

proc corr 
	data=work.cars_1993 nosimple noprob;
    var Mid_Price;
    with Max_HP Engine_size Average_fuel;
run;

title 'Max_HP & Mid_Price';
proc sgplot 
	data=work.cars_1993;
 	scatter x=Mid_Price y=Max_HP / group=Category;
run;

title 'Engine_size & Mid_Price';
proc sgplot 
	data=work.cars_1993;
 	scatter x=Mid_Price y=Engine_size / group=Category;
run;

title 'Average_fuel & Mid_Price';
proc sgplot 
	data=work.cars_1993;
 	scatter x=Mid_Price y=Average_Fuel / group=Category;
run;

title 'Variables Correlating with Engine_Size';
proc corr
	data=work.cars_1993 nosimple noprob;
    var Engine_size;
    with Max_HP Average_Fuel;
run;

title 'Max_HP & Engine_Size';
proc sgplot 
	data=work.cars_1993;
	scatter x=Engine_size y=Max_HP / group=Category;
run;

title 'Average_fuel & Engine_Size';
proc sgplot
	data=work.cars_1993;
 	scatter x=Engine_size y=Average_Fuel / group=Category;
run;

title 'Variables Correlating with Engine_Size';
proc corr
	data=work.cars_1993 nosimple noprob;
    var weight;
    with Average_Fuel;
run;

title 'Max_HP & Engine_Size';
proc sgplot 
	data=work.cars_1993;
	scatter x=Weight y=Average_Fuel / group=Category;
run;