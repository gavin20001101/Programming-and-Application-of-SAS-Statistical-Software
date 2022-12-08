data temperature;
infile 'Z:\Downloads\範例資料04\Temperature.dat';
input city $ state $ / NormalHigh NormalLow / RecordHigh RecordLow;
run;
data temperature2;
infile 'Z:\Downloads\範例資料04\Temperature.dat';
input city $ state $ #2 NormalHigh NormalLow #3 RecordHigh RecordLow;
run;

data rain;
infile 'Z:\Downloads\範例資料04\Precipitation.dat';
input City $ State $ NormalRain MeanDaysRain @@;
run;

data freeways;
infile 'Z:\Downloads\範例資料04\Traffic.dat';
input type $ @; if type = 'surface' then delete;
input Name $ 9-38 AMTraffic PMTraffic;
run;
data surface;
infile 'Z:\Downloads\範例資料04\Traffic.dat';
input type $ Name $ 9-38 AMTraffic PMTraffic;
if type = 'surface' or PMTraffic > 2000;
run;
proc print data = surface;
run;

data icecreamsales;
infile 'Z:\Downloads\範例資料04\IceCreamSales.dat' firstobs = 3; 
input Flavor $ Location BoxedSales;
run;
data icecreamsales2;
infile 'Z:\Downloads\範例資料04\IceCreamSales2.dat' firstobs = 3 obs = 5; 
input Flavor $ Location BoxedSales;
run;

data class102;
infile 'Z:\Downloads\範例資料04\AllScores.dat' Missover;
input Name $ Test1 Test2 Test3 Test4 Test5;
run;

data HomeAddress;
infile 'Z:\Downloads\範例資料04\Address.dat'  truncover;
input Name $1-15 Number Street $22-37;
list;
run;

data Music;
infile 'Z:\Downloads\範例資料04\Bands.csv'  dlm = ',' dsd missover;
input BandName :$30. GigDate :MMDDYY10. EightPM NightPM TenPM ElevenPM;
list;
run;

data Music2;
infile 'Z:\Downloads\範例資料04\Bands.csv'  dlm = ',' dsd missover;
input BandName :$30. GigDate :MMDDYY10. EightPM NightPM TenPM ElevenPM;
if EightPM>40 and TenPM>50;
list;
run;
proc print data = music2;
format GigDate MMDDYY10.;
run;

data Music2;
infile 'Z:\Downloads\範例資料04\Bands.csv'  dlm = ',' dsd missover;
input BandName :$30. GigDate :MMDDYY10. EightPM NightPM TenPM ElevenPM;
if EightPM>40 or TenPM>50;
list;
run;

proc import datafile = 'Z:\Downloads\範例資料04\Bands2.csv' out = Band2 replace;
run;
