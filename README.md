# Statistical-Analysis-of-Risk-Factors-Associated-with-PCOD-PCOS
================================================================================
FACTORS ASSOCIATED WITH POLYCYSTIC OVARY SYNDROME (PCOS):
AN ANALYTICAL CROSS-SECTIONAL STUDY
================================================================================
 
Author : Sanyukta Saha
Design : Analytical cross-sectional survey
Sample : 249 young women (82 reporting PCOS, 32.9%)
Method : Unadjusted odds ratios + multivariable logistic regression,
         bootstrap validation (1,000 resamples)
 
 
--------------------------------------------------------------------------------
1. OVERVIEW
--------------------------------------------------------------------------------
Polycystic ovary syndrome (PCOS) affects many young women, yet it is often
noticed late. This project examines which personal, lifestyle and family
characteristics go along with a PCOS diagnosis in a sample of young women,
using data from a structured questionnaire.
 
 
--------------------------------------------------------------------------------
2. RESEARCH QUESTION
--------------------------------------------------------------------------------
Which personal, lifestyle and family characteristics are associated with a
self-reported PCOS diagnosis among young women?
 
 
--------------------------------------------------------------------------------
3. STUDY DESIGN AND DATA
--------------------------------------------------------------------------------
- Design        : Analytical cross-sectional study
- Data source   : Structured questionnaire
- Participants  : 249 women (median age 20 years, IQR 19 to 21)
- Outcome       : PCOS (82 of 249 reported PCOS, 32.9%)
 
Predictors (ten variables chosen in advance):
  1. Age
  2. BMI
  3. Family history of PCOS
  4. Other medical conditions
  5. Sleep duration
  6. Stress
  7. Exercise
  8. Junk food intake
  9. Smoking or alcohol
 10. Anxiety or depression
 
Note: Symptoms that overlap with the PCOS definition (e.g. irregular periods,
hair growth) were analysed separately, not included in the main model.
 
 
--------------------------------------------------------------------------------
4. STATISTICAL METHODS
--------------------------------------------------------------------------------
1. Group comparison using unadjusted odds ratios (OR).
2. A single multivariable logistic regression with the ten pre-specified
   variables above (no data-driven variable selection).
3. Separate analysis of symptoms that overlap with the diagnostic definition.
4. Model performance assessed by C-statistic (discrimination), with
   optimism correction using bootstrap validation (1,000 resamples).
 
 
--------------------------------------------------------------------------------
5. KEY RESULTS
--------------------------------------------------------------------------------
Adjusted associations with PCOS:
 
  Factor                        Adjusted OR   95% CI
  ----------------------------  -----------   ----------------
  Family history of PCOS        8.35          3.94 to 17.67
  High stress                   2.34          1.16 to 4.73
  Sleeping 7 to 8 hours         0.24          0.12 to 0.47
  BMI (per kg/m2)               1.06          0.98 to 1.15
  Age                           No association
 
Model performance:
 
  - C-statistic as fitted               : 0.79
  - C-statistic, optimism-corrected     : 0.75  (modest discrimination)
  - C-statistic with symptoms added     : 0.86  (largely reflects overlap
                                          with diagnostic features)
 
 
--------------------------------------------------------------------------------
6. CONCLUSION
--------------------------------------------------------------------------------
A family history of PCOS, high stress and shorter sleep were associated with
PCOS, while lifestyle habits such as exercise, diet and smoking were not
clearly related.
 
 
--------------------------------------------------------------------------------
7. LIMITATIONS
--------------------------------------------------------------------------------
- Cross-sectional design: cannot show cause or direction of association.
- PCOS status and exposures are self-reported via questionnaire.
- Modest discrimination: the model is NOT suitable for screening or
  individual diagnosis.
- The higher C-statistic after adding symptoms is largely due to overlap
  with the diagnostic definition, not independent predictive value.
 
