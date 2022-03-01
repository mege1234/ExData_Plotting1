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
subhouse$Sub_metering_1 <- as.numeric(as.character(subhouse$Sub_metering_1))
subhouse$Sub_metering_2 <- as.numeric(as.character(subhouse$Sub_metering_2))
subhouse$Sub_metering_3 <- as.numeric(as.character(subhouse$Sub_metering_3))

#create line chart and copy to PNG

png(filename = "./Plotting/plot3.png", width =480, height = 480)
plot(Sub_metering_1~fulldate, subhouse, main = "", type="l", ylab = "Energy sub metering", xlab = "")

#overlay line plot
lines(Sub_metering_2~fulldate, subhouse, col="red", lwd=1)
lines(Sub_metering_3~fulldate, subhouse, col="blue", lwd=1)
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lty=1)
dev.off()

