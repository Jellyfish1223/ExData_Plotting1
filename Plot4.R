library(dplyr)
library(lubridate)
library(ggplot2)
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", "Electric Power Consumption")
unzip("Electric Power Consumption")
df<-read.table("household_power_consumption.txt",header=TRUE, sep=";", skip=grep("31/1/2007", readLines("household_power_consumption.txt")), nrows=4320, na.strings="?", col.names = c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
df<-df[(df$Date=="1/2/2007"|df$Date=="2/2/2007"),]
df$DateTime<-strptime(paste(df$Date,df$Time), format="%d/%m/%Y %H:%M:%S")
df<-subset(df, select=c("DateTime", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
png("plot4.png", width=480, height=480)
par(mfrow=c(2,2))
plot(df$DateTime, df$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)")

plot(df$DateTime, df$Voltage, type="l", xlab="datetime", ylab="Voltage")

with(df, plot(DateTime, Sub_metering_1, type="l", xlab="", ylab="Energy sub metering"))
with(df, lines(DateTime, Sub_metering_2, col="red"))
with(df, lines(DateTime, Sub_metering_3, col="blue"))
legend("topright", lty=c(1,1,1), col=c("black", "blue", "red"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

plot(df$DateTime, df$Voltage, type="l", xlab="datetime", ylab="Global_reactive_power")


dev.off()
