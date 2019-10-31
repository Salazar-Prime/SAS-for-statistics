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

/* q3-c = asumption test */
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

/* q3-d = interaction plot */

proc means noprint;
var resp;
by glasstype temp;
output out=batterymean mean=mn;
symbol1 v=circle i=join;
symbol2 v=square i=join;
symbol3 v=triangle i=join;
proc gplot;
plot mn*temp=glasstype;
run;quit;

proc gplot;
plot mn*glasstype=temp;
run;quit;

/* q3-e = bonferroni */

proc glm data=gaugerr;
	class glasstype temp;
	model resp=glasstype temp glasstype*temp;
	means glasstype|temp /bonferroni lines;
	lsmeans glasstype|temp/tdiff adjust=bonferroni;
	run;quit;

/* q3-f = tukey */

proc glm data=gaugerr;
	class glasstype temp;
	model resp=glasstype temp glasstype*temp;
	means glasstype|temp /tukey lines;
	lsmeans glasstype|temp/tdiff adjust=tukey;
	run;quit;

/* q3-g = something stupid */ 

data life;
input mat temp y @@;
if mat=1 then x1=1;
if mat=1 then x2=0;
if mat=2 then x1=0;
if mat=2 then x2=1;
if mat=3 then x1=-1;
if mat=3 then x2=-1;
t=(temp-125)/25;
t2=t*t; x1t=x1*t; x2t=x2*t;
x1t2=x1*t2; x2t2=x2*t2;
datalines;
1 100 58 1 100 56.8 1 100 57 1 125 107 1 125 106.7 1 125 106.5 1 150 129.2 1 150 128.0 1 150 128.6
2 100 55 2 100 53 2 100 57.9 2 125 107 2 125 103.5 2 125 105 2 150 117.8 2 150 116.2 2 150 109.9
3 100 54.6 3 100 57.5 3 100 59.9 3 125 106.5 3 125 107.3 3 125 108.6 3 150 101.7 3 150 105.4 3 150 103.9 
;
proc reg;
model y=x1 x2 t x1t x2t t2 x1t2 x2t2;
run; quit;
