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

#Plot 4 Creation
#Create 2x2 plot area
par(mfrow=c(2,2))
#Plot 1
#convert to numeric
powertime$Global_active_power<-as.numeric(as.character(powertime$Global_active_power))

#make plot

plot(Global_active_power ~ DateTime, data=powertime, type="n") 
lines(Global_active_power ~ DateTime, data=powertime, ylab="Global Active Power", xlab="")

#Plot 2
powertime$Voltage <- as.numeric(as.character(powertime$Voltage))
plot(Voltage ~ DateTime, data=powertime, type="n", ylab = "Voltage", xlab="datetime")
lines(Voltage ~ DateTime, data=powertime)

#Plot3
#convert Sub_metering_X to numeric
powertime$Sub_metering_1<-as.numeric(as.character(powertime$Sub_metering_1))
powertime$Sub_metering_2<-as.numeric(as.character(powertime$Sub_metering_2))
powertime$Sub_metering_3<-as.numeric(as.character(powertime$Sub_metering_3))


#create plot 3
plot(Sub_metering_1 ~ DateTime, data=powertime, type="n", ylab="Energy Sub Metering", xlab="")
lines(Sub_metering_1 ~ DateTime, data=powertime)
lines(Sub_metering_2 ~ DateTime, data=powertime, col="blue")
lines(Sub_metering_3 ~ DateTime, data=powertime, col="red")
#create legend for plot 3
leg<-c("Sub_metering_1","Sub_metering_2", "Sub_metering_3")
symb<- c("-","-","-")
colors<- c("black","blue","red")
legend ("topright", legend =leg, pch=symb, col=colors, bty="n")

#plot 4
powertime$Global_reactive_power <- as.numeric(as.character(powertime$Global_reactive_power))
plot(Global_reactive_power ~ DateTime, data=powertime, type="n")
lines(Global_reactive_power ~DateTime, data=powertime)

#export plots
dev.copy(png, "plot4.png")
dev.off()