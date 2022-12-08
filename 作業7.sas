/*第一題*/
data h; set sasuser.H_nhi_ipdte96;
length check $10;
keep fee_ym ICD9CM_1-ICD9CM_5 check check2 MED_DOT ID IN_DATE;
array icd9cm (5) ICD9CM_1-ICD9CM_5;
do i=1 to 5;
	/*高血壓*/
	do j=401 to 405;
		if icd9cm(i) = j and check = Missing THEN check='hbp';
		else if icd9cm(i) = j and check = 'sick' THEN check='hbp & sick';
	end;
	/*感冒*/
	do g=460 to 466;
		if icd9cm(i) = g and check = Missing then check = 'sick';
		else if icd9cm(i) = g and check = 'hbp' then check = 'hbp & sick';
	end;
end;
if check = Missing or check = 'hbp & sick' then delete;
RUN;
/* 檢查是否常態分佈 */
proc univariate data = h normal;
var MED_DOT;
run; 
proc npar1way data = h wilcoxon;
class check;
var MED_DOT;
run;
/*第二題*/
proc sort data = sasuser.H_nhi_ipdte96exam.H2_1;
by ID;
data h2_2; set sasuser.H_nhi_ipdte96;
array icd9 (5) ICD9CM_1-ICD9CM_5;
do f=1 to 5;
	if icd9(f) = 250 then diabetes = 1;
end;
if diabetes ^= 1 then delete;
keep ID count MED_DOT ICD9CM_1-ICD9CM_5 diabetes;
proc print;
run;
data h2_3; set h2_2;
by ID;
if first.id then count=0;
count+1;
run;
data h2_4; set h2_3;
if count<3 then delete;
by ID;
if last.id;
run;

/*第三題*/
proc sort data=H;
by ID;
proc sort data=H2_4;
by ID;
data H3;
merge H H2_4;
by ID;
run;
data h3_1; set H3;
if diabetes ^= 1 then delete;
if check = Missing then delete;
drop Missing;
run;
proc univariate data = h3_1 normal;
var MED_DOT;
run; 
proc npar1way data = h3_1 wilcoxon;
class check;
var MED_DOT;
run;