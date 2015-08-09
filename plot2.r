#Read data from local working directory then check to verify
rawData <-read.csv("household_power_consumption.txt",sep = ";", na.strings="?")
head(rawData)

#Converting date function
library(lubridate)
class(rawData$Date)
rawData$Date<-dmy(rawData$Date)
rawData$Date<-as.Date(rawData$Date)

#Subsetting then converting column as numeric
selectedData<-rawData[(rawData$Date>="2007-02-01" &rawData$Date<="2007-02-02"),]
selectedData$Global_active_power<-as.numeric(as.character(selectedData$Global_active_power))

#Combine date & time as new column
datetime <- paste(selectedData$Date, selectedData$Time)
selectedData$DateTime <- as.POSIXct(datetime)

#Creating plot
png("plot2.png",480,480)
plot(selectedData$DateTime, selectedData$Global_active_power, type="l",  lwd=1, xlab="", ylab="Global Active Power (kilowatts)")
dev.off()
