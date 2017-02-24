#Anna-Liina Olkinuora

#Wrangling the human data

#("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human_development.csv", stringsAsFactors = F)
#("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/gender_inequality.csv", stringsAsFactors = F, na.strings = "..")

hd <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human_development.csv", stringsAsFactors = F)
gii <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/gender_inequality.csv", stringsAsFactors = F, na.strings = "..")

str(hd)
dim(hd)
summary(hd)
str(gii)
dim(gii)
summary(gii)

new_names_hd <- c("HDI.Rank","Country","HDI","Life.Exp","Edu.Exp","Edu.Mean","GNI","GNI.Minus.Rank")
new__names_gii <- c("GII.Rank", "Country", "GII","Mat.Mor","Ado.Birth","Parli.F","Edu2.F","Edu2.M","Labo.F","Labo.M")
colnames(hd) <-new_names_hd 
colnames(gii) <-new__names_gii  
colnames(hd)
colnames(gii)

library(dplyr)
gii <- mutate(gii,  Edu2.FM=(Edu2.F / Edu2.M))
gii <- mutate(gii, Labo.FM=(Labo.F / Labo.M))

join_by <- c("Country")
human <- inner_join(hd, gii, by = join_by, suffix=c(".hd", ".gii"))

setwd("C:/Users/Anna-Liina/Documents/IODS-project")
write.table(human, file="data/human.txt", sep=",", row.names=TRUE)

human <- mutate(human, as.numeric(GNI))

keep <- c("Country", "Edu2.FM", "Labo.FM", "Life.Exp", "Edu.Exp", "GNI", "Mat.Mor", "Ado.Birth", "Parli.F")
human <- select(human, one_of(keep))
colnames(human)

# print out a completeness indicator of the 'human' data
complete.cases(human)
# print out the data along with a completeness indicator as the last column
data.frame(human[-1], comp = complete.cases(human))
# filter out all rows with NA values
human_ <- filter(human, complete.cases(human)==TRUE)

# look at the last 10 observations of human
tail(human_, n=10)
# define the last indice we want to keep
last <- nrow(human_) - 7
# choose everything until the last 7 observations
human_ <- human_[1:last, ]

# add countries as rownames
rownames(human_) <- human_$Country
# remove the Country variable
human_ <- select(human_, -Country)

dim(human_)
human <- human_
head(human)

write.table(human, file="data/human.txt", sep=",", row.names= TRUE)
