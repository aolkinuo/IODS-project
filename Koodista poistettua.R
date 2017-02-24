#Poistettua

gender=learning2014$gender
age=learning2014$Age
attitude=learning2014$Attitude
points=learning2014$Points

library(plyr)

rename(hd, c("Life expectancy"="life_exp", "Mean years of schooling"=
               "m_school", "Expected years of schooling"="exp_school",
             "GNI per capita"="GNI_perc"))

rename(gii, c("Maternal mortality ratio"="mum_mort",
              "Adolescent birth rate"="birth_rate", "Female and male population
with at least secondary education"="fm_educ", "Female and
male shares of parliamentary seats"="fm_parlseats", "Female and
male labour force participation rates"="fm_labour"))