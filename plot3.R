
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

# Plot data to png
png("plot3.png", width = 480, height=480)
plot(datetime, submetering1, type="n", ylab="Energy sub metering", xlab = "")
lines(datetime, submetering1, col="black")
lines(datetime, submetering2, col="red")
lines(datetime, submetering3, col="blue")
legend("topright", legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col=c("black","red","blue"), lty=1)
dev.off()
