/*
Project 2
Name: Anisha Agrawal
VNumber: V01022537
Date: February 16, 2025
*/


/*create variables */
DATA impulsivity;
    LENGTH Site $1 Sex $1 Treatment $1;
    INPUT SampleID $ Age Score1 Score2 Score3;
    Site = SUBSTR(SampleID,1,1);
    Sex = SUBSTR(SampleID,7,1);
    Treatment = SUBSTR(SampleID,8,1);

    /* labels */
    LABEL Sex='Gender (M/F)'
          Treatment='Treatment (P=Placebo, Z=Zynipheron)';
DATALINES;
M100051MZ 35 28 27 23
M100055FP 44 34 35 33
M100057MP 48 31 32 29
M100079FZ 42 25 27 24
R100059FP 21 34 33 32
R100064FZ 38 28 26 24
C100074FZ 32 27 23 22
C100089MP 26 34 30 33
M100094MP 29 31 32 32
M100097FZ 41 27 25 27
M100106MZ 26 24 25 29
R100111FZ 48 28 26 27
R100112MZ 46 25 24 26
M100114MZ 41 25 27 27
C100175FP 45 35 31 30
C100182FP 22 31 30 29
C100188MZ 47 30 25 26
C100198MZ 42 24 25 22
C100209MP 49 31 33 30
C100247FZ 26 27 28 26
R100264FZ 28 26 25 22
R100279FZ 43 24 24 25
R100345MP 44 26 30 30
R100429MZ 50 23 27 21
C100477FP 27 31 30 33
;
RUN;

/*Verify Class Variable Values */
PROC FREQ DATA=impulsivity;
   TABLES Treatment Sex;
RUN;

/* dataset for Zynipheron treatment group */
DATA Zynipheron;
  SET impulsivity;
  WHERE Treatment = 'Z';
RUN;

/* dataset for Placebo treatment group */
DATA Placebo;
  SET impulsivity;
  WHERE Treatment = 'P';
RUN;

/* dataset for Males */
DATA Males;
  SET impulsivity;
  WHERE Sex = 'M';
RUN;

/* dataset for Females */
DATA Females;
  SET impulsivity;
  WHERE Sex = 'F';
/* 4. Basic Summaries of Impulsivity Variables for Each Dataset */
/*Original Dataset (impulsivity) */
PROC MEANS DATA=impulsivity;
  VAR Score1 Score2 Score3;
  TITLE "Impulsivity - Original Data";
RUN;

/*  Zynipheron Dataset */
PROC MEANS DATA=Zynipheron;
  VAR Score1 Score2 Score3;
  TITLE "Impulsivity - Zynipheron Group";
RUN;

/* Placebo Dataset */
PROC MEANS DATA=Placebo;
  VAR Score1 Score2 Score3;
  TITLE "Impulsivity - Placebo Group";
RUN;
/* Males Dataset  */
PROC MEANS DATA=Males;
  VAR Score1 Score2 Score3;
  TITLE "Impulsivity - Males";
RUN;

/*  Females Dataset  */
PROC MEANS DATA=Females;
  VAR Score1 Score2 Score3;
  TITLE "Impulsivity - Females";
RUN;
/* 5. T-Tests: Treatment vs. Placebo (alpha = 0.035) */
/* Null Hypothesis: There is no significant difference in mean Score1 between Treatment and Placebo groups. */
PROC TTEST DATA=impulsivity ALPHA=0.035;
  CLASS Treatment;
  VAR Score1;
  TITLE "T-Test: Score1 - Treatment vs. Placebo";
RUN;
/* Reject the null hypothesis if p-value <= 0.035. */
/* Based on the T-Test output:
T-Statistic: 0.92
Degrees of Freedom: 23
P-Value: 0.3681
Conclusion: Fail to Reject the null hypothesis. */
/* --- Score2: Treatment vs. Placebo --- */
/* Null Hypothesis: There is no significant difference in mean Score2 between Treatment and Placebo groups. */

PROC TTEST DATA=impulsivity ALPHA=0.035;
  CLASS Treatment;
  VAR Score2;
  TITLE "T-Test: Score2 - Treatment vs. Placebo";
RUN;
/* Decision Rule: Reject the null hypothesis if p-value <= 0.035. */
/* Based on the T-Test output:
T-Statistic: -0.12
Degrees of Freedom: 23
P-Value: 0.9080
Conclusion: Fail to Reject the null hypothesis. */

/* --- Score3: Treatment vs. Placebo --- */
/* Null Hypothesis: There is no difference in mean Score3 between Treatment and Placebo groups. */
/* Alternative Hypothesis: There is a difference in mean Score3 between Treatment and Placebo groups. */
PROC TTEST DATA=impulsivity ALPHA=0.035;
  CLASS Treatment;
  VAR Score3;
  TITLE "T-Test: Score3 - Treatment vs. Placebo";
RUN;
/* Decision Rule: Reject the null hypothesis if p-value <= 0.035. */
/* Based on the T-Test output:
T-Statistic: -0.07
Degrees of Freedom: 23
P-Value: 0.9480
Conclusion: Fail to Reject the null hypothesis. */


/* 6. T-Tests: Gender Differences (alpha = 0.045) */


/* Score1: Gender Differences  */
/* Null Hypothesis: There is no significant difference in mean Score1 between Males and Females. */

PROC TTEST DATA=impulsivity ALPHA=0.045;
  CLASS Sex;
  VAR Score1;
  TITLE "T-Test: Score1 - Gender Differences";
RUN;
/* Decision Rule: Reject the null hypothesis if p-value <= 0.045. */
/* Based on the T-Test output:
T-Statistic: 39.21779
Degrees of Freedom: 23
P-Value: <0.001
Conclusion: Reject the null hypothesis. */

/*  Score2: Gender Differences */
/* Null Hypothesis: There is no significant difference in mean Score2 between Males and Females. */

PROC TTEST DATA=impulsivity ALPHA=0.045;
  CLASS Sex;
  VAR Score2;
  TITLE "T-Test: Score2 - Gender Differences";
RUN;
/* Decision Rule: Reject the null hypothesis if p-value <= 0.045. */
/* Based on the T-Test output:
T-Statistic: 41.73994
Degrees of Freedom: 12.5
P-Value: <0.001
Conclusion: Reject the null hypothesis. */

/* Score3: Gender Differences */
/* Null Hypothesis: There is no difference in mean Score3 between Males and Females. */

PROC TTEST DATA=impulsivity ALPHA=0.045;
  CLASS Sex;
  VAR Score3;
  TITLE "T-Test: Score3 - Gender Differences";
RUN;
/* Decision Rule: Reject the null hypothesis if p-value <= 0.045. */
/* Based on the T-Test output:
T-Statistic: 35.8699
P-Value: <0.001
Conclusion: Reject the null hypothesis. */


/* 7. Check Assumptions and comment*/


/* Testing Normality Assumption */
/* H0: Data is normally distributed
   Ha: Data is not normally distributed
   Alpha = 0.05 */
/* Shapiro-Wilk Test for normality. If p < 0.05, reject null and conclude data is not normally distributed */
PROC UNIVARIATE DATA = impulsivity NORMAL;
  VAR Score1 Score2 Score3;
RUN;

/*Evaluate Normality*/
/*The shapiro-wilk test p values are all above 0.05 therefore we fail to reject the null hypthesis and state that each distribution is normal. If this were not true, transformations could be performed on the data or non-parametric tests could be conducted. */
/* Evaluate equal variances assumption for the TTests - look at the output from the TTEST procedure. */
/*Fill in Equal Variances Assumption*/
/*  Score 1: Equal */
/*  Score 2: Equal */
/*  Score 3: Not Equal*/
