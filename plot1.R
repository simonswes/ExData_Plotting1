
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


#Create plot 1
par(mfrow=c(1,1))
powersmall$Global_active_power<-as.numeric(as.character(powersmall$Global_active_power))
hist(powersmall$Global_active_power, col="red", xlab = 'Global Active Power (kilowatts)', main = "Global Active Power")

#Export plot 1 as png
dev.copy(png, "plot1.png")
dev.off()

