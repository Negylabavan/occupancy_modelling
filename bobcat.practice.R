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

summary(p.temp)


aictab(modlist1)

newtemp<-data.frame(temp=seq(-3, 3, length.out=100))
pred.p<-predict(p.temp, type="det", newdata=newtemp)

plot(1, xlim=c(-3,3), ylim=c(0,1), type="n", axes=T, xlab="Temperature",
     pch=20, ylab="Detection Probability", family="serif",
     cex.lab=1.25, cex.main=1.75)

lines(newtemp$temp, pred.p$Predicted, col="black", lwd=2)
lines(newtemp$temp, pred.p$lower, lty=2, col="black")
lines(newtemp$temp, pred.p$upper, lty=2, col="black")