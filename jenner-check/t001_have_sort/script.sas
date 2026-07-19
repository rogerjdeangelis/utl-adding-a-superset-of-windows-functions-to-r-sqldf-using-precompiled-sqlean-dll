/* Roger DeAngelis: load the lab/pham/diag values, drop missing.
   Original used libname sd1 "d:/sd1"; bundled run uses WORK. */
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

proc sort data=have out=srt;
by var val;
run;quit;

proc print data=srt;
run;quit;
