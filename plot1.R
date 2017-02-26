
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


# Convert Global Active Power to numeric
globalactive <- as.numeric(powersubset$global_active)

# Plot data to png
png("plot1.png", width = 480, height=480)
hist(globalactive, col="red", xlab="Global Active Power (kilowatts)", main="Global Active Power")
dev.off()
