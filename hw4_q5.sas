ODS HTML CLOSE;
ODS HTML;
dm 'log;clear;output;clear;';

option nocenter ps=65 ls=80;
data circuit;
	infile 'E:\defects.dat';
	input design defect;


/*proc print data=circuit; run;*/

/* 5(a) */

title1 'Hypothesis Testing';
proc glm data=circuit;
	class design;
	model defect=design;
	output out=diag r=res p=pred; run; quit;
/* 5(b) */

title1 'Normality Testing';
proc univariate data=diag normal;
	var res; qqplot res / normal (L=1 mu=est sigma=est);
	histogram res / normal; run; quit;
/* 5(c) */

title1 'Kruskal - Wallis Test';
proc npar1way data=circuit;
	class design; var defect; run; quit;
