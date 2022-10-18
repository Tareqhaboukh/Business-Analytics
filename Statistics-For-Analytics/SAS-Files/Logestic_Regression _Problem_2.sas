filename reffile '/home/u59396653/BAN 100/Assignment 6/titanic.csv';
proc import
	datafile=reffile dbms=csv out=Problem2;
	getnames=yes;
run;
proc print data=Problem2 noobs; run;
* Scatter Plot Age*Age;
proc sgplot
	data=Problem2;
	scatter x=Age y=Survived;
run;
/* Fitting a Logistic regression line to predict survival Rate */
proc logistic
	data=Problem2;
	model Survived=Age;
run;
proc logistic
	data=Problem2;
	class sex(param=ref ref='female');
	model Survived=Age Sex;
run;
proc logistic
	data=Problem2;
	class 	sex(ref='female')
			Class(ref='1')
			SiblingSpouse(ref='1')/param=ref;
	model Survived(event='1')=Age Sex Class SiblingSpouse;
run;

proc logistic
	data=Problem2;
	class 	sex(ref='female') 
			class(ref='1') 
			SiblingSpouse(ref='0')
			ParentChild(ref='0')
			Embarked(ref='C')/param=ref;
	model Survived(event='1')=Age sex class SiblingSpouse ParentChild Embarked;
run;

proc logistic
	data=Problem2;
	class 	sex(ref='female') 
			class(ref='1') 
			SiblingSpouse(ref='0')
			ParentChild(ref='0')
			Embarked(ref='C')/param=ref;
	model Survived(event='1')=Age sex class;
run;



proc logistic
	data=Problem2;
	class 	sex(ref='female') 
			class(ref='1')
			Embarked(ref='C')/param=ref;
	model Survived(event='1')=Age Sex Class;
run;