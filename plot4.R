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
subhouse$Sub_metering_1 <- as.numeric(as.character(subhouse$Sub_metering_1))
subhouse$Sub_metering_2 <- as.numeric(as.character(subhouse$Sub_metering_2))
subhouse$Sub_metering_3 <- as.numeric(as.character(subhouse$Sub_metering_3))
subhouse$Global_reactive_power <- as.numeric(as.character(subhouse$Global_reactive_power))
subhouse$Voltage <- as.numeric(as.character(subhouse$Voltage))


#create line chart and copy to PNG
png(filename = "./Plotting/plot4.png", width =480, height = 480)
par(mfcol = c(2, 2))
plot(Global_active_power~fulldate, subhouse, type="l", ylab = "Global Active Power", xlab = "")

#create energy sub metering line chart
plot(Sub_metering_1~fulldate, subhouse, main = "", type="l", ylab = "Energy sub metering", xlab = "")

#overlay line plot on sub metering line chart
lines(Sub_metering_2~fulldate, subhouse, col="red", lwd=1)
lines(Sub_metering_3~fulldate, subhouse, col="blue", lwd=1)
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lty=1, bty = "n")

#create Voltage plot
plot(Voltage~fulldate, subhouse, main = "", type = "l", ylab = "Voltage", xlab="datetime")

#Create Global Reactive Power plot
plot(Global_reactive_power~fulldate, subhouse, main = "", type = "l", ylab = "Global_reactive_power", xlab = "datetime")
dev.off()
