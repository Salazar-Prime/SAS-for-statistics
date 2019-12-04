ODS HTML CLOSE;
ODS HTML;
dm 'log;clear;output;clear;';

option nocenter ps=40 ls=72;
data paper;
input day method mix resp@@; datalines;
1 1 1 64.5 1 1 2 66.3 1 1 3 74.1 1 1 4 66.5 1 2 1 68.3 1 2 2 69.5
1 2 3 73.8 1 2 4 70.0 1 3 1 70.3 1 3 2 73.1 1 3 3 78.0 1 3 4 72.3
2 1 1 65.2 2 1 2 65.0 2 1 3 73.8 2 1 4 64.8 2 2 1 69.2 2 2 2 70.3
2 2 3 74.5 2 2 4 68.3 2 3 1 71.2 2 3 2 72.8 2 3 3 79.1 2 3 4 71.5
3 1 1 66.2 3 1 2 66.5 3 1 3 72.3 3 1 4 67.7 3 2 1 69.0 3 2 2 69.0
3 2 3 75.4 3 2 4 68.6 3 3 1 70.8 3 3 2 74.2 3 3 3 80.1 3 3 4 72.4
;


proc glm data=paper;
	class day method mix;
	model resp=day method day*method mix day*mix
	method*mix day*method*mix;
	random day day*method day*mix day*method*mix;
	test h=method e=day*method;
	test h=mix e=day*mix;
	test h=method*mix e=day*method*mix;
run; quit;
;
