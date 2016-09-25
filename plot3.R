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

#conver Sub_metering_x columns to character, then numeric
powertime$Sub_metering_1<-as.numeric(as.character(powertime$Sub_metering_1))
powertime$Sub_metering_2<-as.numeric(as.character(powertime$Sub_metering_2))
powertime$Sub_metering_3<-as.numeric(as.character(powertime$Sub_metering_3))

#setting plotting area
par(mfrow=c(1,1))
#create plotting area 
plot(Sub_metering_1 ~ DateTime, data=powertime, type="n", ylab="Energy Sub Metering", xlab="")
#create 3x lines
lines(Sub_metering_1 ~ DateTime, data=powertime)
lines(Sub_metering_2 ~ DateTime, data=powertime, col="blue")
lines(Sub_metering_3 ~ DateTime, data=powertime, col="red")
#create legend
leg<-c("Sub_metering_1","Sub_metering_2", "Sub_metering_3")
symb<- c("-","-","-")
colors<- c("black","blue","red")
legend("topright", legend =leg, pch=symb, col=colors, cex=.64, pt.cex=1)

#Export plot 3 as png
dev.copy(png, "plot3.png")
dev.off()
