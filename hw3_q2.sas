ODS HTML CLOSE;
ODS HTML;

data new1; n1=8; n2=6; sigma=1.987; delta=2; alpha=0.05;
	df = n1+n2-2; nc=delta/(sigma*(sqrt(1/n1+1/n2)));
	rlow = tinv(alpha/2,df); rhigh=tinv(1-alpha/2,df);
	p=1-probt(rhigh,df,nc)+probt(rlow,df,nc);
title1 '(b)  two sample t-test for beers';
proc print data=new1; run;
