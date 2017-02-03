#Anna-Liina Olkinuora, 2.2.2017. Tämä tiedosto on harjoitusten
#kaksi sisältöä varten.

learning2014=read.table("http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt", 
                        sep = "\t", header = TRUE)
str(aineisto)
dim(aineisto)

#Aineistossa on 60 muuttujaa ja 183 havaintoyksikköä. Lähes kaikki 
#muuttujat ovat numeerisia. Sukupuoli on luokiteltu muuttuja.

library(dplyr)

deep_kysymykset=c("D03", "D11", "D19", "D27", "D07", 
                  "D14", "D22", "D30","D06",  "D15", "D23", "D31")
deep_sarakkeet=select(learning2014, one_of(deep_kysymykset))
learning2014$deep=rowMeans(deep_sarakkeet)
deep=learning2014$deep
surface_questions=c("SU02","SU10","SU18","SU26", "SU05","SU13",
                    "SU21","SU29","SU08","SU16","SU24","SU32")
surface_columns=select(learning2014, one_of(surface_questions))
learning2014$surf=rowMeans(surface_columns)
surf=learning2014$surf
strategic_questions=c("ST01","ST09","ST17","ST25","ST04",
                      "ST12","ST20","ST28")
strategic_columns=select(learning2014, one_of(strategic_questions))
learning2014$stra=rowMeans(strategic_columns)
stra=learning2014$stra

pidä_sarakkeet=c("gender","Age","Attitude", "deep", "stra", "surf",
                 "Points")
learning2014=select(learning2014, one_of(pidä_sarakkeet))

learning2014=filter(learning2014, Points > 0)
str(learning2014)

setwd("C:/Users/Anna-Liina/Documents/IODS-project")

write.table(learning2014, file="data/learning2014.txt", sep=",")

learning2014=read.table("data/learning2014.txt", sep = ",", header = TRUE)

str(learning2014)