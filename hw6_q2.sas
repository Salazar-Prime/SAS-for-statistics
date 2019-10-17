ODS HTML CLOSE;
ODS HTML;
dm 'log;clear;output;clear;';
options nocenter ls=75; goptions colors=(none);

data new;
input operator order trt resp @@; datalines;
1 1 3 10  1 2 2 7   1 3 1 5   1 4 4 10
2 1 4 14  2 2 3 18  2 3 2 10  2 4 1 10
3 1 1 7   3 2 4 11  3 3 3 11  3 4 2 12
4 1 2 8   4 2 1 8   4 3 4 9   4 4 3 14
;

/* 2(b) */

proc glm;
	class operator trt order;
	model resp=trt order operator;
	means trt/ lines tukey;
	means order operator;
	output out=new1 r=res p=pred;

symbol1 v=circle;
proc gplot; plot res*pred;


proc univariate noprint normal;
qqplot res/normal (L=1 mu=est sigma=est);
histogram res/normal (L=1 mu=est sigma=est) kernel(L=2 K=quadratic);
proc gplot; plot res*pred;

symbol1 v=circle i=joint;
proc gplot data=diag; plot y*soap=stain; run; quit;
