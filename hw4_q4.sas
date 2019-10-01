ODS HTML CLOSE;
ODS HTML;
dm 'log;clear;output;clear;';

option nocenter ps=65 ls=80;
data one;
	infile 'E:\hw4.dat';
	input treatment response;
/* 4(a) */

/*proc glm;*/
/*	class treatment;*/
/*	model response=treatment;*/
/*	output out=diag r=res p=pred; run; quit;*/


/* 4(b) */

/*proc glm data=one;*/
/*	class treatment; model response=treatment;*/
/*	means treatment / hovtest=bartlett hovtest=levene;*/
/*	output out=diag r=res p=pred; run; quit;*/
/**/
/*proc sort; by pred;*/
/*symbol1 v=circle i=sm50; title1 'Residual Plot';*/
/*proc gplot; plot res*pred/frame; run; quit;*/


/* 4(c) */

/* This computes the sample mean (mu) and standard deviation (sigma) at each treatment level and outputs this information to SAS file "two" */
/*proc univariate data=one noprint;*/
/* var response; by treatment;*/
/* output out=two mean=mu std=sigma;*/

/* This creates a new SAS data set "three" which contains the natural logs of both the sample means and standard deviations */
/*data three;*/
/* set two;*/
/* logmu = log(mu);*/
/* logsig = log(sigma);*/

 /* Perform a regression analysis on these log transformed values */
/*proc reg;*/
/* model logsig = logmu;*/
/**/
/*title1 'Mean vs Std Dev';*/
/*symbol1 v=circle i=rl;*/
/*proc gplot;*/
/* plot logsig*logmu / regeqn;*/
/*run; quit;*/


/* 4(d) */

/*proc univariate data=one noprint;*/
/*logresp = log(response);*/
/*var logresp; output out=two mean=mlogresp;*/
/**/
/*data three;*/
/*set one; if _n_ eq 1 then set two;*/
/*ydot = exp(mlogresp);*/
/*do l=-2.0 to 2.0 by .25;*/
/*den = l*ydot**(l-1); if abs(l) eq 0 then den = 1;*/
/*yl=(resp**l -1)/den; if abs(l) < 0.0001 then yl=ydot*log(resp);*/
/*output;*/
/*end;*/
/*keep trt yl l;*/
/**/
/*proc sort data=three out=three; by l;*/
/**/
/*proc glm data=three noprint outstat=four;*/
/*class trt; model yl=trt; by l;*/
/**/
/*data five; set four;*/
/*if _SOURCE_ eq 'ERROR'; keep l SS;*/
/**/
/*proc print data=five; run; quit;*/
/**/
/*symbol1 v=circle i=sm50;*/
/*proc gplot; plot SS*l; run; quit;*/


/* 4(e) */


res_approx = response**(1-0.83482);
res_formal = response**(0.25);

title1 'Hypothesis - Approx correction';

proc glm;
	class treatment;
	model response=treatment;
	output out=diag r=res p=pred; run; quit;

title1 'Residual Plot - Approx correction';

proc glm data=one;
	class treatment; model res_approx=treatment;
	means treatment / hovtest=bartlett hovtest=levene;
	output out=diag r=res p=pred; run; quit;

proc sort; by pred;
symbol1 v=circle i=sm50; title1 'Residual Plot - Approx correction';
proc gplot; plot res*pred/frame; run; quit;

title1 'Hypothesis - Formal correction';

proc glm;
	class treatment;
	model response=treatment;
	output out=diag r=res p=pred; run; quit;
title1 'Residual Plot - Formal correction';

proc glm data=one;
	class treatment; model res_formal=treatment;
	means treatment / hovtest=bartlett hovtest=levene;
	output out=diag r=res p=pred; run; quit;

proc sort; by pred;
symbol1 v=circle i=sm50; title1 'Residual Plot - Formal correction';
proc gplot; plot res*pred/frame; run; quit;

