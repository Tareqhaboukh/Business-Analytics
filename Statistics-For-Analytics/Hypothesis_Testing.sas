proc import
	datafile='/home/u59396653/BAN100/Assignment 2/File BIRTH.xlsx'
	out=birth_weight
	dbms=XLSX
	replace;
	getnames=YES;
run;

proc print
	data=birth_weight;
run;





title 'Black Mother';
proc means data=birth_weight maxdec=1;
VAR weight;
where black = 1;
run;
proc sgplot data=birth_weight; 
  histogram weight;
  density weight;
  where black = 1;
run;
title 'Not Black Mother';
proc means data=birth_weight maxdec=1;
var weight;
where black = 0;
run;
proc sgplot data=birth_weight; 
  histogram weight;
  density weight;
  where black = 0;
run;

proc ttest
	data=birth_weight;
	class black;
	var weight;
run;
proc univariate
	data=birth_weight;
   var weight;
   histogram;
run;


proc means 	data=birth_weight
	mean median mode min max range q1 q3 std
	maxdec=1;
	variable weight;
run;
proc means 	data=birth_weight
	mean median mode min max range q1 q3
	maxdec=1;
	variable weight;
run;
proc means 	data=birth_weight
	maxdec=1;
	variable weight;
run;

proc sgplot data=birth_weight; 
  histogram weight;
  density weight;
run;






title 'Married Mother';
proc means data=birth_weight maxdec=1;
VAR weight;
where married = 1;
run;
title 'Married Mother';
proc sgplot data=birth_weight; 
  histogram weight;
  density weight;
  where married = 1;
run;
title 'Not Married Mother';
proc means data=birth_weight maxdec=1;
var weight;
where married = 0;
run;
title 'Married Mother';
proc sgplot data=birth_weight; 
  histogram weight;
  density weight;
  where married = 0;
run;

proc ttest
	data=birth_weight;
	class married;
	var weight;
run;








title 'Boy';
proc means data=birth_weight maxdec=1;
VAR weight;
where boy = 1;
run;
title 'Boy';
proc sgplot data=birth_weight; 
  histogram weight;
  density weight;
  where boy = 1;
run;
title 'Not a Boy';
proc means data=birth_weight maxdec=1;
var weight;
where boy = 0;
run;
title 'Not a Boy';
proc sgplot data=birth_weight; 
  histogram weight;
  density weight;
  where boy = 0;
run;


proc ttest
	data=birth_weight h0=0 side=l;
	class boy;
	var weight;
run;








title 'Smoker';
proc means data=birth_weight maxdec=1;
VAR weight;
where MomSmoke = 1;
run;
title 'Smoker';
proc sgplot data=birth_weight; 
  histogram weight;
  density weight;
  where MomSmoke = 1;
run;
title 'Non Smoker';
proc means data=birth_weight maxdec=1;
var weight;
where MomSmoke = 0;
run;
title 'Non Smoker';
proc sgplot data=birth_weight; 
  histogram weight;
  density weight;
  where MomSmoke = 0;
run;

proc ttest
	data=birth_weight;
	class MomSmoke;
	var weight;
run;