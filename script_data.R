library(tidyr)
library(dplyr)
library(lubridate)

###############################################################################################
# download and unzip a dataset
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
path <- getwd()
download.file(url, file.path(path, "data/power_consumption.zip"))
unzip(zipfile = "./data/power_consumption.zip", exdir = "./data")
file.remove("./data/power_consumption.zip")

# load dataset into R
consumption <- read.csv2("./data/household_power_consumption.txt")

#change date format
consumption$Date <- dmy(consumption$Date)
# subset required data
consumption <- filter(consumption, Date=="2007-02-01"|Date=="2007-02-02")

# Change data format from factor to numeric
consumption[,3:9] <- sapply(consumption[,3:9], as.character)   
consumption[,3:9] <- sapply(consumption[,3:9], as.numeric)   


#consumption <- tbl_df(consumption)

