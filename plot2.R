library(dplyr)
library(data.table)
library(lubridate)

# open/read text file

file = "./Plotting/household_power_consumption.txt"
house <- read.table(file, header = TRUE, sep = ";", dec = ".")
head(house)

#pull in dates between 2007-02-01 and 2007-02-02
house$Date <- as.Date(house$Date, format = "%d/%m/%Y")
house$Time <- strptime(house$Time, format = "%H:%M:%S")
house$Time <- as.ITime(house$Time)
house$fulldate <- paste0(house$Date, " ", house$Time)
house$fulldate <- as_datetime(house$fulldate)

subhouse <-filter(house, Date >= "2007-02-01", Date <= "2007-02-02")
subhouse$Global_active_power <- as.numeric(as.character(subhouse$Global_active_power))


#create line chart and copy to PNG

png(filename = "./Plotting/plot2.png", width =480, height = 480)
plot(Global_active_power~fulldate, subhouse, main = "Global Active Power", type="l", ylab = "Global Active Power (kilowatts)", xlab = "")

dev.off()

