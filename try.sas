ODS HTML CLOSE;
ODS HTML;
dm 'log;clear;output;clear;';
options ls=80 ps=60 nocenter;
goptions device=win target=winprtm rotate=landscape ftext=swiss
	hsize=8.0in vsize=6.0in htext=1.5 htitle=1.5 hpos=60 vpos=60
	horigin=0.5in vorigin=0.5in;
data one;
	infile 'E:\tensile.dat';
	input percent strength time;
/*title1 �fTensile Strength Example�f;*/
/*proc print data=one; run;*/

proc glm data=one;
	class percent;
	model strength=percent;
	contrast �fC1�f percent 0 0 0 1 -1;
	contrast �fC2�f percent 1 0 1 -1 -1;
	contrast �fC3�f percent 1 0 -1 0 0;
	contrast �fC4�f percent 1 -4 1 1 1;
