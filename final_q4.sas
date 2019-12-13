ODS HTML CLOSE;
ODS HTML;
dm 'log;clear;output;clear;';

option nocenter ps=40 ls=72;
/*data paper;*/
/*input day method mix resp@@; datalines;*/
/*1 1 1 64.5 1 1 2 66.3 1 1 3 74.1 1 1 4 66.5 1 2 1 68.3 1 2 2 69.5*/
/*1 2 3 73.8 1 2 4 70.0 1 3 1 70.3 1 3 2 73.1 1 3 3 78.0 1 3 4 72.3*/
/*2 1 1 65.2 2 1 2 65.0 2 1 3 73.8 2 1 4 64.8 2 2 1 69.2 2 2 2 70.3*/
/*2 2 3 74.5 2 2 4 68.3 2 3 1 71.2 2 3 2 72.8 2 3 3 79.1 2 3 4 71.5*/
/*3 1 1 66.2 3 1 2 66.5 3 1 3 72.3 3 1 4 67.7 3 2 1 69.0 3 2 2 69.0*/
/*3 2 3 75.4 3 2 4 68.6 3 3 1 70.8 3 3 2 74.2 3 3 3 80.1 3 3 4 72.4*/
/*;*/

data paper;
input vendor barsize heat resp@@; datalines;
1 1 1 1.23
1 1 2 1.346
1 1 3 1.235
1 1.5 1 1.316
1 1.5 2 1.329
1 1.5 3 1.25
1 2 1 1.287
1 2 2 1.346
1 2 3 1.273
2 1 1 1.301
2 1 2 1.346
2 1 3 1.315
2 1.5 1 1.274
2 1.5 2 1.384
2 1.5 3 1.346
2 2 1 1.247
2 2 2 1.362
2 2 3 1.336
3 1 1 1.247
3 1 2 1.275
3 1 3 1.324
3 1.5 1 1.273
3 1.5 2 1.26
3 1.5 3 1.392
3 2 1 1.301
3 2 2 1.28
3 2 3 1.319
;

/*proc glm data=paper;*/
/*	class vendor barsize heat;*/
/*	model resp=vendor barsize vendor*barsize heat vendor*heat*/
/*	barsize*heat vendor*barsize*heat;*/
/*	random vendor vendor*barsize vendor*heat vendor*barsize*heat;*/
/*	test h=barsize e=vendor*barsize;*/
/*	test h=heat e=vendor*heat;*/
/*	test h=barsize*heat e=vendor*barsize*heat;*/
/*run; quit;*/
/*;*/

proc glm data=paper;
	class vendor barsize heat;
	model resp=vendor barsize vendor*barsize heat vendor*heat
	barsize*heat vendor*barsize*heat;
	random vendor  heat vendor*barsize barsize*heat vendor*heat vendor*barsize*heat;
	test h=barsize*vendor*barsize*heat e=vendor*barsize*heat*barsize;
	test h=heat e=vendor*heat;
	test h=barsize*heat e=vendor*barsize*heat;
run; quit;
;
