/* Roger DeAngelis: same have data; reproduce the per-var
   iqr / mean / median / pctlab summary his sqldf 'want' returns,
   using native SAS instead of the R + sqlean bridge. */
data have(where=(not missing(val)));
 input var$ val;
cards4;
lab 200
pham 6000
diag 5500
lab 100
pham 7000
lab 50
pham 3800
lab 4600
pham 1500
lab 700
pham 9000
diag 2900
lab 500
lab 900
pham 5600
diag 8500
lab 360
pham 9900
diag 8900
lab 770
;;;;
run;quit;

/* grand total of all val, for pctlab */
proc sql noprint;
 select sum(val) into :grand trimmed from have;
quit;

/* per-var quartiles/mean/median via PROC MEANS */
proc means data=have noprint;
 class var;
 var val;
 output out=stats(where=(_type_=1))
   mean=mean median=median q1=q1 q3=q3 sum=labsum;
run;quit;

data want;
 set stats;
 length var $8;
 iqr = q3 - q1;
 /* pctlab: lab contribution to the grand total (0 unless var='lab') */
 if var='lab' then pctlab = 100*labsum/&grand;
 else pctlab = 0;
 keep var iqr mean median pctlab;
run;quit;

proc print data=want noobs;
 var var iqr mean median pctlab;
 format mean median 8.4 pctlab 8.4 iqr 8.;
run;quit;
