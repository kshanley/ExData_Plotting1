
# Download file and unzip the dataset:
filename <- "power_consumption.zip"
if (!file.exists(filename)){
    fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    download.file(fileURL,filename)
}  
if (!file.exists("household_power_consumption.txt")) { 
    unzip(filename) 
}

# Read data
power <- read.table("household_power_consumption.txt",sep=";", skip=1, stringsAsFactors=FALSE)
colnames(power) <- c("date","time","global_active","global_reactive","voltage","global_itensity",
                     "Sub_metering_1","Sub_metering_2","Sub_metering_3")

# Keep the dates 2007-02-01 and 2007-02-02
powersubset <- power[power$date %in% c("1/2/2007","2/2/2007") ,]


# Convert date and time into date-time column
datetime <- strptime(paste(powersubset$date, powersubset$time, sep=" "), "%d/%m/%Y %H:%M:%S") 
submetering1 <- as.numeric(powersubset$Sub_metering_1)
submetering2 <- as.numeric(powersubset$Sub_metering_2)
submetering3 <- as.numeric(powersubset$Sub_metering_3)
globalactive <- as.numeric(powersubset$global_active)
globalreactive <- as.numeric(powersubset$global_reactive)
voltage <- as.numeric(powersubset$voltage)

# Plot data to png
png("plot4.png", width = 480, height=480)
par(mfrow=c(2,2))
#First plot
plot(datetime, globalactive, type="n", ylab="Global Active Power", xlab = "")
lines(datetime, globalactive)
#Second plot
plot(datetime, voltage, type="n", ylab="Voltage", xlab = "datetime")
lines(datetime, voltage)
#Third plot
plot(datetime, submetering1, type="n", ylab="Energy sub metering", xlab = "")
lines(datetime, submetering1, col="black")
lines(datetime, submetering2, col="red")
lines(datetime, submetering3, col="blue")
legend("topright", legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col=c("black","red","blue"), lty=1, bty="n")
#Fourth plot
plot(datetime, globalreactive, type="n", ylab="Global_reactive_power", xlab = "datetime")
lines(datetime, globalreactive)
dev.off()
