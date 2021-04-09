##PrEP Costing DA analysis
##Written by Mariet Benade
##Created 2021 January 29
## Last updated 2021 March 25

library(data.table)
library(dplyr)
library(table1)
library(openxlsx)
##Set working directory##
prep<-"/Users/marietbenade/Downloads"
setwd(prep)
#read in dataset
data<-read.csv('PrEPCostingSouthAfri_DATA_2021-03-25_2121.csv', header = TRUE)
#Load Hmisc library
library(Hmisc)
library(janitor)
library(tidyr)
####Setting Labels####
label(data$record_id)="Record ID"
label(data$redcap_repeat_instrument)="Repeat Instrument"
label(data$redcap_repeat_instance)="Repeat Instance"
label(data$redcap_survey_identifier)="Survey Identifier"
label(data$demographics_timestamp)="Survey Timestamp"
label(data$study_id)="Study ID"
label(data$birth_year)="Year of birth"
label(data$sex)="Sex"
label(data$test_hiv1)="Date of HIV test used for PrEP eligibility"
label(data$bl_ra_check)="Was a risk assessment documented at baseline?"
label(data$prep_reason)="Indication for PrEP"
label(data$risk_check)="Youve indicated that no risk assessment was done, but selected risk assessment by health care provider as an indication for PrEP. Was risk assessment done?"
label(data$risk_group)="Which risk group does client fall into?"
label(data$risk_group_other)="Other risk groups"
label(data$date_prep_offer)="Date of eligibility or offer of PrEP"
as.Date(data$date_prep_offer)
label(data$prep_start_dt)="Date of PrEP initiation"
as.Date(data$prep_start_dt)
label(data$prep_regimen)="PrEP regimen prescribed"
label(data$prep_regimen_other)="Please specify which PrEP regimen was prescribed if not listed above. "
label(data$demographics_complete)="Complete?"
label(data$baseline_prep_tests_results_timestamp)="Survey Timestamp"
label(data$check_tool)="Were these tests all conducted prior to visit 1?"
label(data$bl_test_date)="Date of baseline tests"
as.Date(data$bl_test_date)
label(data$bl_hiv_elisa)="HIV test at baseline"
label(data$renal_fx)="Renal function completed?"
label(data$bl_rfx)="Renal function - Creatinine Clearance"
label(data$fu_crcl)="Follow-up on abnormal creatinine clearance. "
label(data$bl_hepbsag)="Hepatitis B surface antigen (HBsAg)"
label(data$bl_hepbsab)="Hepatitis B Antibody to surface antigen (HBsAb)"
label(data$bl_syphillis)="Syphilis rapid test"
label(data$bl_rapid_preg)="Pregnancy test"
label(data$pregnant_course)="Did patient continue with PrEP initiation? "
label(data$ast_check)="Was an AST blood test done?"
label(data$bl_ast)="AST"
label(data$alt_test)="Was an ALT blood test done?"
label(data$bl_alt)="ALT"
label(data$baseline_prep_tests_results_complete)="Complete?"
label(data$visit_timestamp)="Survey Timestamp"
label(data$visit_date)="Date of client visit"
as.Date(data$visit_date)
label(data$visit_class)="Visit classification"
label(data$visit_reason)="Primary reason for visit"
label(data$visit_reason_other)="Please provide primary reason for this visit"
label(data$provider_seen___1)="Type of professionals seen (choice=Pharmacist)"
label(data$provider_seen___2)="Type of professionals seen (choice=Nurse)"
label(data$provider_seen___3)="Type of professionals seen (choice=Doctor)"
label(data$provider_seen___4)="Type of professionals seen (choice=Technician)"
label(data$provider_seen___5)="Type of professionals seen (choice=Counselor)"
label(data$provider_seen___6)="Type of professionals seen (choice=Other)"
label(data$other_hcp)="List other health professionals seen during this visit"
label(data$visit_ra)="Was risk assessment documented for this visit?"
label(data$risk_assess_q___1)="Risk assessment questions. In the last 6 months, does participant report... (choice=Having sex with men, women or both)"
label(data$risk_assess_q___2)="Risk assessment questions. In the last 6 months, does participant report... (choice=Multiple sexual partners)"
label(data$risk_assess_q___3)="Risk assessment questions. In the last 6 months, does participant report... (choice=Having sex without a condom?)"
label(data$risk_assess_q___4)="Risk assessment questions. In the last 6 months, does participant report... (choice=Having partners that were HIV-positive or of unknown HIV status?)"
label(data$risk_assess_q___5)="Risk assessment questions. In the last 6 months, does participant report... (choice=Having sex with positive/unknown status partners without wearing a condom?)"
label(data$risk_assess_score)="Risk assessment score"
label(data$lab_tests___1)="Lab tests conducted during this visit  (choice=HIV rapid test)"
label(data$lab_tests___2)="Lab tests conducted during this visit  (choice=HIV ELISA)"
label(data$lab_tests___3)="Lab tests conducted during this visit  (choice=Renal Function)"
label(data$lab_tests___4)="Lab tests conducted during this visit  (choice=Hepatitis B surface antigen (HBsAg))"
label(data$lab_tests___5)="Lab tests conducted during this visit  (choice=Hepatitis B Antibody to surface antigen (HBsAb))"
label(data$lab_tests___6)="Lab tests conducted during this visit  (choice=Urine dipstix)"
label(data$lab_tests___7)="Lab tests conducted during this visit  (choice=Syphilis rapid test (RPR))"
label(data$lab_tests___8)="Lab tests conducted during this visit  (choice=Syphilis serology (TPHA))"
label(data$lab_tests___9)="Lab tests conducted during this visit  (choice=Rapid Pregnancy test)"
label(data$lab_tests___10)="Lab tests conducted during this visit  (choice=Beta HCG test (blood test for pregnancy))"
label(data$lab_tests___11)="Lab tests conducted during this visit  (choice=AST)"
label(data$lab_tests___12)="Lab tests conducted during this visit  (choice=ALT)"
label(data$lab_tests___15)="Lab tests conducted during this visit  (choice=Hb (Haemoglobin))"
label(data$lab_tests___13)="Lab tests conducted during this visit  (choice=Other)"
label(data$lab_tests___14)="Lab tests conducted during this visit  (choice=None)"
label(data$tests_other)="Please state which other lab tests were ordered during this visit. "
label(data$procedures_visit___1)="Other procedures performed during this visit (choice=Chest X-ray)"
label(data$procedures_visit___2)="Other procedures performed during this visit (choice=ECG)"
label(data$procedures_visit___4)="Other procedures performed during this visit (choice=Referral)"
label(data$procedures_visit___5)="Other procedures performed during this visit (choice=Abdominal Xray)"
label(data$procedures_visit___7)="Other procedures performed during this visit (choice=Weight)"
label(data$procedures_visit___8)="Other procedures performed during this visit (choice=Waist circumference)"
label(data$procedures_visit___9)="Other procedures performed during this visit (choice=Counseling)"
label(data$procedures_visit___10)="Other procedures performed during this visit (choice=Other)"
label(data$procedures_visit___6)="Other procedures performed during this visit (choice=None)"
label(data$procedure_other)="Please state which other procedures were performed during this visit. "
label(data$new_diag___1)="Conditions diagnosed at this visit (choice=HIV seroconversion)"
label(data$new_diag___2)="Conditions diagnosed at this visit (choice=Renal Failure)"
label(data$new_diag___3)="Conditions diagnosed at this visit (choice=Syphilis)"
label(data$new_diag___4)="Conditions diagnosed at this visit (choice=Hepatitis B)"
label(data$new_diag___5)="Conditions diagnosed at this visit (choice=Pregnancy)"
label(data$new_diag___6)="Conditions diagnosed at this visit (choice=Hypertension)"
label(data$new_diag___7)="Conditions diagnosed at this visit (choice=Diabetes)"
label(data$new_diag___8)="Conditions diagnosed at this visit (choice=Dyslipidemia)"
label(data$new_diag___9)="Conditions diagnosed at this visit (choice=Upper respiratory tract infection)"
label(data$new_diag___13)="Conditions diagnosed at this visit (choice=Genital Ulcer Syndrome)"
label(data$new_diag___14)="Conditions diagnosed at this visit (choice=Urethritis)"
label(data$new_diag___15)="Conditions diagnosed at this visit (choice=Vaginal Discharge)"
label(data$new_diag___10)="Conditions diagnosed at this visit (choice=Trauma)"
label(data$new_diag___11)="Conditions diagnosed at this visit (choice=Other)"
label(data$new_diag___12)="Conditions diagnosed at this visit (choice=None)"
label(data$prep_meds___1)="PrEP-related medications prescribed (choice=TDF/FTC)"
label(data$prep_meds___2)="PrEP-related medications prescribed (choice=Other)"
label(data$prep_meds___3)="PrEP-related medications prescribed (choice=None)"
label(data$days_dispensed)="Number of days dispensed"
label(data$med1)="Medication 1 prescribed at this visit"
label(data$med1_other)="Please provide the name of the medication prescribed. "
label(data$med1_dose)="Strength of dose for medication 1"
label(data$med1_unit)="Unit of dosage for medication 1"
label(data$med1_freq)="Frequency of medication 1"
label(data$med1_duration)="Number of days prescribed for medication 1"
label(data$med2)="Medication 2"
label(data$med2_other)="Name of medication 2 prescribed"
label(data$med2_dose)="Strength of dose for medication 2"
label(data$med2_unit)="Unit of dose for medication 2"
label(data$med2_freq)="Frequency of dose for medication 2"
label(data$med2_duration)="Number of days medication 2 was prescribed"
label(data$med3)="Medication 3"
label(data$med3_other)="Name of medication 3 prescribed"
label(data$med3_dose)="Strength of dose for medication 3"
label(data$med3_unit)="Unit of dose for medication 3"
label(data$med3_freq)="Frequency of dose for medication 3"
label(data$med3_duration)="Number of days medication 3 was prescribed"
label(data$med4)="Medication 4"
label(data$med4_other)="Name of medication 4 prescribed"
label(data$med4_dose)="Strength of dose of medication 4"
label(data$med4_unit)="Unit of dose of medication 4"
label(data$med4_freq)="Frequency of dose of medication 4"
label(data$med4_duration)="Number of days medication 4 was prescribed"
label(data$med5)="Medication 5"
label(data$med5_other)="Name of medication 5 prescribed"
label(data$med5_dose)="Strength of dose of medication for medication 5"
label(data$med5_unit)="Unit of dose of medication 5"
label(data$med5_freq)="Frequency of medication 5"
label(data$med5_duration)="Number of days medication 5 was prescribed"
label(data$med6)="Medication 6"
label(data$med6_other)="Name of medication 6 prescribed"
label(data$med6_dose)="Strength of dose for medication 6"
label(data$med6_unit)="Unit of dose of medication 6"
label(data$med6_freq)="Frequency of medication 6"
label(data$med6_duration)="Number of days medication 6 was prescribed"
label(data$med7)="Medication 7"
label(data$med7_other)="Name of medication 7 prescribed"
label(data$med7_dose)="Strength of dose of medication 7"
label(data$med7_unit)="Unit of dose of medication 7"
label(data$med7_freq)="Frequency of medication 7"
label(data$med7_duration)="Number of days medication 7 was prescribed"
label(data$med8)="Medication 8"
label(data$med8_other)="Name of medication 8 prescribed"
label(data$med8_dose)="Strength of dose of medication 8"
label(data$med8_unit)="Unit of dose prescribed for medication 8"
label(data$med8_freq)="Frequency that medication 8 was prescribed"
label(data$med8_duration)="Number of days medication 8 was prescribed "
label(data$med9)="Medication 9"
label(data$med9_other)="Name of medication 9 prescribed"
label(data$med9_dose)="Strength of dose for medication 9"
label(data$med9_unit)="Unit that medication 9 was prescribed in"
label(data$med9_freq)="Frequency of medication 9"
label(data$med9_duration)="Duration of prescription"
label(data$med10)="Medication 10"
label(data$med10_other)="Name of medication 10 prescribed"
label(data$med10_dose)="Strength of dosage of medication 10"
label(data$med10_unit)="What unit was the dosage of medication prescribed in?"
label(data$med10_freq)="What frequency was medication 10 prescribed for?"
label(data$med10_duration)="Number of days medication 10 was prescribed"
label(data$condoms)="Did the client receive condoms during this visit?"
label(data$outcome___1)="Outcome indicated during this visit (choice=persistence)"
label(data$outcome___2)="Outcome indicated during this visit (choice=lost to follow up)"
label(data$outcome___3)="Outcome indicated during this visit (choice=death)"
label(data$outcome___4)="Outcome indicated during this visit (choice=stopped taking PrEP)"
label(data$date_ltfu)="Date of Lost to Follow-up Noted"
as.Date(data$date_ltfu)
label(data$reason_ltfu)="Reason for Loss to follow-up"
label(data$prep_stop_date)="Date participant stopped taking PrEP"
label(data$prep_stop)="Reason why participant stopped taking PrEP"
label(data$visit_complete)="Complete?"
label(data$test_results_timestamp)="Survey Timestamp"
label(data$specimen_date)="Date specimens were taken"
as.Date(data$specimen_date)
label(data$hiv_result)="HIV result"
label(data$renal_fx_result)="Renal Function Result"
label(data$hbsag_result)="Hepatitis B Surface Antigen Result"
label(data$hbsab_result)="Hepatitis B Surface Antibody result"
label(data$dipstix_result___1)="Urine Dipstix (choice=Ketones)"
label(data$dipstix_result___2)="Urine Dipstix (choice=Bilirubin)"
label(data$dipstix_result___3)="Urine Dipstix (choice=Nitrates)"
label(data$dipstix_result___4)="Urine Dipstix (choice=Leukocytes)"
label(data$dipstix_result___5)="Urine Dipstix (choice=Blood)"
label(data$syphilis_rapid_test)="Syphilis rapid test result"
label(data$preg_result)="Rapid Pregnancy Result"
label(data$ast_result)="AST Result"
label(data$alt_result)="ALT Result"
label(data$hb)="Hb (Haemoglobin) result"
label(data$other_test_results)="Please provide results of other tests not listed. "
label(data$test_results_complete)="Complete?"
label(data$exit_timestamp)="Survey Timestamp"
label(data$data_capt)="Name of data capturer"
label(data$date_death)="Date of Death"
as.Date(data$date_death)
label(data$death_cause)="Cause of death"
label(data$other_client)="Do you have anything to note about this client that has not been captured?"
label(data$data_concerns)="Do you have any concerns about the data captured for this client?"
label(data$data_complete)="Are you comfortable submitting the data for this client as complete?"
label(data$not_captured)="Were there any important fields that could not be captured? "
label(data$not_captured_fields)="Please specify which fields were not captured. "
label(data$exit_complete)="Complete?"
dd=data.table(data)
#3664 obs of 213 variables

#Complete variables 
dd$redcap_repeat_instance=ifelse(dd$redcap_repeat_instrument=="", 0, dd$redcap_repeat_instance)
dd$redcap_repeat_instrument=ifelse(dd$redcap_repeat_instance==0, "bl", 'visit')
uniqueid=unique(dd[,study_id])
print(uniqueid)
is.na(uniqueid)
##Provide values for "empty" variables depending on instrument
for (stid in uniqueid){
  rid=dd[study_id==stid,record_id]
  cat(rid,class(rid), stid, "\n")
  test1=dd[study_id==stid][1,test_hiv1]
  start=dd[study_id==stid][1,prep_start_dt]
  sexc=dd[study_id==stid][1,sex]
  site=dd[study_id==stid][1,site_id]
  age=dd[study_id==stid][1,age_check]
  dd[record_id%in%rid, study_id:=stid]
  dd[record_id%in%rid, test_hiv1:=test1]
  dd[record_id%in%rid, prep_start_dt:=start]
  dd[record_id%in%rid, sex:=sexc]
  dd[record_id%in%rid, site_id:=site]
  dd[record_id%in%rid, age_check:=age]
}

##Risk group category
dd$risk_group2=ifelse(dd$risk_group==1, "MSM",
               ifelse(dd$risk_group==2, "YW", 
               ifelse(dd$risk_group==3, "FSW",
               ifelse(dd$risk_group==4, "TGW",
               ifelse(dd$risk_group==5, "SDC", 
               ifelse(dd$risk_group==7, "PWID", dd$risk_group_other))))))
dd$risk_group3=ifelse(dd$risk_group2=="MSM" | dd$risk_group2=="YW" | dd$risk_group2=="FSW" | dd$risk_group2=="TGW" | dd$risk_group2=="SDC" | dd$risk_group2=="PWID", dd$risk_group2, 
                ifelse(dd$risk_group2==5|dd$risk_group2==10|dd$risk_group2==12|dd$risk_group2==30|dd$risk_group2==31|dd$risk_group2==32, "General Population", 
                ifelse(dd$risk_group2==2|dd$risk_group2==3|dd$risk_group2==4|dd$risk_group2==20|dd$risk_group2==21|dd$risk_group2==22|dd$risk_group2==24, "Bisexual Male", 
                ifelse(dd$risk_group2==25|dd$risk_group2==26|dd$risk_group2==27|dd$risk_group2==28|dd$risk_group2==29|dd$risk_group2==33, "Unknown", NA))))
dd$vn=paste(dd$redcap_repeat_instrument,dd$redcap_repeat_instance)


table(dd$risk_group3)
head(dd$risk_group2)


###Remove incorrect visits
dt=subset(dd, dd$site_id!=99 & dd$site_id!=98)
dt$record_id.x=dt$record_id

dt$`Visit number`=dt$vn

dt$excl=ifelse((dt$record_id.x==57 & dt$`Visit number`=="visit 1")|
                 (dt$record_id.x==41 & (dt$`Visit number`=="visit 5"| dt$`Visit number`=="visit 6")) |
                 (dt$record_id.x==49 & dt$`Visit number`=="visit 4")|
                 (dt$record_id.x==52 & dt$`Visit number`=="visit 4")|
                 (dt$record_id.x==1252 & dt$`Visit number`=='visit 1') |                 
                 (dt$record_id.x==132 & dt$`Visit number`=='visit 3') |                
                 (dt$record_id.x==236 & dt$`Visit number`=='visit 2') |
                 (dt$record_id.x==425 & (dt$`Visit number`=='visit 11' | dt$`Visit number`=='visit 12' | dt$`Visit number`=='visit 13'))|
                 (dt$record_id.x==403 & dt$`Visit number`=='visit 2') |
                 (dt$record_id.x==409 & dt$`Visit number`=='visit 13')|
                 (dt$record_id.x==764 & dt$`Visit number`=='visit 2') |
                 (dt$record_id.x==150 & dt$`Visit number`=='visit 5') |
                 (dt$record_id.x==451 & dt$`Visit number`=='visit 7') |
                 (dt$record_id.x==386 & dt$`Visit number`=='visit 3') |
                 (dt$record_id.x==349 & dt$`Visit number`=='visit 7') |
                 (dt$record_id.x==350 & (dt$`Visit number`=='visit 7'| dt$`Visit number`=='visit 8')) |
                 (dt$record_id.x==374 & dt$`Visit number`=='visit 5') |
                 (dt$record_id.x==251 & (dt$`Visit number`=='visit 5' | dt$`Visit number`=='visit 6')) |
                 (dt$record_id.x==204 & dt$`Visit number`=='visit 6')|
                 (dt$record_id.x==448 & dt$`Visit number`=='visit 7') |
                 (dt$record_id.x==453 & (dt$`Visit number`=='visit 6' | dt$`Visit number`=='visit 7')) |
                 (dt$record_id.x==348 & (dt$`Visit number`=='visit 9' | dt$`Visit number`=='visit 10')) |
                 (dt$record_id.x==455 & dt$`Visit number`=='visit 7') |
                 (dt$record_id.x==261 & dt$`Visit number`=='visit 6') |
                 (dt$record_id.x==266 & dt$`Visit number`=='visit 7') |
                 (dt$record_id.x==255 & dt$`Visit number`=='visit 5') |
                 (dt$record_id.x==216 & dt$`Visit number`=='visit 6') |
                 (dt$record_id.x==206 & dt$`Visit number`=='visit 6') |
                 (dt$record_id.x==468 & dt$`Visit number`=='visit 2')|
                 (dt$record_id.x==900 & dt$`Visit number`=='visit 2')|
                 (dt$record_id.x==891 & dt$`Visit number`=="visit 6")|
                 (dt$record_id.x==903 & dt$`Visit number`=='visit 2')|
                 (dt$record_id.x==896 & (dt$`Visit number`=='visit 3' | dt$`Visit number`=='visit 4')) |
                 (dt$record_id.x==921 & dt$`Visit number`=='visit 8') |
                 (dt$record_id.x==945 & dt$`Visit number`=='visit 5') |
                 (dt$record_id.x==939 & (dt$`Visit number`=='visit 6' | dt$`Visit number`=='visit 7'))|
                 (dt$record_id.x==933 & dt$`Visit number`=="visit 3") |
                 (dt$record_id.x==950 & (dt$`Visit number`=='visit 8' | dt$`Visit number`=="visit 9")) |
                 (dt$record_id.x==941 & (dt$`Visit number`=="visit 5" | dt$`Visit number`=="visit 6")) |
                 (dt$record_id.x==926 & dt$`Visit number`=="visit 3") |
                 (dt$record_id.x==1011 & dt$`Visit number`=='visit 5') |
                 (dt$record_id.x==989 & dt$`Visit number`=='visit 2') |
                 (dt$record_id.x==960 & dt$`Visit number`=="visit 6") |
                 (dt$record_id.x==898 & dt$`Visit number`=='visit 2') |
                 (dt$record_id.x==1072 & dt$`Visit number`=='visit 5')|
                 (dt$record_id.x==449 & dt$`Visit number`=='visit 7')|
                 (dt$record_id.x==396 & (dt$`Visit number`=="visit 6" | dt$`Visit number`=='visit 7')) |
                 (dt$record_id.x==370 & dt$`Visit number`=='visit 9') |
                 (dt$record_id.x==387 & (dt$`Visit number`=='visit 6' | dt$`Visit number`=='visit 7')) |
                 (dt$record_id.x==313 & dt$`Visit number`=='visit 1') |
                 (dt$record_id.x==213 & dt$`Visit number`=='visit 6') |
                 (dt$record_id.x==195 & dt$`Visit number`=='visit 8') |
                 (dt$record_id.x==480 & dt$`Visit number`=='visit 2') |
                 (dt$record_id.x==805 & dt$`Visit number`=='visit 2') |
                 (dt$record_id.x==57 & dt$`Visit number`=='visit 4')  |
                 (dt$record_id.x==142 & dt$`Visit number`=='visit 3') |
                 (dt$record_id.x==177 &  dt$`Visit number`=='visit 3') |
                 (dt$record_id.x==57 & dt$`Visit number`=='visit 4') |
                 (dt$record_id.x==942 & dt$`Visit number`=='visit 5') |
                 dt$record_id.x==616 | dt$record_id.x==614 | dt$record_id.x==618 | dt$record_id.x==547 | dt$record_id.x==569 | dt$record_id.x==577, 1, 0)
table(dt$excl)
#excl 78 visits

dd2=subset(dt, dt$excl==0)
#reduces observations from 3505 to 342Ω
#Create visit number variable
dd2$vn=paste(dd2$redcap_repeat_instrument,dd2$redcap_repeat_instance)
dd2$test_hiv1=as.character(dd2$test_hiv1)
dd2$visit_date=as.character(dd2$visit_date)
class(dd2$visit_date)
##Time to first visit
dd2$time=as.Date(dd2$visit_date, format="%Y-%m-%d")-as.Date(dd2$prep_start_dt, format="%Y-%m-%d")
print(dd2$time)
#check NA 0 then provide 3rd value for each study ID
fu_stid = c()
for (stid in uniqueid){
  time_gap=dd2[study_id==stid,time]
  if (length(time_gap)<3){
    fu_stid = c(fu_stid, NA)
  } else {
    fu_stid = c(fu_stid, time_gap[3] )
  }
}

dummy = dd2[ , .( cc=-1), by=study_id]
g = dd2[time > 0, min(time), by=study_id]
for (s in g$study_id){
  dummy[study_id==s, cc:=g[study_id==s, V1]]
}

dummy$time_one=ifelse(dummy$cc==(-1), NA, dummy$cc)
summary(dummy$time_one)
mean(dummy$time_one, na.rm = TRUE)
print(fu_stid)
table(fu_stid)
length(uniqueid)
dd2$time=ifelse(dd2$time<=0,NA, ifelse(dd2$time=="", NA, dd2$time))
#3505 obs of 215 variables
table(dd2$time)
##Create same day variable in results
dd2$same_day=dd2[,.(as.character(test_hiv1)==as.character(visit_date))]
dd2[,same_d:=(as.character(test_hiv1)==as.character(visit_date))]
dd2$sex_u=1
dd2$followtime=ifelse(dd2$site_id==1 | dd2$site_id==2 |dd2$site_id==6 |dd2$site_id==7, 6, 12)
table(dd2$followtime)
#Create variable for enddate
library(DescTools)

dd2$enddate=ifelse(dd2$followtime==6, (AddMonths(dd2$prep_start_dt,6)
#does not work - only to be used for specific date - seq(as.Date(dd2$prep_start_dt), length.out=6, by='month')
dd2$daystoend=enddate

head(dd2$enddate)
dd2$maxvisit=dd2[max(dd2$redcap_repeat_instance, na.rm = TRUE)
dd3=dd2 %>%
  group_by(study_id) %>%
  slice_max(redcap_repeat_instance)
dd4=dd3[,3]
dd5=subset(dd3, dd3$redcap_repeat_instrument=='bl')

lastvisit=dd2[,max(redcap_repeat_instance), by=study_id]
lastvisitdate=dd2[,max(visit_date), by=study_id]
last=merge(lastvisit, lastvisitdate, by="study_id")

####Other medications####
##Paracetamol (6)
#smallest measure of dose==500mg
#dd2$paracet_dose=ifelse((dd2$med1==6 & dd2$med1_dose==500) | (dd2$med2==6 & dd2$med2_dose==500) | (dd2$med3==6 & dd2$med3_dose==500) |(dd2$med4==6 & dd2$med4_dose==500) |(dd2$med5==6 & dd2$med5_dose==500) |(dd2$med6==6 & dd2$med6_dose==500) |(dd2$med7==6 & dd2$med7_dose==500) |(dd2$med8==6 & dd2$med8_dose==500) |(dd2$med9==6 & dd2$med9_dose==500) |(dd2$med10==6 & dd2$med10_dose==500), 1,
                      #  ifelse((dd2$med1==6 & dd2$med1_dose==1) |(dd2$med2==6 & dd2$med2_dose==1) |(dd2$med3==6 & dd2$med3_dose==1) |(dd2$med4==6 & dd2$med4_dose==1) |(dd2$med5==6 & dd2$med5_dose==1) |(dd2$med6==6 & dd2$med6_dose==1) |(dd2$med7==6 & dd2$med7_dose==1) | (dd2$med8==6 & dd2$med8_dose==1) |(dd2$med9==6 & dd2$med9_dose==1) | (dd2$med10==6 & dd2$med10_dose==1),2,2))
#Med 1 paracetamol doses to be taken at once
dd2$para1=ifelse(dd2$med1==6 & dd2$med1_dose==500, 1, ifelse(dd2$med1==6 & dd2$med1_dose==1, 2, ifelse(dd2$med1==6,2,0)))
table(dd2$para1)
#Med 1 paracetamol total daily doses
dd2$paradaily1=ifelse((dd2$med1==6 & dd2$med1_freq==1) |(dd2$med1==6 & dd2$med1_freq==5) |(dd2$med1==6 & dd2$med1_freq==6) |(dd2$med1==6 & dd2$med1_freq==8),1, 
              ifelse(dd2$med1==6 & dd2$med1_freq==2, 2, 
              ifelse((dd2$med1==6 & dd2$med1_freq==3) | (dd2$med1==6 & dd2$med1_freq==7),3,
              ifelse(dd2$med1==6 & dd2$med1_freq==4, 4, 
              ifelse(dd2$med1==6, 3, 0)))))
table(dd2$paradaily1)
#Med 1 paracetamol duration
dd2$para1days=ifelse(dd2$med1==6, dd2$med1_duration,0)
table(dd2$para1days)
#Med 1 paracetamol total doses
dd2$para1_tot=dd2$para1*dd2$paradaily1*dd2$para1days
table(dd2$para1_tot)


dd2$para2=ifelse(dd2$med2==6 & dd2$med2_dose==500, 1, ifelse(dd2$med2==6 & dd2$med2_dose==1, 2, ifelse(dd2$med2==6,2,0)))
table(dd2$para2)
dd2$para3=ifelse(dd2$med3==6 & dd2$med3_dose==500, 1, ifelse(dd2$med3==6 & dd2$med3_dose==1, 2, ifelse(dd2$med3==6,2,0)))
table(dd2$para3)
dd2$para4=ifelse(dd2$med4==6 & dd2$med4_dose==500, 1, ifelse(dd2$med4==6 & dd2$med4_dose==1, 2, ifelse(dd2$med4==6,2,0)))
table(dd2$para4)
dd2$para5=ifelse(dd2$med5==6 & dd2$med5_dose==500, 1, ifelse(dd2$med5==6 & dd2$med5_dose==1, 2, ifelse(dd2$med5==6,2,0)))
table(dd2$para5)

para=subset(dd2,dd2$med1==6)
azithro=subset(dd2, dd2$med1==25)

##Ibuprofen
#smallest version of dose=200mg
#Med 1 ibuprofen doses to be taken at once
dd2$inza1=ifelse(dd2$med1==7 & dd2$med1_dose==500, 1, ifelse(dd2$med1==7 & dd2$med1_dose==1, 2, ifelse(dd2$med1==7,2,0)))
table(dd2$inza1)
#Med 1 inza total daily doses
dd2$inzadaily1=ifelse((dd2$med1==7 & dd2$med1_freq==1) |(dd2$med1==7 & dd2$med1_freq==5) |(dd2$med1==7 & dd2$med1_freq==6) |(dd2$med1==7 & dd2$med1_freq==8),1, 
                      ifelse(dd2$med1==7 & dd2$med1_freq==2, 2, 
                             ifelse((dd2$med1==7 & dd2$med1_freq==3) | (dd2$med1==7 & dd2$med1_freq==7),3,
                                    ifelse(dd2$med1==7 & dd2$med1_freq==4, 4, 
                                           ifelse(dd2$med1==7, 3, 0)))))
table(dd2$inzadaily1)
#Med 1 ibuprofen duration
dd2$inza1days=ifelse(dd2$med1==7, dd2$med1_duration,0)
table(dd2$inza1days)
#Med 1 paracetamol total doses
dd2$inza1_tot=dd2$inza1*dd2$inzadaily1*dd2$inza1days
table(dd2$inza1_tot)
inza2=subset(dd2, dd2$inza1>0)

####Results data table####
dd2$ra_score_1=ifelse(dd2$vn=="visit 1", dd2$risk_assess_score, NA)
dd2$ra_score_check=ifelse(is.na(dd2$ra_score_1)=="TRUE", 0, 1)
table(dd2$ra_score_1, dd2$ra_score_check)
results=dd2[,.(number_visits=max(redcap_repeat_instance), 
               #Number of provider interactions
               pharm_seen=sum(provider_seen___1, na.rm=TRUE),
               nurse_seen=sum(provider_seen___2, na.rm=TRUE),
               dr_seen=sum(provider_seen___3, na.rm = TRUE),
               tech_seen=sum(provider_seen___4, na.rm=TRUE),
               couns_seen=sum(provider_seen___5, na.rm =TRUE),
               other_seen=sum(provider_seen___6, na.rm=TRUE),
               #Number of tests by type
               hiv_rapid=sum(lab_tests___1, na.rm=TRUE),
               hiv_elisa=sum(lab_tests___2, na.rm=TRUE),
               renalfx=sum(lab_tests___3, na.rm=TRUE),
               hepbag=sum(lab_tests___4, na.rm=TRUE),
               hepbab=sum(lab_tests___5, na.rm =TRUE),
               u_dipstx=sum(lab_tests___6, na.rm = TRUE),
               rpr=sum(lab_tests___7, na.rm=TRUE),
               tpha=sum(lab_tests___8, na.rm=TRUE),
               pregrapid=sum(lab_tests___9, na.rm=TRUE),
               bhcg=sum(lab_tests___10, na.rm = TRUE),
               ast=sum(lab_tests___11, na.rm=TRUE),
               alt=sum(lab_tests___12, na.rm=TRUE),
               hb=sum(lab_tests___15, na.rm=TRUE),
               other_test=sum(lab_tests___13, na.rm=TRUE),
               #ART dispensed
               prep_dispensed=sum(days_dispensed, na.rm =TRUE),
               #prep_prescribed=sum(prep_prescr_dur, na.rm=TRUE),
               same_day=any(same_day),
               bl_ra=sum(ra_score_1, na.rm = TRUE),
               ra_score_check1=sum(ra_score_check, na.rm=TRUE),
               time_fu=min(time, na.rm = TRUE), 
               sex_u=any(sex_u),
               second=any()), 
               bco=any(med1_other)
               by=study_id]
results$lastvisitdate=lastvisitdate$V1
class(dd2$study_id)
results
results$time_fu1=dummy$time_one
summary(dd2$time)
results$time_fu=ifelse(results$time_fu=="Inf", NA, results$time_fu)
summary(results$time_fu)
length(unique(dd2$record_id))
results$outcome=ifelse(results$number_visits>=2, 1, 0)
results$outcome=factor(results$outcome, levels = c(0,1), labels = c("No", 'Yes'))
sex=dd2[,.(length(unique(dd2$record_id))), by=sex]
table(baseline$sex)

baseline=subset(dd2, dd2$redcap_repeat_instrument=='bl')
baseline=data.table(baseline)
table(baseline$sex)
#1075 obs



baseline$site=ifelse(baseline$site_id==3 | baseline$site_id==6, "Hatfield", ifelse(baseline$site_id==8 | baseline$site_id==9, "Esselen", ifelse(baseline$site_id==1 |baseline$site_id==2, "EMH", 0)))
baseline$model=ifelse(baseline$site_id==3 |baseline$site_id==8 |baseline$site_id==1, "Facility-based", ifelse(baseline$site_id==6|baseline$site_id==9|baseline$site_id==2, "Outreach", 0))
baseline1=merge(baseline, results, by="study_id")
start=subset(baseline1, baseline1$site=="Hatfield"|baseline1$site=="EMH")
label(start$same_day.y)="Same day initiation"
start$prep_year=as.factor(start$prep_year)
label(start$prep_year)="Year initiated"
start$sex.f=factor(start$sex, levels=c(1,2,3), labels=c("Male", "Female", "Other"))
label(start$sex.f)="Sex"
start$risk_group.f=as.factor(start$risk_group3)
label(start$risk_group.f)="Risk Group"
label(start$age_check)="Age"
start$outcome=ifelse(start$number_visits>=2, 1, 0)
start$outcome=factor(start$outcome, levels = c(0,1), labels = c("No", 'Yes'))
label(start$outcome)="Did patient have a follow-up visit?"
label(start$number_visits)="Number of visits recorded"
label(start$nurse_seen)="Nurse interactions"
label(start$dr_seen)="Doctor interactions"
label(start$couns_seen)="Counsellor interactions"
start$bl_ra_check=factor(start$bl_ra_check, levels = c(1,2), labels = c("Yes", "No"))
label(start$bl_ra_check)="Risk assessment completed at baseline"
start$bl_ra.f=factor(start$bl_ra, levels = c(1:5), labels = c('1', '2', '3', '4','5'))
label(start$bl_ra.f)="Baseline risk assessment score if completed"
label(start$time_fu1)="Days between initiation and 1st follow-up"
##Table 1
table(start$bl_ra, start)
table1(~age_check + prep_year + risk_group.f+ same_day.y + time_fu1 + number_visits + nurse_seen +couns_seen +outcome| site, data = start, render.continuous=c(.="Mean (SD)", .="Median [Q1, Q3]"))
summary(ess_outreach$bl_ra, na.rm=TRUE)
table(ess$site_id)
ess_outreach=subset(ess, ess$site_id=="Outreach Model")
ess_fac=subset(ess, ess$site_id=="Facility based")
summary(ess_fac$bl_ra, na.rm=TRUE)
summary(ess_outreach$bl_ra)

mel_out=subset(mel, mel$site_id=="Outreach Model")
summary(mel_out$bl_ra, na_rm=TRUE)
####troubleshooting data cleaning####)
table(start$outcome, start$number_visits)
who=subset(start, start$number_visits==0)

table(start$risk_group3)





####Create separate datasets for each site####
#Hatfield
hat=subset(start, (start$site_id==3 |start$site_id==6) & start$number_visits!=0)
#238 obs of 224 variables
hat$site_id=factor(hat$site_id, levels = c(3,6), labels = c("Facility based", "Outreach Model"))
#Label sites
table1(~age_check + sex.f + prep_year + risk_group.f+ same_day + number_visits + nurse_seen +couns_seen +outcome | site_id, data = hat)

##Mellville
mel=subset(start, (start$site_id==1 |start$site_id==2) & start$number_visits!=0)
#163 obs of 224 variables
mel$site_id=factor(mel$site_id, levels = c(1,2), labels = c("Facility based", "Outreach Model"))
#Label sites
table1(~age_check + sex.f + prep_year + risk_group.f+ same_day + number_visits + nurse_seen +couns_seen +outcome | site_id, data = mel)


##Esselen
ess=subset(start, (start$site_id==8 |start$site_id==9) & start$number_visits!=0)
#197 obs of 224 variables
ess$site_id=factor(ess$site_id, levels = c(8,9), labels = c("Facility based", "Outreach Model"))
#Label sites
table1(~age_check + sex.f + prep_year + risk_group.f+ same_day.y + number_visits + nurse_seen +couns_seen +outcome | site_id, data = ess)

###Alternative Table 1
table(dd$site_id)
excluded=subset(dd, dd$site_id==99)
length(unique(excluded$study_id))
un=(unique(baseline1$study_id))
table(baseline$sex)

three=merge(results, dd, by="study_id")
excl=baseline1[,uni:=(unique(study_id))]
baseline$gooi=duplicated(baseline$study_id)
table(baseline$gooi)
baseline3=subset(baseline, baseline$gooi=="FALSE" )
table(baseline1$sex)
length(unique(data$study_id))
colnames(excluded)
exp=baseline1[,c(1,2,7,8,9,10)]
table(dd2$risk_group, dd2$prep_reason) 
any(baseline1$vn=="visit 2")
baseline1$time_fu=ifelse(baseline1$outcome.y=="No", NA, baseline1$time_fu)
table(baseline1$time_fu, baseline1$outcome.y)
summary(baseline1$time_fu, na.rm = TRUE)
start$site_model=ifelse(start$site=="EMH" | start$site=="Hatfield", "msm", "fsw")
table1(~age_check + sex.f + prep_year + risk_group.f+ same_day.y + time_fu + number_visits + nurse_seen + dr_seen +couns_seen + factor(bl_ra_check) + bl_ra + factor(model) + factor(prep_reason) + factor(site_model)| site_model*site_id, data = start, render.continuous=c(.="Mean (SD)", .="Median [Q1, Q3]"))
####troubleshooting data cleaning####
##Feb 11 - days between visit & fu even if no fu
table(baseline1$time_fu)
negtime=subset(baseline1, baseline1$time_fu<0)
no=subset(baseline1, baseline1$outcome.y=="No")
table(no$time_fu)
no=subset(no, no$time_fu>0)
table(no$prep_start_dt)
colnames(no)
no_see=no[, c(1,10,19,43)]
nog=subset(no, no$same_day.x=="False")
table(no$same_day)

write.xlsx(exp, "Unique ID's with basic identifiers.xlsx")
ch=baseline[,c(7,9)]
write.xlsx(ch, "All ID's with sex.xlsx")

table(start$number_visits, start$time_fu)
sub=subset(start, start$time_fu<3)
table(sub$visit_date, sub$time_fu)

####HREC Feb 2021 report gender breakdown###
HREC_sex_breakdown$study_id=HREC_sex_breakdown$`Study ID`
HREC_sex_breakdown$record_id=HREC_sex_breakdown$`Record ID`
hrec1=merge(baseline3, HREC_sex_breakdown, by="study_id")
hrec2=merge(baseline, HREC_sex_breakdown, by="study_id")
hrec3=merge(baseline3, HREC_sex_breakdown, by="record_id")
hrec4=merge(baseline, HREC_sex_breakdown, by="record_id")
table(hrec1$`Include/Exclude`)
table(hrec1$sex, hrec1$`HREC report category`)
table(hrec$`Include/Exclude`)
table(hrec$`Reason for exclusion`)
table(hrec1$`Include/Exclude`)
length(unique(hrec4$study_id.x))

table(hrec1$`HREC report category`)
hrec1$dup=any(hrec1$`Reason for exclusion`=="Duplicate")

table(hrec1$site_id)
hrec1$`HREC report category`=ifelse(hrec1$`HREC report category`=="Duplicate data entry", "Duplicate data entry",
                                    ifelse(hrec1$`HREC report category`=="Not eligible", "Not eligible", 
                                           ifelse(hrec1$`HREC report category`=="Test data", "Test data", "Include")))
hrec_enrolled=subset(hrec1, hrec1$`HREC report category`!="Duplicate data entry")
hrec_enrolled=subset(hrec1, hrec1$`HREC report category`=="Not eligible"| is.na(hrec1$`HREC report category`)==TRUE)

table(hrec_enrolled$Sex)
table(hrec_incl$Sex)
table(hrec1$`HREC report category`, hrec1$`Reason for exclusion`)
table(baseline1$sex)
table(baseline1$sex.f)
excl=subset(hrec1, hrec1$`HREC report category`=="Not eligible")
table(excl$Sex)
table(data$sex)

#Durban site numbers 25 March 2021
durban=subset(dd2, dd2$site_id==4 | dd2$site_id==5 | dd2$site_id==7)
isUnique(durban$study_id)
uniqueidd=unique(durban[,study_id])
sitefour=subset(dd2, dd2$site_id==4)
uniqueid4=unique(sitefour[,study_id])
table(dt$site_id, dt$excl)
vier=subset(dt, dt$site_id==4 & dt$excl==1)
table()
siteseven=subset(data, data$site_id==7)
uniqueid7=unique(siteseven[,study_id])
sitefive=subset(dd2, dd2$site_id==5)
uniqueid5=unique(sitefive[,study_id])
excluded=subset(dt, dt$excl==1)
