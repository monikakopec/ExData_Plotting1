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
png(file="plot4.png", width=480, height=480)
par(mfrow=c(2,2))
# row 1 col 1
plot(
  final$Time,
  final$Global_active_power,
  xlab="",
  type="l",
  ylab="Global Active Power (kilowatts)"
)
# row 2 col 1
plot(
  final$Time,
  final$Voltage,
  xlab="datetime",
  type="l",
  ylab="Voltage"
)
# row 1 col 2
plot(
  final$Time,
  final$Sub_metering_1,
  xlab="",
  type="l",
  col="black",
  ylab="Energy sub metering"
)
lines(final$Time, final$Sub_metering_2, col="red")
lines(final$Time, final$Sub_metering_3, col="blue")
legend("topright",lty=1,col=c("black","red","blue"),
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
# row 2 col 2
plot(
  final$Time,
  final$Global_reactive_power,
  xlab="datetime",
  type="l",
  ylab="Global_reactive_power"
)

dev.off()
