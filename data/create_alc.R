#Anna-Liina Olkinuora, 9.2.2017. Tämä tiedosto on harjoitusten
#kolme aineistonmuokkausosion sisältöä varten.

math=read.table("data/student/student-mat.csv", sep = ";", header = TRUE)

por=read.table("data/student/student-por.csv", sep = ";", header = TRUE)

str(math)
dim(math)
str(por)
dim(por)

#math-aineisto sisältää 395 havaintoyksikköä ja 33 muuttujaa. 
#Muuttujista 17 ovat luokiteltuja muuttujia ja loput ovat
#numeerisia muuttujia. por-aineisto sisältää 649 havaintoyksikköä
#ja 33 muuttujaa. Muuttujista 17 ovat luokiteltuja muuttujia ja 
#loput ovat numeerisia muuttujia.

library(dplyr)

join_by = c("school","sex","age","address","famsize","Pstatus",
"Medu","Fedu","Mjob","Fjob","reason","nursery","internet")

math_por = inner_join(math, por, by = join_by, suffix=c(".math",
".por"))

str(math_por)
dim(math_por)

#Uudessa aineistossa on 382 havaintoyksikköä ja 53 muuttujaa. 
#Muuttujista 24 ovat luokiteltuja muuttujia ja loput ovat numeerisia
#muuttujia.

#Tulostetaan sarakkeiden nimet.
colnames(math_por)

#Luodaan aineisto jossa on vain aiemmin yhdistetyt sarakkeet.
alc <- select(math_por, one_of(join_by))

#sarakkeet joita ei käytetty aineistojen yhdistämiseen
notjoined_columns = colnames(math)[!colnames(math) %in% join_by]

#sarakkeet joita ei käytetty aineistojen yhdistämiseen 
#tulostettu
notjoined_columns

#Jokaisen sarakkeen jota ei käytetty aineistojen yhdistämisessä
#nimelle
for(column_name in notjoined_columns) {
#valitaan math_por-aineistosta kaksi saraketta joilla on sama
#alkuperäinen nimi.
two_columns = select(math_por, starts_with(column_name))
#Valitaan sarakkeista ensimmäinen sarakevektori.
first_column = select(two_columns, 1)[[1]]
  
#Jos ensimmäinen sarake on numeerinen
if(is.numeric(first_column)) {
#otetaan jokaisesta kahden sarakkeen rivistä pyöristetty
#keskiarvo ja lisätään näin saatu vektori alc-aineistoon.
alc[column_name] = round(rowMeans(two_columns))
} else { # else Jos ensimmäinen sarake ei ole numeerinen
#lisätään ensimmäinen sarakevektori alc-aineistoon.
  alc[column_name] = first_column
  }
}

#Määritellään uusi sarake yhdistämällä viikonpäivien ja
#viikonlopun alkoholinkäyttö.
alc = mutate(alc, alc_use = (Dalc + Walc) / 2)

#Määritellään uusi looginen sarake "high_use".
alc = mutate(alc, high_use = alc_use > 2)

#Katsotaan aineistoa. 
glimpse(alc)

#Aineistossa on 382 havaintoyksikköä ja 35 muuttujaa.

#Tallennetaan aineisto kurssin kansion data-kansioon.
write.table(alc, file="data/alc.txt", sep=",")
