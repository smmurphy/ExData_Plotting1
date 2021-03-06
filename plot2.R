
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


# Create Plot 2
# Open a png plotting environment
png(filename = "plot2.png", width = 480, height = 480, units = "px")

# Create an empty plot with the x axis scaled to the range found in DateTime and 
# the y axis scaled to Global_active_power
# Set the x axis title as blank and the y axis title as Global Active Power (kilowatts)
plot(pwr[,DateTime], 
     pwr[,Global_active_power], 
     type = "n", 
     xlab = "",
     ylab="Global Active Power (kilowatts)")
     
# Plot a line showing Global_active_power by DateTime
lines(pwr[,DateTime], pwr[,Global_active_power])

# Close the plotting environment
dev.off()



