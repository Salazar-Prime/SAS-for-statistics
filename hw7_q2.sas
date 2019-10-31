ODS HTML CLOSE;
ODS HTML;
dm 'log;clear;output;clear;';

options nocenter ps=60 ls=75;
data example;
input additive car mileage @@;
datalines;
1 2 17 1 3 14 1 4 13 1 5 12
2 1 14 2 2 14 2 4 13 2 5 10
3 1 12 3 3 13 3 4 12 3 5 9
4 1 13 4 2 11 4 3 11 4 4 12
5 1 11 5 2 12 5 3 10 5 5 8
;
proc glm;
	class car additive;
	model mileage = car additive;
	lsmeans additive / tdiff pdiff adjust=bon stderr;
	lsmeans additive / pdiff adjust=tukey;
	contrast 'C1' additive 1 1 0 -1 -1;
	run; quit;
