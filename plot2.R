install.packages(dplyr)
library(dplyr)
install.packages(chron)
library(chron)



download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile="power")

data<-file.choose()

#import  data
power<-read.table(data, sep=";", header=TRUE)
#conver test data Date to Date
power$Date<- as.Date(power$Date, "%d/%m/%Y")
#convert time to POSIXct
power$Time <- chron(times. = power$Time)
#filter Dates
powersmall<- power %>% filter(Date=="2007-02-01" | Date == "2007-02-02")

#Create combined Date + Time column "DateTime"
powertime<-powersmall
powertime$DateTime<- with(powersmall, as.POSIXct(paste(Date, Time), format="%Y-%m-%d %H:%M:%S"))


#Plot blank graph, create line
par(mfrow=c(1,1))
plot(Global_active_power ~ DateTime, data=powertime, type="n")
lines(Global_active_power ~ DateTime, data=powertime)

#Export plot 2 as png
dev.copy(png, "plot2.png")
dev.off()
