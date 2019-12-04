ODS HTML CLOSE;
ODS HTML;
dm 'log;clear;output;clear;';

option nocenter ps=40 ls=72;

data molding;
do D = -1 to 1 by 2; do C = -1 to 1 by 2;
	do B = -1 to 1 by 2; do A = -1 to 1 by 2;
		E=A*B*C; F=B*C*D; input y @@; output;
	end; end;
end; end; 

datalines;
74 190 133 127 115 101 54 144 121 188 135 170 126 175 126 193
;

/* Define Interaction Terms */
data inter; set molding;
AB=A*B; AC=A*C; AD=A*D; AE=A*E; AF=A*F; BD=B*D; BF=B*F;
ABD=A*B*D; ABF=A*B*F;
/* (f) GLM Proc to Obtain Effects */
proc glm data=inter;
	class A B C D E F AB AC AD AE AF BD BF ABD ABF;
	model y=A B C D E F AB AC AD AE AF BD BF ABD ABF;
	estimate ’A’ A -1 1; estimate ’B’ B -1 1; estimate ’C’ C -1 1;
	estimate ’D’ D -1 1; estimate ’E’ E -1 1; estimate ’F’ F -1 1;
	estimate ’AB’ AB -1 1; estimate ’AC’ AC -1 1; estimate ’AD’ AD -1 1;
	estimate ’AE’ AE -1 1; estimate ’AF’ AF -1 1; estimate ’BD’ BD -1 1;
	estimate ’BF’ BF -1 1; estimate ’ABD’ ABD -1 1;estimate ’ABF’ ABF -1 1;	
run; quit;

proc reg outest=effects data=inter;
	model y=A B C D E F AB AC AD AE AF BD BF ABD ABF;
data effect2;
	set effects; drop y intercept _RMSE_;
proc transpose data=effect2 out=effect3;
data effect4;
set effect3; effect=col1*2;
proc sort data=effect4; by effect;
proc print data=effect4;
proc rank data=effect4 normal=blom out=effect5;
var effect;
ranks neff;
symbol1 v=circle;
proc gplot data=effect5;
	plot effect*neff=_NAME_;
run; quit;

/* (i) and (j) Define Interaction Terms for selected model */
data inter2; set molding;
	CD = C*D; DE = D*E;

proc glm data=inter2;
	class A C D E CD DE;
	model y=A C D E CD DE;
	output r=res p=pred;
run; quit;

proc reg;
	model y=A C D E CD DE;
run; quit;
