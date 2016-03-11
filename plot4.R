# download the file if necessary

url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

# TODO: Extract filename from 'url'
fileZip <- "exdata_data_household_power_consumption.zip"
fileTxt <- "household_power_consumption.txt"

if(!file.exists(fileTxt))
{
    download.file(url, destfile = fileZip)
    unzip(fileZip)
}

# read the file

vals <- read.table(fileTxt, header=TRUE, sep=";", na.strings="?", fill=TRUE)

# extract Date/Time information from 'vals', add as new column 'datetime' to vals

vals$datetime <- strptime(paste(vals$Date, vals$Time), "%d/%m/%Y %H:%M:%S")

# get subset of 'vals' where the dates are between 2007-02-01 and 2007-02-02, overwrite 'vals'

vals <- subset(vals, as.Date(datetime) == "2007-02-01" | as.Date(datetime) == "2007-02-02")

png("plot4.png", width=480, height=480)

par(mfrow=c(2,2))

# plot a scatterplot of the global active power

with(vals, plot(datetime, 
     Global_active_power, 
     type='l', 
     ylab="Global Active Power", 
     xlab=""))

# plot a scatterplot of the voltage

with(vals, plot(datetime, 
     Voltage, 
     type='l', 
     ylab="Voltage"))

# plot a scatterplot with energy sub metering (three lines)

with(vals, plot(rep(datetime, 3), 
     c(Sub_metering_1, Sub_metering_2, Sub_metering_3), 
     type='n', 
     ylab="Energy sub metering", 
     xlab=""))

with(vals, lines(datetime, Sub_metering_1))
with(vals, lines(datetime, Sub_metering_2, col='red'))
with(vals, lines(datetime, Sub_metering_3, col='blue'))

legend("topright", 
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       col=c("black", "red", "blue"),
       lty=1)

# plot a scatterplot of the global reactive power

with(vals, plot(datetime, 
     Global_reactive_power, 
     type='l', 
     ylab="Global_reactive_power"))

dev.off()
