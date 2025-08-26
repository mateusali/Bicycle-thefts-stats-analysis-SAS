/*
DATASET USED: Bicycle thefts
AUTHOR: Mateus August Ali Fonte
REASON: Projetc for Statistic class from Metro College of Technology
INSTRUCTOR: Maryam Kazemi
*/

libname Ali "D:\DSA - College\FDA";

proc import out = Ali.bicycle_thefts_2020_2024
	datafile = "D:\DSA - College\FDA\bicycle-thefts-2020-2024.csv"
	dbms = csv replace;
	getnames=yes;
	GuessingRows=1000;
RUN;


title;
title bold  font="Cambria" height=18 color=Black "Contents of my dataset";
proc contents data=Ali.bicycle_thefts_2020_2024;run;

data Clean_Bicycle_Thefts;
    set ALI.bicycle_thefts_2020_2024;
    if cmiss(of _all_) = 0; /* Keeps only rows with no missing values */
run;


/*Start Cleaning dataset*/

proc univariate data=Clean_Bicycle_Thefts noprint;
    var BIKE_COST; 
    output out=Outlier_Check pctlpts=25 75 pctlpre=Q;
run;

/* Extract bounds from the statistics dataset */
data _null_;
    set Outlier_Check;
    call symputx('lower_bound', Q25 - 1.5 * (Q75 - Q25));
    call symputx('upper_bound', Q75 + 1.5 * (Q75 - Q25));
run;

/* Filter out outliers */
data Ali.Final_Bicycle_Thefts;
    set Clean_Bicycle_Thefts;
    if &lower_bound. <= BIKE_COST <= &upper_bound.;
run;
/* End Cleaning dataset*/




/*Start all necessaries segmentations / descriptions data for analysis*/

proc format;

	value bikespeed
		low - 1 = 'No motorized'
		1-25 = '25 k/h max'
		26-50 = '50 k/h max'
		51 - high = '100 k/h max'
		;
	run;

proc format;

	value $bikedesc
		'BM'= 'BMX Bike       '	
		'EL'= 'Electric Bike' 
		'FO'= 'Folding Bike'	
		'MT'= 'Mountain Bike'	
		'OT'= 'Other	Bikes' 
		'RC'= 'Road Bike'	
		'RE'= 'Recumbent Bike'	
		'RG'= 'Regular/Hybrid'	
		'SC'= 'Scooter'
		'TA'= 'Tandem Bike'	
		'TO'= 'Touring Bike'	
		'TR'= 'Tricycle'	
		'UN'= 'Unknown'
		;
	run;

proc format;

	value bikecost
		low - 500 = 'Low than $500'
		500 - 1000 = 'between $500 and $1000'
		1000-2000 = 'between $1000 and $2000'
		2000-3000 = 'between $2000 and $3000'
		3000-4000 = 'between $3000 and $4000'
		4000-5000 = 'between $4000 and $5000'
		5000 - high = 'More than $5001'
		;
	run;

proc format;
	value dif_days
		low - 5 = '5 Days'
		6 - 10 = '10 Days'
		11-20 = '20 Days'
		21-30 = '30 Days'
		31-40 = '40 Days'
		41-50 = '50 Days'
		51 - high = 'More 50 Days'
		;
run;

proc format;
	value hourperiods
	0-6   =	'Night'
	7-12  =	'Morning'
	13-18 =	'Afternoon'
	19-23 =	'Evening'
	;
run;

proc format;
	value $season
	'March', 'April', 'May'   =	'Spring'
	'June', 'July', 'August'   =	'Summer'
	'September', 'October', 'November' =	'Fall'
	'December', 'January', 'February' =	'Winter'
	;
run;

proc format;
	value $wkdays
	'Monday', 'Tuesday', 'Wednesday', 'Thursday','Friday'   =	'Week Day'
	'Saturday', 'Sunday'  =	'Weekend'
	;
run;

proc format;
	value reportdays
	low -14  	=	'On time report'
	15 - high  =	'Late report'
	;
run;
/*Start all necessaries segmentations / descriptions data for analysis*/


/******************************************************************************************************************************/
/******************************************************************************************************************************/
/***************************************************10 UNIVARIATY ANALYSIS*****************************************************/
/******************************************************************************************************************************/
/******************************************************************************************************************************/


/*Q1 - How many bicyles was thetf by year? 
To answer this questions we need use the statment PROC FREQ to check the frequencie and calculate percentage of 
how many bicyles was thetf by year.
*/

/*(Univariate) - Qualitative
CATEGORICAL VARIABLE : OCC_YEAR
VISUALIZATION: BOX PLOT - VBAR 
ANALYSIS: FREQ 
*/

title1; title2; title3;
title1 bold  font="Cambria" height=18pt color=Black "Univariate - Qualitative";
title2 bold  font="Cambria" height=14pt color=Blue "Variable:OCC_YEAR (Year Offence Occurred)";
title3 bold  font="Cambria" height=12pt color=Red "Q1 - How many bicyles was thetf by year";
proc freq data=Ali.Final_Bicycle_Thefts;
table OCC_YEAR / NOROW NOCOL;
run;

title1; title2; title3;
*Graphic for frequence by year;
proc sgplot data=Ali.Final_Bicycle_Thefts;
   vbar OCC_YEAR; 
run;

/******************************************************************************************************************************/

/*Q2 - How many bicyles was thetf by month ? 
To answer this questions we need use the statment PROC FREQ to check the frequencie and calculate percentage of 
how many bicyles was thetf by month for the las 4 year (2020 to 2024).
*/

/*(Univariate) - Qualitative
CATEGORICAL VARIABLE : OCC_MONTH
VISUALIZATION: BOX PLOT - VBAR 
ANALYSIS: FREQ 
*/

title1; title2; title3;
title1 bold  font="Cambria" height=18pt color=Black "Univariate - Qualitative";
title2 bold  font="Cambria" height=14pt color=Blue "Variable:OCC_MONTH (Month Offence Occurred)";
title3 bold  font="Cambria" height=12pt color=Red "Q2 - How many bicyles was thetf by month ? ";
proc freq data=Ali.Final_Bicycle_Thefts;
table OCC_MONTH / NOROW NOCOL;
run;

title1; title2; title3;
*Graphic for frequence by year;
proc sgplot data=Ali.Final_Bicycle_Thefts;
   vbar OCC_MONTH;
run;
title2 bold  font="Cambria" height=14pt color=Blue "Graphic with agregation by season of year. to determine what season bicycles is more theft.";
proc gchart data=Ali.Final_Bicycle_Thefts;
format OCC_MONTH $season.;
pie OCC_MONTH;
run; 

/******************************************************************************************************************************/
/*"Q3 - During which period of the day are bicycles most frequently stolen? 
To answer this questions we need use the statment PROC FREQ to check the frequencie and calculate percentage of 
how many bicyles was thetf in specifically hour of the day, also we need do some agregation. Check proc fomart hourperiods.
*/

/*(Univariate) - Qualitative
CATEGORICAL VARIABLE : OCC_HOUR
VISUALIZATION: BOX PLOT - VBAR 
ANALYSIS: FREQ 
*/

title1; title2; title3;
title1 bold  font="Cambria" height=18pt color=Black "Univariate - Qualitative";
title2 bold  font="Cambria" height=14pt color=Blue "Variable:OCC_HOUR (Hour Offence Occurred)";
title3 bold  font="Cambria" height=12pt color=Red "Q3 - During which period of the day are bicycles most frequently stolen?";
proc freq data=Ali.Final_Bicycle_Thefts;
format occ_hour hourperiods.;
table OCC_HOUR / NOROW NOCOL;
run;

title1; title2; title3;
*Graphic for frequence by year;
proc sgplot data=Ali.Final_Bicycle_Thefts;
	format occ_hour hourperiods.;
	vbar OCC_HOUR; 
run;


/******************************************************************************************************************************/
/*Q4 - On which day of the week are bicycles most frequently theft?
To answer this questions we need use the statment PROC FREQ to check the frequencie and calculate percentage of 
how many bicyles was thetf in specifically day of week.
*/

/*(Univariate) - Qualitative
CATEGORICAL VARIABLE : OCC_DOW
VISUALIZATION: BOX PLOT - VBAR 
ANALYSIS: FREQ 
*/

title1; title2; title3;
title1 bold  font="Cambria" height=18pt color=Black "Univariate - Qualitative";
title2 bold  font="Cambria" height=14pt color=Blue "Variable:OCC_DOW (Day of week the offence occurred)";
title3 bold  font="Cambria" height=12pt color=Red "*Q4 - On which day of the week are bicycles most frequently theft?";
proc freq data=Ali.Final_Bicycle_Thefts;
*format OCC_DOW $wkdays.; 
table OCC_DOW / NOROW NOCOL;
run;

title1; title2; title3;
*Graphic for frequence by year;
proc sgplot data=Ali.Final_Bicycle_Thefts;
	vbar OCC_DOW; 
run;


/******************************************************************************************************************************/
/*Q5 - Whats type of bike is usually is more theft?*/

/*(Univariate) - Qualitative
Categoric- VARIABLE : BIKE_TYPE 
VISUALIZATION: BAR - VBAR
ANALYSIS: FREQ 
*/
title1; title2; title3;
title1 bold  font="Cambria" height=18pt color=Black "Univariate - Qualitative";
title2 bold  font="Cambria" height=14pt color=Blue "Variable:BIKE_TYPE (Type of Bicycle)";
title3 bold  font="Cambria" height=12pt color=Red "*Q5 - Whats type of bike is usually is more theft? ";
proc freq data=Ali.Final_Bicycle_Thefts;
format bike_type $bikedesc.;
table BIKE_TYPE;
run;

*Graphic;	
title;
proc sgplot data=Ali.Final_Bicycle_Thefts;
format bike_type $bikedesc.;
vbar BIKE_TYPE;
run; 

/******************************************************************************************************************************/

/*"Q6 - What types of premises are bicycles most frequently stolen from?
To answer this questions we need use the statment PROC FREQ to check the frequencie and calculate percentage of 
how many bicycle was thetf by premises type (apartment, house, ect).
*/

/*(Univariate) - Qualitative
CATEGORICAL VARIABLE : PREMISES_TYPE
VISUALIZATION: BOX PLOT - VBAR 
ANALYSIS: FREQ 
*/

title1; title2; title3;
title1 bold  font="Cambria" height=18pt color=Black "Univariate - Qualitative";
title2 bold  font="Cambria" height=14pt color=Blue "Variable:PREMISES_TYPE (Premises Type of Offence)";
title3 bold  font="Cambria" height=12pt color=Red "Q6 - What types of premises are bicycles most frequently stolen from? ";
proc freq data=Ali.bicycle_thefts_2020_2024;
table PREMISES_TYPE / NOROW NOCOL;
run;

title1; title2; title3;
*Graphic for frequence by year;
proc sgplot data=Ali.Final_Bicycle_Thefts;
	vbar PREMISES_TYPE; 
run;


/******************************************************************************************************************************/

/*Q7 - What is the average price of a theft bicycle?*/

/*(Univariate) - Quantitative
NUMERICAL- VARIABLE : BIKE_COST (CONTINOUS)
VISUALIZATION: BOX PLOT - HBOX
ANALYSIS: UNIVARIATE 
*/
title1; title2; title3;
title1 bold  font="Cambria" height=18pt color=Black "Univariate - Quantitative";
title2 bold  font="Cambria" height=14pt color=Blue "Variable:BIKE_COST (Cost of Bicycle)";
title3 bold  font="Cambria" height=12pt color=Red "Q7 - What is the average price of a theft bicycle? ";
/*proc means data=Ali.bicycle_thefts_2020_2024;
var BIKE_COST;
run;
quit;*/

proc univariate data=Ali.Final_Bicycle_Thefts;
var BIKE_COST;
run;
quit;

*Graphic for central tendency;
title;
proc sgplot data=Ali.Final_Bicycle_Thefts;
where BIKE_COST < 10000; *< 10000; *This column have some outlires that I think was insert with wrong values by police;
hbox BIKE_COST;
run; 

/******************************************************************************************************************************/

/*Q8 - What's the avarage of speed max of bycicles theft*/

/*(Univariate) - Quantitative
NUMERICAL- VARIABLE : BIKE_SPEED (CONTINOUS)
VISUALIZATION: BOX PLOT - HBOX
ANALYSIS: MEANS 
*/
title1; title2; title3;
title1 bold  font="Cambria" height=18pt color=Black "Univariate - Quantitative";
title2 bold  font="Cambria" height=14pt color=Blue "Variable:BIKE_SPEED (Speed max of Bicycle)";
title3 bold  font="Cambria" height=12pt color=Red "*Q8 - What's the avarage of speed max of bycicles theft?  ";
proc means data=Ali.Final_Bicycle_Thefts;
var BIKE_SPEED;
run;
quit;
*Graphic for central tendency;
title;
proc sgplot data=Ali.Final_Bicycle_Thefts;
hbox BIKE_SPEED;
run; 

/******************************************************************************************************************************/

/*Q9 - How many bicyles was recovered ? 
To answer this questions we need use the statment PROC FREQ to check the frequencie and calculate percentage of 
how many bicyles was thetf by year.
*/

/*(Univariate) - Qualitative
CATEGORICAL VARIABLE : OCC_YEAR
VISUALIZATION: BOX PLOT - VBAR 
ANALYSIS: FREQ 
*/

title1; title2; title3;
title1 bold  font="Cambria" height=18pt color=Black "Univariate - Qualitative";
title2 bold  font="Cambria" height=14pt color=Blue "Variable:STATUS (Status of Bicycle)";
title3 bold  font="Cambria" height=12pt color=Red "Q9 - How many bicyles was recovered ? ";
proc freq data=Ali.Final_Bicycle_Thefts;
table STATUS / NOROW NOCOL;
run;

title1; title2; title3;
*Graphic for frequence by year;
proc gchart data=Ali.Final_Bicycle_Thefts;
   pie STATUS;  /* Adds arrows pointing to slices for clarity */
run;


/******************************************************************************************************************************/

/*Q10 - How many days, on average, pass between the date a bicycle is stolen and the date the theft is reported?*/ *(Univariate) Qualitative*/

/*(Univariate) - Qualitative
Categoric- VARIABLE : NDAYS 
VISUALIZATION: BAR - VBAR
ANALYSIS: FREQ 
*/

*Create a new column in a temporary dataset to save the difference between dates; 
data Ali.time_to_report;
set Ali.Final_Bicycle_Thefts;
IF OCC_YEAR = REPORT_YEAR THEN DO;
NDAYS=INTCK("DAY",OCC_DATE,REPORT_DATE);
END;
run;
title1; title2; title3;
title1 bold  font="Cambria" height=18pt color=Black "Univariate - Qualitative";
title2 bold  font="Cambria" height=14pt color=Blue "Variable:STATUS (Status of Bicycle)";
title3 bold  font="Cambria" height=12pt color=Red "Q10 - How many days, on average, pass between the date a bicycle is stolen and the date the theft is reported? ";
proc freq data=Ali.time_to_report;
format NDAYS dif_days.;
table NDAYS / missing;
run;

*Graphic;
title;
proc sgplot data=Ali.time_to_report;
format NDAYS dif_days.;
vbar NDAYS / missing;
run; 

/******************************************************************************************************************************/
/***************************************************x BIVARIATE ANALYSIS*******************************************************/
/******************************************************************************************************************************/


/******************************************************CONTIGENCE TABLE********************************************************/

/*Q1 - What has been the growth in e-bike thefts from 2020 to 2024? */ *(Univariate) - Qualitative ;

/*(Bivariate) - Qualitative vs Quanlitative - Produces a contingency table
Categoric- VARIABLE : BIKE_TYPE * REPORT_YEAR
VISUALIZATION: VBAR
TEST OF INDEPENDENCY: CONTIGENCE TABLE
*/
title1; title2; title3;
title1 bold  font="Cambria" height=18pt color=Black "Bivariate - CONTIGENCE TABLE";
title2 bold  font="Cambria" height=14pt color=Blue "Variables: BIKE_TYPE * REPORT_YEAR";
title3 bold  font="Cambria" height=12pt color=Red "Q1 - What has been the growth in e-bike thefts from 2020 to 2024/09? ";
*To achieve more precise analysis, I added a condition to exclude some months since the dataset for 2024 is not yet complete.;
proc freq data=Ali.Final_Bicycle_Thefts;
table BIKE_TYPE * REPORT_YEAR / NOROW NOCOL out=Freq_Out ;
WHERE BIKE_TYPE = 'EL' and OCC_MONTH not in ('October', 'November', 'December');
run;
*Graphic;
title;
proc sgplot data=Freq_Out;
   vbar REPORT_YEAR / response=COUNT;
   xaxis label="Year";
   yaxis label="Number of E-Bike Thefts";
run;


/******************************************************************************************************************************/

/*Q2 -The day of the week is affected the cost of bike was theft  ? */ 
/*BIVARIATE 
CATEGORICAL VARIABLE : occ_dow
CATEGORICAL VARIABLE : bike_cost (after format)
VISUALIZATION: CLUSTERED BAR
TEST OF INDEPENDENCY : CONTIGENCE TABLE
*/

title1; title2; title3;
title1 bold  font="Cambria" height=18pt color=Black "Bivariate - CONTIGENCE TABLE";
title2 bold  font="Cambria" height=14pt color=Blue "Variables: OCC_DOW * BIKE_COST";
title3 bold  font="Cambria" height=12pt color=Red "Q2 -The day of the week is affected the cost of bike was theft  ? ";

proc freq data=Ali.Final_Bicycle_Thefts;
format bike_cost bikecost.;
table OCC_DOW * BIKE_COST / chisq norow nocol;
run;

*Graphic;
/*proc sgplot data=Ali.bicycle_thefts_2020_2024;
vbar occ_dow ;
run; */
title;
proc SGPLOT data=Ali.Final_Bicycle_Thefts;
format bike_cost bikecost.;
vbar occ_dow/group=bike_cost groupdisplay = cluster;
run;

/********************************************************* CHI SQUARE ***********************************************************/

/*Q3 -: Is the period of day affect the bike cost was theft ? 

/*BIVARIATE  
CATEGORICAL VARIABLE : BIKE_COST (after format)
CATEGORICAL VARIABLE : OCC_HOUR (after format)
VISUALIZATION: CLUSTERED BAR
TEST OF INDEPENDENCY : CHI SQUARE
*/
title1; title2; title3;
title1 bold  font="Cambria" height=18pt color=Black "Bivariate - CHI SQUARE";
title2 bold  font="Cambria" height=14pt color=Blue "Variables: OCC_HOUR * BIKE_COST ";
title3 bold  font="Cambria" height=12pt color=Red "Q3 - Is the period of day affect the bike cost was theft ?   ";

proc freq data=Ali.Final_Bicycle_Thefts;
format bike_cost bikecost. OCC_HOUR hourperiods.;
table OCC_HOUR * BIKE_COST / chisq norow nocol;
run;

title;
proc SGPLOT data=Ali.Final_Bicycle_Thefts;
format bike_cost bikecost. OCC_HOUR hourperiods.;
vbar OCC_HOUR/group=bike_cost groupdisplay = cluster;
run;

/**********************************************************************************************************************************/

/*Q4 - Is any relatioshinp between premises where bike wa theft and season of year?*/

/*BIVARIATE 
CATEGORICAL VARIABLE : premises_TYPE
CATEGORICAL VARIABLE : OCC_MONTH 
VISUALIZATION: BAR VBAR
TEST OF INDEPENDENCY : CHI SQUARE
*/
title1; title2; title3;
title1 bold  font="Cambria" height=18pt color=Black "Bivariate - CHI SQUARE";
title2 bold  font="Cambria" height=14pt color=Blue "Variables:PREMISES_TYPE*OCC_MONTH";
title3 bold  font="Cambria" height=12pt color=Red "Q4 - Is any relatioshinp between premises where bike wa theft and season of year? ";

proc freq data=Ali.Final_Bicycle_Thefts;
format  OCC_MONTH $season.;
table PREMISES_TYPE*OCC_MONTH/ chisq norow nocol;
run;
title;
proc SGPLOT data=Ali.Final_Bicycle_Thefts;
format  OCC_MONTH $season.;
vbar OCC_MONTH/group=premises_TYPE groupdisplay = cluster;
run;


/********************************************************* CORRELATION ***********************************************************/
/*Q5 - Is any correlation between speed max of bike and cost?*/

/*BIVARIATE 
CONTINUOUS VARIABLE : bike_cost
CONTINUOUS VARIABLE : bike_speed 
VISUALIZATION: SCATTER PLOT MATRIX 
TEST OF INDEPENDENCY : CORRELATION (PROC CORR)
*/
title1; title2; title3;
title1 bold  font="Cambria" hseight=18pt color=Black "Bivariate - CORRELATION";
title2 bold  font="Cambria" height=14pt color=Blue "Variable:BIKE_SPEED VS BIKE_COST";
title3 bold  font="Cambria" height=12pt color=Red "Q5 - Is any correlation between speed max of bike and cost? ";

proc corr data=Ali.Final_Bicycle_Thefts PLOTS(MAXPOINTS=100000)=MATRIX(HISTOGRAM);
format bike_cost bikecost. bike_speed bikespeed. ; 
var BIKE_SPEED BIKE_COST;
run;

/********************************************************* T-TEST ***********************************************************/

/*Q6 - Any relationship between the avarage of bike cost and week days and weekend?*/

/*BIVARIATE 
CONTINOUS VARIABLE : BIKE_COST (Dependent)
CATEGORICAL VARIABLE : OCC_DOW (Indepentent)
TEST OF INDEPENDENCY : T-TEST
*/

title1; title2; title3;
title1 bold  font="Cambria" height=18pt color=Black "Bivariate - T-TEST";
title2 bold  font="Cambria" height=14pt color=Blue "Variable:BIKE_COST VS OCC_DOW";
title3 bold  font="Cambria" height=12pt color=Red "Q6 - Any relationship between the avarage of bike cost and week days and weekend? ";


proc ttest data=Ali.Final_Bicycle_Thefts;
format OCC_DOW $wkdays.; 
class  OCC_DOW;
var BIKE_COST;
run;

/*Q7 - Can we say that the price of the bike changes if the speed changes as well?*/
/*BIVARIATE 
CONTINOUS VARIABLE : BIKE_COST (Dependent)
CATEGORICAL VARIABLE : BIKE_SPEED (Indepentent)
TEST OF INDEPENDENCY : ANOVA
*/
title1; title2; title3;
title1 bold  font="Cambria" height=18pt color=Black "Bivariate - ANOVA";
title2 bold  font="Cambria" height=14pt color=Blue "Variable:BIKE_COST = BIKE_SPEED";
title3 bold  font="Cambria" height=12pt color=Red "Can we say that the price of the bike changes if the speed changes as well? ";


proc anova data=Ali.Final_Bicycle_Thefts PLOTS(MAXPOINTS=100000);
format BIKE_SPEED bikespeed. ;
class BIKE_SPEED;
model BIKE_COST = BIKE_SPEED;
run;
