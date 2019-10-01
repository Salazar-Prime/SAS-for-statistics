ODS HTML CLOSE;
ODS HTML;
dm 'log;clear;output;clear;';

data bake; input oven temp y @@; cards;
1 1 3 1 2 3 1 3 9 1 4 7 
2 1 10 2 2 8 2 3 13 2 4 12 
3 1 7 3 2 12 3 3 15 3 4 9
4 1 4 4 2 2 4 3 3 4 4 8
5 1 3 5 2 4 5 3 10 5 4 13
;

/* 4(c) */

/*proc glm data=bake;*/
/*class oven temp;*/
/*model y = temp oven;*/
/*means temp/alpha=0.05 tukey lines;*/
/*output out=diag r=res p=pred;*/
/*proc univariate noprint normal;*/
/*qqplot res/normal (L=1 mu=est sigma=est);*/
/*histogram res/normal (L=1 mu=est sigma=est) kernel(L=2 K=quadratic);*/
/*proc gplot; plot res*pred;*/
/*symbol1 v=circle i=joint;*/
/*proc gplot data=diag; plot y*temp=oven; run; quit;*/

/* 4(e) */

proc glm
	data=bake;
	class temp;
	model y = temp;
	contrast 'C1' temp 1 -1 0 0;
	contrast 'C2' temp 0 0 -1 1;
	contrast 'C3' temp 1 1 -1 -1;
