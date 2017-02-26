
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
                     "sub1","sub2","sub3")

# Keep the dates 2007-02-01 and 2007-02-02
powersubset <- power[power$date %in% c("1/2/2007","2/2/2007") ,]


# Convert date and time into date-time column
datetime <- strptime(paste(powersubset$date, powersubset$time, sep=" "), "%d/%m/%Y %H:%M:%S") 
globalactive <- as.numeric(powersubset$global_active)

# Plot data to png
png("plot2.png", width = 480, height=480)
plot(datetime,powersubset$global_active, type="n", ylab="Global Active Power (kilowatts)", xlab = "")
lines(datetime, powersubset$global_active)
dev.off()
