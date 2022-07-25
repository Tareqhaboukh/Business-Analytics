PROC IMPORT DATAFILE='/home/u59396653/BAN 100/Assignment 3/Lifetime_of_Jobs_by_Educational_Level_stacked.xlsx'
	DBMS=XLSX
	OUT=WORK.IMPORT2;
	GETNAMES=YES;
RUN;


data stacked2;
	set work.import2;
run;

*proc print data=stacked2 noobs;
proc univariate
	data=stacked2;
	ppplot JobLifetime;
run;

/*
proc sgplot data=stacked2; 
  histogram JobLifetime;
  density JobLifetime;
run;
*/

*ods graphics off;
proc anova
	data=stacked2;
	class Gender Education;
	model JobLifetime = Gender Education Gender*Education;
	means Gender Education;
run;

proc sgplot
	data=stacked2;
	vbox JobLifetime/ category= gender group= education;
run;

ods graphics off;
proc glm
	data=stacked2;
	class Gender Education;
	model JobLifetime = Gender Education Gender*Education;
run;


ods graphics off;
proc glm
	data=stacked2;
	class Gender Education;
	model JobLifetime = Gender Education Gender*Education;
	means Education/ tukey;
run;

ods graphics off;
proc glm
	data=stacked2;
	class Education;
	model JobLifetime = Education;
	lsmeans Education/ adjust= tukey;
run;


ods graphics off;
proc glm
	data=stacked2;
	class Education;
	model JobLifetime = Education;
	lsmeans Education/ pdiff;
run;