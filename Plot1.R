library(dplyr)
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", "Electric Power Consumption")
unzip("Electric Power Consumption")
df<-read.table("household_power_consumption.txt",header=TRUE, sep=";", skip=grep("31/1/2007", readLines("household_power_consumption.txt")), nrows=4320, na.strings="?", col.names = c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
df<-df[(df$Date=="1/2/2007"|df$Date=="2/2/2007"),]
#df$Date<-as.Date(df$Date, format="%d/%m/%Y")
df$DateTime<-strptime(paste(df$Date,df$Time), format="%d/%m/%Y %H:%M:%S")
df<-subset(df, select=c("DateTime", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
png("plot1.png", width=480, height=480)
hist(df$Global_active_power, col="red", main = "Global Active Power", xlab="Global Active Power (kilowatts)", ylab="Frequency")
dev.off()
