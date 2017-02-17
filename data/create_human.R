hd <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human_development.csv", stringsAsFactors = F)

gii <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/gender_inequality.csv", stringsAsFactors = F, na.strings = "..")

#En saanut aineistoja ladattua. En siis tiedä muuttujien
#nimiä. Yritin kuitenkin kirjoittaa komennot ylös.

str(hd)
dim(hd)
summary(hd)

str(gii)
dim(gii)
summary(gii)

library(plyr)

rename(hd, c("Life expectancy"="life_exp", "Mean years of schooling"=
"m_school", "Expected years of schooling"="exp_school",
"GNI per capita"="GNI_perc"))

rename(gii, c("Maternal mortality ratio"="mum_mort",
"Adolescent birth rate"="birth_rate", "Female and male population
with at least secondary education"="fm_educ", "Female and
male shares of parliamentary seats"="fm_parlseats", "Female and
male labour force participation rates"="fm_labour"))

gii <- mutate(gii,  edu_ratio=edu2F / edu2M)

gii <- mutate(gii, labor_ratio=labF / labM)

library(dplyr)

join_by <- c("Countries")

human <- inner_join(hd, gii, by = join_by, suffix=c(".hd", ".gii"))

human<- select(human, one_of(join_by))

write.table(human, file="data/human.txt", sep=",")

