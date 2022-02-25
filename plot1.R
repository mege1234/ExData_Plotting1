library(dplyr)
library(data.table)
library(utils)
library(datasets)

# open/read text file

file = "./Plotting/household_power_consumption.txt"
house <- read.table(file, header = TRUE, sep = ";", dec = ".")
head(house)

#pull in dates between 2007-02-01 and 2007-02-02
house$Date <- as.Date(house$Date, format = "%d/%m/%Y")
house$Time <- strptime(house$Time, format = "%H:%M:%S")
house$Time <- as.ITime(house$Time)
house$Global_active_power <- as.numeric(as.character(house$Global_active_power))
subhouse <-filter(house, Date >= "2007-02-01", Date <= "2007-02-02")

#create red histogram with Title
with(subhouse, hist(Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")) 

#copy my histogram to PNG
dev.copy(png, file = "./Plotting/plot1.png", width = 480, height = 480, units = "px")
dev.off()
