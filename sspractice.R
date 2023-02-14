library(unmarked)
library(AICcmodavg)

dataFilePath = "C:/Users/4lábavan/OneDrive/Dokumentumok/Rcodes/occu_data_practice_1.csv"
data1 = read.csv(dataFilePath, header = TRUE)

tail(data1)
columnsToSelect = c("det1", "det2")
y = data1[,columnsToSelect]

columnsToSelect = c('ha','canopy','sapling','shrub','forb','fern','grass','moss','litter')
siteCovs = data1[,columnsToSelect]

columnsToSelect = c('cloud1','cloud2')
sky = data1[,columnsToSelect]

columnsToSelect = c('time1','time2')
tssr = data1[,columnsToSelect]

columnsToSelect = c('wind1', 'wind2')
wind = data1[,columnsToSelect]

columnsToSelect = c('date1','date2')
date = data1[,columnsToSelect]

obsCovs = list(sky = sky, wind = wind, tssr = tssr, date = date)

unmarkedFrame <- unmarkedFrameOccu(y = y, siteCovs = siteCovs, obsCovs = obsCovs)

p.null<-occu(~1~1, data=unmarkedFrame)
p.wind<-occu(~wind~1, data=unmarkedFrame)
p.sky<-occu(~sky~1, data=unmarkedFrame)
p.date<-occu(~date~1, data=unmarkedFrame)
p.time<-occu(~tssr~1, data=unmarkedFrame) 

summary(p.null)

modlist1<-list(
  p.null=p.null, p.wind=p.wind,
  p.sky=p.sky,p.time=p.time, p.date=p.date)

aictab(modlist1)

newsky<-data.frame(sky=seq(0, 100, length.out=100))
pred.p<-predict(p.sky, type="det", newdata=newsky)

plot(1, xlim=c(0,100), ylim=c(0,1), type="n", axes=T, xlab="Sky Condition (% Cloud Cov.)",
     pch=20, ylab="Detection Probability", family="serif",
     cex.lab=1.25, cex.main=1.75)

lines(newsky$sky, pred.p$Predicted, col="black", lwd=2)
lines(newsky$sky, pred.p$lower, lty=2, col="black")
lines(newsky$sky, pred.p$upper, lty=2, col="black")