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

# plot Global Active Power
hist(electricData$Global_active_power,
     main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)",
     col = "red")

# save as a png file
dev.copy(png, "plot1.png")

# close the graphics devices
dev.off()