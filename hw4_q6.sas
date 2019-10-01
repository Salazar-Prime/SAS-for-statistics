/*data example; input batch percent @@; cards;*/
/*1 74 1 76 1 75 2 68 2 71*/
/*2 72 3 75 3 77 3 77 4 72*/
/*4 74 4 73 5 79 5 81 5 79*/
/*;*/
ODS HTML CLOSE;
ODS HTML;
dm 'log;clear;output;clear;';

option nocenter ps=65 ls=80;
data pine;
	infile 'E:\stomata.dat';
	input needle stomata;

title1 'DATA';
proc print data=pine; run;

/* 6(b) */
title1 'variance components';
proc glm data=pine;
	class needle;
	model stomata=needle;
	random needle;
	output out=diag r=res p=pred;

proc gplot data=diag;
	plot res*pred;

proc mixed data=pine cl;
	class needle;
	model stomata = ;
	random needle / vcorr; run; quit;
