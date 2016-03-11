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

# plot a scatterplot of energy sub metering (three lines)

png("plot3.png", width=480, height=480)

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

dev.off()
