ODS HTML CLOSE;
ODS HTML;
dm 'log;clear;output;clear;';

options nocenter ls=75;
data gaugerr;
input glasstype temp resp @@;
cards;
1 1 58 1 1 56.8 1 1 57 1 2 107 1 2 106.7 1 2 106.5 1 3 129.2 1 3 128.0 1 3 128.6
2 1 55 2 1 53 2 1 57.9 2 2 107 2 2 103.5 2 2 105 2 3 117.8 2 3 116.2 2 3 109.9
3 1 54.6 3 1 57.5 3 1 59.9 3 2 106.5 3 2 107.3 3 2 108.6 3 3 101.7 3 3 105.4 3 3 103.9 
;

proc glm;
	class glasstype temp;
	model resp=glasstype temp glasstype*temp;
	output out=batnew r=res p=pred;
	run; quit;

/* q2-c = asumption test */
proc univariate noprint normal;
qqplot res/normal (L=1 mu=est sigma=est);
histogram res/normal (L=1 mu=est sigma=est) kernel(L=2 K=quadratic);
proc gplot; plot res*pred; 
symbol1 v=circle i=none;

proc gplot; plot res*glasstype; 
symbol1 v=circle i=none;

proc gplot; plot res*temp; 
symbol1 v=circle i=none;

proc gplot; plot res*resp; 
symbol1 v=circle i=none;

run; quit;
