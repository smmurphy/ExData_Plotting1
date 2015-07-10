
# Set working directory
setwd("~/GitHub/ExData_Plotting1")

############################## Data Download ###################################
#
# # Uncomment the below to download the data to your working directory and unzip
# url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
# destfile <- "household_power_consumption.zip"
# download.file(url, destfile)
#
# # Set a time stamp
# downloadTime<-Sys.time()
# 
# # Print the time stamp to the console
# downloadTime
#
# # For the original script the file was downloaded:
# 2015-07-09 14:31:00 EDT
#
# # Unzip the file
# unzip(destfile, files = "household_power_consumption.txt")
################################################################################

############################## Read in Data ####################################
#
# Install the below packages if not installed
# data.table is excellent for dealing with large files
if("data.table" %in% rownames(installed.packages()) == FALSE) {
    install.packages("data.table")
}

if("lubridate" %in% rownames(installed.packages()) == FALSE) {
    install.packages("lubridate")
}

# Load required packages
library(data.table)
library(lubridate)

# Read in the data
pwr <- fread("household_power_consumption.txt", sep = ';', na.strings = '?')

# Paste Date and Time together to create DateTime field
pwr[,DateTime:=paste(Date, Time, sep = " ")]

# Change DateTime to date time format
pwr[,DateTime:=fast_strptime(DateTime, format = "%d/%m/%Y %H:%M:%S")]

# Subset data to 2007-02-01 through 2007-02-02
pwr <- pwr[as.Date(DateTime) >= '2007-02-01' & as.Date(DateTime) <= '2007-02-02',]

# Convert fields to numeric
pwr[,Global_active_power:=as.numeric(Global_active_power)]
pwr[,Global_reactive_power:=as.numeric(Global_reactive_power)]
pwr[,Voltage:=as.numeric(Voltage)]
pwr[,Global_intensity:=as.numeric(Global_intensity)]
pwr[,Sub_metering_1:=as.numeric(Sub_metering_1)]
pwr[,Sub_metering_2:=as.numeric(Sub_metering_2)]
pwr[,Sub_metering_3:=as.numeric(Sub_metering_3)]

# Change Date to date format
pwr[,Date:=fast_strptime(Date, format = "%d/%m/%Y")]

# Change Time to time format
pwr[,Time:=hms(Time)]

# Create Plot 4
# Open a png plotting environment
png(filename = "plot4.png", width = 480, height = 480, units = "px")

# Set the plot area to a 2 x 2 matrix of plots
par(mfrow=c(2,2))

# Create the first plot
# Create an empty plot with the x axis scaled to the range found in DateTime and 
# the y axis scaled to Global_active_power
# Set the x axis title as blank and the y axis title as Global Active Power
plot(pwr[,DateTime], 
     pwr[,Global_active_power], 
     type = "n", 
     xlab = "",
     ylab="Global Active Power")
     
# Plot a line showing Global_active_power by DateTime
lines(pwr[,DateTime], pwr[,Global_active_power])

# Create the second plot
# Create an empty plot with the x axis scaled to the range found in DateTime and 
# the y axis scaled to Voltage
# Set the x axis title as datetime and the y axis title as Voltage
plot(pwr[,DateTime], 
     pwr[,Voltage], 
     type = "n", 
     xlab = "datetime",
     ylab="Voltage")
     
# Plot a line showing Voltage by DateTime
lines(pwr[,DateTime], pwr[,Voltage])

# Create the third plot
# Create an empty plot with the x axis scaled to the range found in DateTime and 
# the y axis scaled to Sub_metering_1
# Set the x axis title as blank and the y axis title as Energy sub metering
plot(pwr[,DateTime], 
     pwr[,Sub_metering_1], 
     type = "n", 
     xlab = "",
     ylab="Energy sub metering")

# Plot a line showing Sub_metering_1 by DateTime
lines(pwr[,DateTime], pwr[,Sub_metering_1])

# Plot a line showing Sub_metering_2 by DateTime set the color to red
lines(pwr[,DateTime], pwr[,Sub_metering_2], col = 'red')

# Plot a line showing Sub_metering_3 by DateTime set the color to blue
lines(pwr[,DateTime], pwr[,Sub_metering_3], col = 'blue')

# Create a legend in the top right corner that labels the lines Sub_metering_1, 
# Sub_metering_2, Sub_metering_3, sets the line type to a solid line and the colors
# to 'black', 'red', and 'blue'
legend("topright",
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty=c(1,1,1),
       col=c("black","red","blue"))

# Create the fourth plot
# Create an empty plot with the x axis scaled to the range found in DateTime and 
# the y axis scaled to Global_reactive_power
# Set the x axis title as blank and the y axis title as Global_reactive_power
plot(pwr[,DateTime], 
     pwr[,Global_reactive_power], 
     type = "n", 
     xlab = "datetime",
     ylab="Global_reactive_power")

# Plot a line showing Global_reactive_power by DateTime
lines(pwr[,DateTime], pwr[,Global_reactive_power])

# Close the plotting environment
dev.off()



