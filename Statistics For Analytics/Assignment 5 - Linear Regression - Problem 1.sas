* Problem 1 - 10 Marks;
proc import
	file='/home/u59396653/BAN 100/Assignment 5/File_MALL.xlsx'
	dbms=xlsx
	out=mall;
	getnames=yes;
run;
title'Mall File';
proc print
	data=mall noobs;
run;
proc contents
	data=mall;
run;
proc means
	data=mall maxdec=1;
run;
proc univariate
	data=mall;
	ppplot Size Windows Competitors Mall_Size Nearest_Competitor;
run;


* Sales Size Windows Competitors Mall_Size Nearest_Competitor;
* Multiple Regression line for Mall sales;
proc reg
	data=mall;
	model Sales= Size Windows Competitors Mall_Size Nearest_Competitor /r ;
run;
* Regression with Studresids sorted;
proc reg
	data=mall;
	model Sales= Size Windows Competitors Mall_Size Nearest_Competitor /r ;
	output out=demo cookd=cook student=studresids;
run;
proc sort
	data=demo;
	by studresids;
run;
proc print
	data=demo;
run;
* Regression with Cook sorted;
proc reg
	data=mall;
	model Sales= Size Windows Competitors Mall_Size Nearest_Competitor /r ;
	output out = demo cookd= cook;
run;
proc sort
	data= demo;
	by cook;
run;
proc print
	data=demo;
run;
* Selecting Methods;
title "Forward Selection Methods";
proc reg data=mall;
	model Sales= Size Windows Competitors Mall_Size Nearest_Competitor / selection = forward;
run;
title "Backward Selection Methods";
proc reg data=mall;
	model Sales= Size Windows Competitors Mall_Size Nearest_Competitor / selection = backward;
run;
title "Stepwise Selection Methods";
proc reg data=mall;
	model Sales= Size Windows Competitors Mall_Size Nearest_Competitor / selection = stepwise r;
run;