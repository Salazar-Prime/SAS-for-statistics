ODS HTML CLOSE;
ODS HTML;
dm 'log;clear;output;clear;';

/* 1(b) - fractional df*/
data _null_;
pv = 0.995; df = 2.508; z1 = CINV(1-pv,df);;
put z1=;
run;

/* 1(c) - power calculation*/
data new; a = 6; alpha=.01; ratiovar=0.5; n=10;
df = a*(n-1);
lambdasq = 1+ratiovar*n;
fcut = finv(1-alpha,a-1,df);
beta=probf(fcut/lambdasq,a-1,df);
power = 1-beta; output;
proc print;
var n beta power; run;
