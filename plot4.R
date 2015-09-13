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
png(filename = "plot4.png", width = 480, height = 480, bg="transparent")

# Plot 4: multiple plots (2x2)
par(mfrow = c(2, 2))
with(d1, {
  plot(date.time, Global_reactive_power, type = "l", xlab = "", ylab = "Global Active Power")
  plot(date.time, Voltage, type = "l", xlab = "datetime", ylab = "Voltage")
  plot(date.time, Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")
  lines(date.time, Sub_metering_2, col = "red")
  lines(date.time, Sub_metering_3, col = "blue")
  legend("topright", col = c("black", "red", "blue"), cex = 0.7, lty = 1, bty = "n",
         legend = c("Sub_metering_1", 
                    "Sub_metering_2",
                    "Sub_metering_3"))
  plot(date.time, Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global Reactive Power")
})

# close connection to the png device
dev.off()

