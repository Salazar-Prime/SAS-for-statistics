ODS HTML CLOSE;
ODS HTML;
dm 'log;clear;output;clear;';

option nocenter ps=65 ls=80;
data rats;
	input hormones glycogen @@;
	datalines;
	1 106 1 101 1 120 1 86 1 132 1 97 
	2 51 2 98 2 85 2 50 2 111 2 72
	3 103 3 84 3 100 3 83 3 110 3 91
	4 50 4 66 4 61 4 72 4 85 4 60 
	;
/*proc print data=rats; run;*/
/**/
/*proc glm;*/
/*	class hormones;*/
/*	model glycogen=hormones;*/
/*	output out=diag r=res p=pred; run; quit;*/


proc glm
	data=rats;
	class hormones;
	model glycogen=hormones;
	contrast 'C1' hormones 1 1 -1 -1;
	contrast 'C2' hormones 1 -1 1 -1;
	contrast 'C3' hormones 1 -1 -1 1;
