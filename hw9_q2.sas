ODS HTML CLOSE;
ODS HTML;
dm 'log;clear;output;clear;';

option nocenter ps=40 ls=72;
data purity;
input process batch resp@@;
datalines;
1 1 25 1 1 30 1 1 26 1 2 19 1 2 28 1 2 20
1 3 15 1 3 17 1 3 14 1 4 15 1 4 16 1 4 13
2 1 19 2 1 17 2 1 14 2 2 23 2 2 24 2 2 21
2 3 18 2 3 21 2 3 17 2 4 35 2 4 27 2 4 25
3 1 14 3 1 15 3 1 20 3 2 35 3 2 21 3 2 24
3 3 38 3 3 54 3 3 50 3 4 25 3 4 29 3 4 33
;
/* when process is random and batch is random */

/*proc mixed method=type1;*/
/*class process batch;*/
/*model resp=;*/
/*random process batch(process);*/


/* when process is fixed and batch is random */

proc mixed method=type1;
class process batch;
model resp=process;
random batch(process);
run; quit;
