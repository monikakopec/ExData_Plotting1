# download data & unzip
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
dest <- "./exdata_data_household_power_consumption.zip"
download.file(url, dest)
list.files("./")
unzip(dest)

# reading data
data_row<-read.table("./household_power_consumption.txt", sep=";", header=TRUE, na.strings="?", colClasses=c(rep("character", 2), rep("numeric", 7)))

# reading data only from 2007-02-01 and 2007-02-02
data_row$Time <- strptime(paste(data_row$Date, data_row$Time), "%d/%m/%Y %H:%M:%S")
data_row$Date <- as.Date(data_row$Date, "%d/%m/%Y")
final<-data_row[data_row$Date>="2007-02-01" & data_row$Date<="2007-02-02",]

# plot & save to a file
png(file="plot2.png", width=480, height=480)
plot(final$Time,
  final$Global_active_power,
  xlab="",
  type="l",
  ylab="Global Active Power (kilowatts)"
)

dev.off()
