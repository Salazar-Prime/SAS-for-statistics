ODS HTML CLOSE;
ODS HTML;
dm 'log;clear;output;clear;';
options nocenter ls=75; goptions operatorors=(none);

data new;
input order operator trt workplace resp @@;
datalines;
1 1 3 2 11 1 2 2 3 10
1 3 4 4 14 1 4 1 1  8

2 1 2 1  8 2 2 3 4 12
2 3 1 3 10 2 4 4 2 12

3 1 1 4  9 3 2 4 1 11
3 3 2 2  7 3 4 3 3 15

4 1 4 3  9 4 2 1 2  8
4 3 3 1 18 4 4 2 4  6
;
proc glm data=new;
class order operator trt workplace;
model resp=order operator trt workplace;
run; quit;
