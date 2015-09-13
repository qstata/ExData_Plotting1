# Creating a data direcory if a data folder does not exist
if (!file.exists("data")) {dir.create("data")}

# Downloading the data file from the internet
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
destfile <- "./data/power_consumption.zip"
download.file(fileUrl, destfile)
dateDownloaded <- date()

# Unzip the zipped data file for loading into R
unzip(zipfile="./data/power_consumption.zip", exdir="./data")

# Open the data file for reading
f1 <- file("./data/household_power_consumption.txt", "r");

# Reading in the data from 2007-02-01 to 2007-02-02 rather than reading in the entire dataset 
d1 <- read.table(text = grep("^Date|^[1,2]/2/2007", readLines(f1), value = TRUE), 
                header = TRUE, sep = ";", skip = 0, na.strings = "?", stringsAsFactors = FALSE)

# Closing the opened data file
close(f1)

# add a new date-time formated column
d1$date.time <- as.POSIXct(paste(d1$Date, d1$Time), format = "%d/%m/%Y %T")

# Construct the plot and save it to a PNG file with a width of 480 pixels and a height of 480 pixels.
png(filename = "plot1.png", width = 480, height = 480, bg="transparent")

# Plot 1 - histogram
hist(d1$Global_active_power, main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)", 
     ylab = "Frequency", 
     col = "red")

# close connection to the png device
dev.off()

