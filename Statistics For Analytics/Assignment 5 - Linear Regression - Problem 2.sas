* Problem 2 - 10 Marks;
proc import
	file='/home/u59396653/BAN 100/Assignment 5/File_NFLValues.xlsx'
	dbms=xlsx
	out=NFLValues;
	getnames=yes;
run;
title'NFL Values File';
proc print
	data=NFLValues noobs;
run;

proc sgplot
	data=NFLValues;
	reg x=Revenue y=Value;
	scatter x=Revenue y=Value;
run;

proc reg
	data=NFLValues;
	model Value= Revenue /r ;
run;

proc import
	file='/home/u59396653/BAN 100/Assignment 5/File_NFLValuesOutlierRemove.xlsx'
	dbms=xlsx
	out=NFLValuesOutlierRemove;
	getnames=yes;
run;
title'NFL Values File';
proc print
	data=NFLValuesOutlierRemove noobs;
run;
proc reg
	data=NFLValuesOutlierRemove;
	model Value= Revenue /r ;
run;