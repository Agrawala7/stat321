/* Project 1
Name: Anisha Agrawal
VNumber: V01022537
Date: February 14, 2025


/* Check values */
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

/* Check the frequency of  values for treatment*/
PROC FREQ DATA=impulsivity;
    TABLES Treatment / NOCUM NOPERCENT;
    TITLE 'Frequency of Treatment Values';
RUN;

/* Check the frequency of values for sex */
PROC FREQ DATA=impulsivity;
    TABLES Sex / NOCUM NOPERCENT;
    TITLE 'Frequency of Sex Values';
RUN;

/* Print observations to verify*/
PROC PRINT DATA=impulsivity (OBS=5);
    VAR SampleID Sex Treatment;
    TITLE 'First 5 Observations - Check Extraction';
RUN;
