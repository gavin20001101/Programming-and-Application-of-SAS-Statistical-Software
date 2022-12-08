data homework2; set sasuser.H_nhi_ipdte96;
run;
proc corr data= homework2;
var DRUG_DOT;
with PART_DOT;
run;
data homework3; set sasuser.H_nhi_ipdte96;
/*性別*/
length sex $6;
if ID_S = 1 then sex = 'Male';
if ID_S = 2 then sex = 'Female';
run;
proc means data = homework3 mean;
class sex;
var MED_DOT;
run;
data homework4; set homework3;
/*AGE*/
birth_ymd = input (birth_ym, yymmn6.);
in_datenum = input (in_date, yymmdd8.);
age = int(YRDIF(birth_ymd, in_datenum,'actual'));
/*分組*/
if 0<=age<20 then agedis = 1;
if 20<=age<40 then agedis = 2;
if 40<=age<60 then agedis = 3;
if 60<=age<80 then agedis = 4;
if 80<=age then agedis = 5;
proc means data = homework4 mean;
class agedis sex;
var MED_DOT;
run;
