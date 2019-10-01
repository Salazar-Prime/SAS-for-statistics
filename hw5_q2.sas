ODS HTML CLOSE;
ODS HTML;
dm 'log;clear;output;clear;';

data new; a=3; alpha=.05; d=5; var=10;
	do n=5 to 15;
	df = a*(n-1);
	nc = n*d*d/(2*var);
	fcut = finv(1-alpha,a-1,df);
	beta = probf(fcut,a-1,df,nc);
	power = 1-beta; output;
	end;
proc print;
var n df nc beta power; run;quit;
