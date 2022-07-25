filename reffile '/home/u59396653/BAN 100/Assignment 6/Customer.xlsx';
proc import
	datafile=reffile dbms=xlsx out=Problem1;
	getnames=yes;
run;

data Problem1;
	set problem1;
	if Rating in ('Excellent','Very Good') Then Y=1;
	else if Rating in ('Good','Fair') Then Y=0;
run;
proc sort
	data=Problem1;
	by descending Price;
run;
proc print data=Problem1 noobs; run;
/* Fitting a simple regression line to predict Quality Rating */
proc reg
	data=Problem1;
	model Y=Price;
run;
* Scatter Plot Y*Price;
proc sgplot
	data=Problem1;
	scatter x=Price y=Y;
run;
/* Fitting a Logistic regression line to predict Quality Rating */
proc logistic
	data=Problem1;
	model Y(event='1')=Price;
run;