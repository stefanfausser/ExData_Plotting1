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

# plot a histogram of the global active power

png("plot1.png", width=480, height=480)

with(vals, hist(Global_active_power, 
     main="Global Active Power", 
     xlab="Global Active Power (kilowatts)", 
     col='red'))

dev.off()
