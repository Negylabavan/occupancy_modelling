library(unmarked)
library(AICcmodavg)

dataFilePath = "C:/Users/4lábavan/OneDrive/Dokumentumok/Rcodes/occupancy_modelling/data/Table_S2.csv"
dfAgilis = read.csv(dataFilePath, header = TRUE)

columnsToSelect = c("Specimen")
y = dfAgilis[0:67,columnsToSelect]
y[y>1] = 1

columnsToSelect = c('max_temp_6h')
max_temp_6h = dfAgilis[0:67,columnsToSelect]

obsCovs = list(max_temp_6h = max_temp_6h)

unmarkedFrame <- unmarkedFrameOccu(y = y, obsCovs = obsCovs, siteCovs = NULL)

p.null<-occu(~1~1, data=unmarkedFrame)
p.max_temp_6h<-occu(~max_temp_6h~1, data=unmarkedFrame)
##itt csak 1 kovariánsra néztük meg