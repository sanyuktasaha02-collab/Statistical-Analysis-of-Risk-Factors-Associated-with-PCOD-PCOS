df=read.csv( "/Users/sanyuktasaha/Desktop/pcod/PCOD DATA-ALL.csv")
colnames(df)

#MISSING VALUES/DUPLICATE
df$WEIGHT[is.na(df$WEIGHT)] <- mean(df$WEIGHT, na.rm = TRUE)
df[is.na(df$BMI), ]
colSums(is.na(df))[colSums(is.na(df)) > 0]


df$BMI[df$BMI ==  0.00] <-
  df$WEIGHT[df$BMI == 0] /
  ((df$HEIGHT[df$BMI == 0] / 100)^2)

names(df)
colSums(is.na(df))
sum(duplicated(df))
summary(df$BMI)

min(df$BMI)
dim(df)

#variable type
variable_types <- data.frame(
  Variable = names(df),
  Type = sapply(df, class)
)

print(variable_types)

#count
char_cols <- names(df)[sapply(df, is.character)]

for(col in char_cols) {
  cat("\n", col, "\n")
  print(table(df[[col]], useNA = "ifany"))
}

#encoding
# Weight Status
df$WEIGHT.STATUS <- factor(
  df$WEIGHT.STATUS,
  levels = c("Underweight", "Normal", "Overweight"),
  ordered = TRUE
)

# Stress Level
df$STRESS.LEVEL <- factor(
  df$STRESS.LEVEL,
  levels = c("LOW", "MODERATE", "HIGH"),
  ordered = TRUE
)

# Junk/Fast Food Consumption
df$JUNK.OR.FAST.FOOD <- factor(
  df$JUNK.OR.FAST.FOOD,
  levels = c("NEVER", "OFTEN", "DAILY"),
  ordered = TRUE
)

# Exercise
df$EXERCISE <- factor(
  df$EXERCISE,
  levels = c("NEVER", "OFTEN", "DAILY"),
  ordered = TRUE
)

# Hair-related variables
hair_cols <- c(
  "HAIR.THINNING.OR.HAIR.LOSS",
  "HAIR.GROWTH.ON.FACE",
  "HAIR.GROWTH.BETWEEN.BREASTS",
  "HAIR.GROWTH.ON.UPPER.LIPS",
  "HAIR.GROWTH.IN.ARMS",
  "HAIR.GROWTH.ON.INNER.THIGHS"
)

df[hair_cols] <- lapply(
  df[hair_cols],
  function(x) factor(
    x,
    levels = c("NEVER", "MODERATE", "EXCESSIVE"),
    ordered = TRUE
  )
)

#cycle
df$Cycle_Variability <- ifelse(
  df$CYCLE.LENGTH...range.like.25.28.days...keeps.variating. == "KEEPS VARIATING",
  "Yes",
  "No"
)


str(df)
sapply(df, class)


##CHISQ
outcome <- "PCOS.DIAGNOSED"

cat_vars <- names(df)[sapply(df, function(x)
  is.factor(x) | is.character(x))]

cat_vars <- setdiff(cat_vars, outcome)

results <- data.frame()

for(v in cat_vars){
  
  temp <- data.frame(
    outcome = df[[outcome]],
    predictor = df[[v]]
  )
  
  temp <- na.omit(temp)
  
  tab <- table(temp$outcome, temp$predictor)
  
  if(min(dim(tab)) < 2) next
  
  test <- suppressWarnings(chisq.test(tab))
  
  results <- rbind(
    results,
    data.frame(
      Variable = v,
      Chi_Square = round(test$statistic, 3),
      df = test$parameter,
      P_Value = round(test$p.value, 4),
      Significant = ifelse(test$p.value < 0.05,
                           "Yes", "No")
    )
  )
}

results <- results[order(results$P_Value), ]
results


#CHECKING NORMALITY
shapiro.test(df$WEIGHT)
shapiro.test(df$AGE)
shapiro.test(df$BMI)
shapiro.test(df$PERIOD.LENGTH..in.days.)


##MANNWHITNEY
wilcox.test(AGE ~ PCOS.DIAGNOSED,
            data = df)

wilcox.test(WEIGHT ~ PCOS.DIAGNOSED,
            data = df)

wilcox.test(BMI ~ PCOS.DIAGNOSED,
            data = df)

wilcox.test(PERIOD.LENGTH..in.days. ~ PCOS.DIAGNOSED,
            data = df)

#NUMERICAL VARIABLE DISTRIBUTION
num_vars <- c("AGE","HEIGHT","WEIGHT","BMI","PERIOD.LENGTH..in.days.")

par(mfrow=c(2,3))

for(v in num_vars){
  hist(df[[v]],
       main=v,
       xlab=v)
}

#BOXPLOT FOR OUTLIERS
par(mfrow=c(2,3))

for(v in num_vars){
  boxplot(df[[v]],
          main=v)
}

#extreme outliers
for(v in num_vars){
  
  Q1 <- quantile(df[[v]],0.25,na.rm=TRUE)
  Q3 <- quantile(df[[v]],0.75,na.rm=TRUE)
  
  IQR_val <- IQR(df[[v]],na.rm=TRUE)
  
  lower <- Q1 - 1.5*IQR_val
  upper <- Q3 + 1.5*IQR_val
  
  cat("\n",v,"\n")
  
  print(df[df[[v]] < lower | df[[v]] > upper,v])
}

par(mfrow=c(2,3))
#FREQUENCY TABLES
categorical_cols <- names(df)[sapply(df,is.factor)]

for(v in categorical_cols){
  cat("\n",v,"\n")
  print(table(df[[v]]))
}

#PCOS PREVALENCE
table(df$PCOS.DIAGNOSED)

prop.table(table(df$PCOS.DIAGNOSED))*100

#CORRELATION MATRIX
library(corrplot)

num_df <- df[,sapply(df,is.numeric)]

cor_mat <- cor(num_df,
               use="complete.obs")

corrplot(cor_mat,
         method="color",
         tl.cex=.8)
#BMI
par(mfrow=c(2,3))
library(ggplot2)

ggplot(df,
       aes(x=PCOS.DIAGNOSED,
           y=BMI,
           fill=PCOS.DIAGNOSED))+
  geom_boxplot()+
  theme_minimal()

#WEIGHT 
ggplot(df,
       aes(x=PCOS.DIAGNOSED,
           y=WEIGHT,
           fill=PCOS.DIAGNOSED))+
  geom_boxplot()+
  theme_minimal()

#STRESS LEVEL 
ggplot(df,
       aes(STRESS.LEVEL,
           fill=PCOS.DIAGNOSED))+
  geom_bar(position="fill")+
  labs(y="Proportion")

#SLEEP PATTERN
ggplot(df,
       aes(SLEEP.PATTERN..On.average..do.you.get.7.8.hours.of.sleep.per.night.,
           fill=PCOS.DIAGNOSED))+
  geom_bar(position="fill")
#FAMILY HISTORY

ggplot(df,
       aes(FAMILY.HISTORY.Do.you.have.any.family.members..mother..sister..aunt..who.have.been.diagnosed.with.PCOD.,
           fill=PCOS.DIAGNOSED))+
  geom_bar(position="fill")
#PAIRWISE RELATIONSHIP 
library(GGally)

num_df <- df[,c("AGE","HEIGHT","WEIGHT","BMI","PERIOD.LENGTH..in.days.")]

ggpairs(num_df)


#VIF GVIF^(1/(2*Df))

#install.packages("performance")
library(performance)

check_collinearity(model)


#model 
for(v in names(df)){
  if(is.factor(df[[v]]) || is.character(df[[v]])){
    cat("\n", v, "\n")
    print(table(df[[v]], useNA = "ifany"))
  }
}
# Make outcome a factor
df$PCOS.DIAGNOSED <- factor(
  df$PCOS.DIAGNOSED,
  levels = c("NO", "YES")
)


# Full logistic model excluding unwanted variables
full_model <- glm(
  PCOS.DIAGNOSED ~ . - SL.No. - HEIGHT - WEIGHT - BMI,
  data = df,
  family = binomial(link = "logit")
)

# Stepwise selection
step_model <- step(
  full_model,
  direction = "both",
  trace = TRUE
)

summary(step_model)

# Final selected model
formula(step_model)

# Odds Ratios
exp(coef(step_model))

#ODDS RATIO
# Odds Ratios
OR <- exp(coef(step_model))

# 95% Confidence Intervals
CI <- exp(confint(step_model))

# Combine into table
OR_table <- cbind(
  Odds_Ratio = OR,
  Lower_CI = CI[,1],
  Upper_CI = CI[,2]
)

round(OR_table, 3)

#GOODNESS OF FIT
# AIC
AIC(step_model)

# Pseudo R²
library(pscl)
pR2(step_model)

# Hosmer-Lemeshow Test
library(ResourceSelection)
library(rcompanion)
library(pscl)

hoslem.test(
  step_model$y,
  fitted(step_model)
)
nagelkerke(step_model)
pR2(step_model)


# ROC and AUC
library(pROC)

roc_obj <- roc(df$PCOS.DIAGNOSED,
               fitted(step_model))

auc(roc_obj)

plot(roc_obj)

 
#mac fadden
#install.packages("pscl")
#install.packages("rcompanion")
#install.packages("ResourceSelection")





