ODS HTML CLOSE;
ODS HTML;
dm 'log;clear;output;clear;';
options nocenter ls=75; goptions operatorors=(none);

data new1; a=4; alpha=.05; var=1; d=5;
do n=1 to 6;
df = a*(n-1); nc = d/sqrt(var*2/n);
/* crit = tinv(1-alpha/2,df); /* LSD approach*/
crit = probmc("range",.,1-alpha,df,a)/sqrt(2); /*Tukey*/
power=1-probt(crit,df,nc)+probt(-crit,df,nc); output;
end;
proc print; var n df nc power; run;
