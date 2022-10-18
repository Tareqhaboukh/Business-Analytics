PROC IMPORT DATAFILE='/home/u59396653/BAN 100/Assignment 3/Total Assets Invested Stacked.xlsx'
	DBMS=XLSX
	OUT=WORK.IMPORT1;
	GETNAMES=YES;
RUN;

data stacked1;
	set work.import1;
run;

/*
proc sgplot data=stacked1; 
  histogram TotalAssets;
  density TotalAssets;
run;
*/

*proc print data=stacked noobs;
proc univariate
	data=stacked1;
	ppplot TotalAssets;
run;
*ods graphics off;
proc anova
	data=stacked1;
	class AgeGroup;
	model TotalAssets = AgeGroup;
	means AgeGroup;
run;

ods graphics off;
proc anova
	data=stacked1;
	class AgeGroup;
	model TotalAssets = AgeGroup;
	means AgeGroup/ tukey;
run;

ods graphics off;
proc glm
	data=stacked1;
	class AgeGroup;
	model TotalAssets = AgeGroup;
	means AgeGroup/ tukey;
	lsmeans AgeGroup/ adjust=tukey;
run;

ods graphics off;
proc glm
	data=stacked1;
	class AgeGroup;
	model TotalAssets = AgeGroup;
	means AgeGroup/ SNK;
run;