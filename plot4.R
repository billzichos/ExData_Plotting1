# set the working directory to be whereever you have the dataset stored
wd <- "~/GitHub/ExData_Plotting1"

setwd(wd)

library(lubridate)

# load the data into memory
electricData <- read.table("household_power_consumption.txt", sep = ";",
                           as.is = TRUE, header = TRUE)

# format date into single field
electricData$DateTime <- strptime(
        paste(electricData$Date, electricData$Time), "%d/%m/%Y %H:%M:%S")

# remove the former date & time fields
electricData <- electricData[,3:10]

# subset the data based on date
electricData <- electricData[year(electricData$DateTime)==2007 
                             & month(electricData$DateTime)==2
                             & day(electricData$DateTime) %in% c(1,2),]

# format the measurements as numeric
electricData$Global_active_power <- as.numeric(electricData$Global_active_power)
electricData$Global_reactive_power <- as.numeric(electricData$Global_reactive_power)
electricData$Voltage <- as.numeric(electricData$Voltage)
electricData$Global_intensity <- as.numeric(electricData$Global_intensity)
electricData$Sub_metering_1 <- as.numeric(electricData$Sub_metering_1)
electricData$Sub_metering_2 <- as.numeric(electricData$Sub_metering_2)
electricData$Sub_metering_3 <- as.numeric(electricData$Sub_metering_3)

# plot the 4 charts
par(mfrow = c(2,2))
with(electricData, {
        plot(DateTime, Global_active_power, type = "l", xlab = "", ylab = "Global Active Power")
        plot(DateTime, Voltage, type = "l", xlab = "datetime", ylab = "Voltage")
        plot(DateTime, Sub_metering_1, type = "l", col = "black", ylab = "Energy sub metering", xlab = "")
        lines(DateTime, Sub_metering_2, col = "red")
        lines(DateTime, Sub_metering_3, col = "blue")
        legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = 1, col = c("black", "red", "blue"), bty = "n")
        plot(DateTime, Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global_reactive_power")
})

# save as a png file
dev.copy(png, "plot4.png")

# close the graphics devices
dev.off()