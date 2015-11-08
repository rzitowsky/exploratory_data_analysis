#
#
#  November 7, 2015
#  Coursera Exploratory Data Analysis class
#  Project 1, Plot 4
#
#

#  Import the data
mydata <- read.csv("~/Coursera/Project1/household_power_consumption.txt", sep=";", quote="", stringsAsFactors=FALSE)

#  Look at the data
str(mydata)

#'data.frame':  2880 obs. of  9 variables:
#$ Date                 : Date, format: "2007-02-01" "2007-02-01" ...
#$ Time                 : chr  "00:00:00" "00:01:00" "00:02:00" "00:03:00" ...
#$ Global_active_power  : num  0.326 0.326 0.324 0.324 0.322 0.32 0.32 0.32 0.32 0.236 ...
#$ Global_reactive_power: chr  "0.128" "0.130" "0.132" "0.134" ...
#$ Voltage              : chr  "243.150" "243.320" "243.510" "243.900" ...
#$ Global_intensity     : chr  "1.400" "1.400" "1.400" "1.400" ...
#$ Sub_metering_1       : chr  "0.000" "0.000" "0.000" "0.000" ...
#$ Sub_metering_2       : chr  "0.000" "0.000" "0.000" "0.000" ...
#$ Sub_metering_3       : num  0 0 0 0 0 0 0 0 0 0 ...

#  Make Date into a date variable
mydata$Date <- as.Date(mydata$Date, "%d/%m/%Y")

#  Make sub metering 1, sub metering 2, submetering 3, global active power, global reactive power, and voltage into numeric variables
mydata$Sub_metering_1 = as.numeric(mydata$Sub_metering_1)
mydata$Sub_metering_2 = as.numeric(mydata$Sub_metering_2)
mydata$Sub_metering_3 = as.numeric(mydata$Sub_metering_3)
mydata$Global_active_power = as.numeric(mydata$Global_active_power)
mydata$Global_reactive_power = as.numeric(mydata$Global_reactive_power)
mydata$Voltage = as.numeric(mydata$Voltage)

#  Subset the data so only the two requested dates are selected
mydata <- subset(mydata, Date >= "2007-02-01" & Date <= "2007-02-02")

#  Create timestamp variable

mydata$timestamp <- paste(mydata$Date, mydata$Time)
mydata$timestamp <- as.POSIXct(mydata$timestamp)

#  Export the plot to .png with a width of 480px and height of 480px.
png(file = "plot4.png", width=480, height=480)

#  Create the plot.
par(mfrow = c(2,2), oma = c(1,1,1,1))

#  Plot 1
with(mydata, plot(timestamp, Global_active_power, xlab="", ylab="Global Active Power", type="n"))
with(lines(mydata$timestamp, mydata$Global_active_power, lwd=1))

#  Plot 2
with(mydata, plot(timestamp, Voltage, xlab="datetime", ylab="Voltage", type="n"))
with(lines(mydata$timestamp, mydata$Voltage, lwd=1))

#  Plot 3
with(mydata, plot(mydata$timestamp, mydata$Sub_metering_1, xlab="", ylab="Energy sub metering", type="n"))
with(lines(mydata$timestamp, mydata$Sub_metering_1, col="black", lwd = 2))
with(lines(mydata$timestamp, mydata$Sub_metering_2, col="red", lwd = 2))
with(lines(mydata$timestamp, mydata$Sub_metering_3, col="blue", lwd = 2))
legend("topright", lwd = 2, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), cex=.75, bty = "n")

#  Plot 4
with(mydata, plot(timestamp, Global_reactive_power, xlab="datetime", ylab="Global_Reactive_Power", type="n"))
with(lines(mydata$timestamp, mydata$Global_reactive_power, lwd=1))

#  Turn off the .png plotting device
dev.off()