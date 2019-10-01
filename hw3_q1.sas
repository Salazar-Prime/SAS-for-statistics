/* Tells SAS to not center the output in the output window */
options nocenter;
ODS HTML CLOSE;
ODS HTML;
ods escapechar="^";
/* These options control the graphics output */
goptions htext=1.0 htitle=1.5 ftext=swiss ftitle=swissb cback=white
         hsize=5in vsize=4in rotate=landscape vpos=35 hpos=35;

/* To compute the power for a two sample t-test, you need 

    alpha = significance level
    n     = sample size
    sigma = standard deviation
    delta = the desired detectable diff between means
  
   To compute the sample size necessary for a specific power level, you need

    alpha = significance level
    sigma = standard deviation
    delta = the desired detectable diff between means
    power = the desired power level
*/

/* Create data set that contains the variables common to both procedures */
data new;                       
 input alpha sigma;     
 cards;                         
   .10 4                 
 ;

/* Figure 1: Compute a power curve 
   Uses alpha and sigma from dataset new
   Defines value for n and range for delta within dataset new1
*/

data new1; set new;
 n=9;
 do delta = 0 to 1 by .10; 
    df = 2*(n-1); nc = delta/(sigma*sqrt(2/n)); 
    rlow  = tinv(alpha/2,df); rhigh = tinv(1-alpha/2,df); 
    p=1-probt(rhigh,df,nc)+probt(rlow,df,nc); output;
 end;

symbol1 v=circle i=sm5; title1 'Power Curve I for t-test';
axis1 label=('prob'); axis2 label=('Difference in Means');
/*proc gplot;  plot p*delta / haxis=axis2 vaxis=axis1; run;*/

/* Figure 2: Find appropriate sample size
    Uses alpha and sigma from dataset new
    Defines values for delta and range for n within dataset new1
    A horizontal line is drawn at the desired power level (using vref option)
*/

data new2; set new;
 delta=5;
 do n=2 to 20 by 1; 
    df = 2*(n-1); nc = delta/(sigma*sqrt(2/n));
    rhigh = tinv(1-alpha,df);
    p=1-probt(rhigh,df,nc); output;
 end;

symbol1 v=circle i=sm5; title "Power Curve for t-test (alpha=.10 sigma=4.0 prob=0.95)";
axis1 label=('prob'); axis2 label=('Sample Size');
proc gplot;  plot p*n / haxis=axis2 vaxis=axis1 vref=0.95 href=12; run;
