library(unmarked)
library(AICcmodavg)

dataFilePath = "C:/Users/4lábavan/OneDrive/Dokumentumok/Rcodes/occupancy_modelling/data/bobcat.csv"
dfBobcat = read.csv(dataFilePath, header = FALSE)

dataFilePath = "C:/Users/4lábavan/OneDrive/Dokumentumok/Rcodes/occupancy_modelling/data/detection_data.csv"
dfDetection = read.csv(dataFilePath, header = TRUE)

dataFilePath = "C:/Users/4lábavan/OneDrive/Dokumentumok/Rcodes/occupancy_modelling/data/psicov.csv"
dfPsicov = read.csv(dataFilePath, header = TRUE)

dfDetection = list(temp = dfDetection)
unmarkedFrame <- unmarkedFrameOccu(y = dfBobcat, siteCovs = dfPsicov, obsCovs = dfDetection)

p.null<-occu(~1~1, data=unmarkedFrame)
p.temp<-occu(~temp~1, data=unmarkedFrame)

summary(unmarkedFrame)

modlist1<-list(
  p.null=p.null, p.temp=p.temp)
  

aictab(modlist1)