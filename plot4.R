library(tidyr)
library(dplyr)
library(lubridate)

###############################################################################################
# download and unzip a dataset
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
path <- getwd()
if (!file.exists("data")) { 
  dir.create("data") 
}
download.file(url, file.path(path, "data/power_consumption.zip"))
unzip(zipfile = "./data/power_consumption.zip", exdir = "./data")
file.remove("./data/power_consumption.zip")

# load dataset into R
consumption <- read.csv2("./data/household_power_consumption.txt")

# add a new column (time and date)
consumption <- unite(consumption, Date_time, Date, Time, sep = " ", remove = FALSE)

#change date format
consumption$Date <- dmy(consumption$Date)
consumption$Date_time <- dmy_hms(consumption$Date_time)
# subset required data
consumption <- filter(consumption, Date=="2007-02-01"|Date=="2007-02-02")

# Change data format from factor to numeric
consumption[,4:10] <- sapply(consumption[,4:10], as.character)   
consumption[,4:10] <- sapply(consumption[,4:10], as.numeric)   

# this prevents printing weekdays in my native language
Sys.setlocale("LC_TIME", "English")

# plot 4
png("plot4.png", width=480, height=480)
par(mfrow=c(2,2))
with(consumption, plot(Date_time, Global_active_power, type="l", xlab="", ylab="Global Active Power"))
with(consumption, plot(Date_time, Voltage, type = "l", xlab="datetime", ylab="Voltage"))
with(consumption, plot(Date_time, Sub_metering_1, type="l", xlab="", ylab="Energy sub metering"))
lines(consumption$Date_time, consumption$Sub_metering_2,type="l", col= "red")
lines(consumption$Date_time, consumption$Sub_metering_3,type="l", col= "blue")
legend(c("topright"), c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty= 1, lwd=2, col = c("black", "red", "blue"))
with(consumption, plot(Date_time, Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power"))
dev.off()