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

#Creating multiple plot
png("plot4.png",480,480)
par(mfrow=c(2,2))
##1st plot
plot(selectedData$DateTime, selectedData$Global_active_power, type="l",  lwd=1, xlab="", ylab="Global Active Power (kilowatts)")
##2nd plot
plot(selectedData$DateTime, selectedData$Voltage, type="l",  lwd=1, xlab="datetime", ylab="Voltage")
##3rd plot
plot(selectedData$DateTime, selectedData$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
lines(selectedData$DateTime, selectedData$Sub_metering_2, type = "l", col="red")
lines(selectedData$DateTime, selectedData$Sub_metering_3, type = "l", col="blue")
legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
##4th plot
plot(selectedData$DateTime, selectedData$Global_reactive_power, type="l", lwd=1, xlab = "datetime", ylab = "Global_reactive_power")
dev.off()
