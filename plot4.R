# download data & unzip
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
dest <- "./exdata_data_household_power_consumption.zip"
download.file(url, dest)
list.files("./")
unzip(dest)

# reading data
data_row<-read.table("./household_power_consumption.txt", sep=";", header=TRUE)

# reading data only from 2007-02-01 and 2007-02-02
aa<-cbind(data_row, as.Date(strptime(data_row$Date, format="%d/%m/%Y")))
colnames(aa)[10]<-"Data"
final<-aa[aa$Data=="2007-02-01" | aa$Data=="2007-02-02",]

# plot & save to a file
png(file="plot4.png", width=480, height=480)
par(mfrow=c(2,2))
# row 1 col 1
plot(
  x=as.numeric(paste(final$Global_active_power)),
  xlab="",
  type="l",
  ylab="Global Active Power (kilowatts)"
)
# row 2 col 1
plot(
  x=as.numeric(paste(final$Voltage)),
  xlab="datetime",
  type="l",
  ylab="Voltage"
)
# row 1 col 2
with(final, plot(
  x=as.numeric(paste(final$Sub_metering_1)),
  xlab="",
  type="l",
  col="black",
  ylab="Energy sub metering"
))
with(final, lines(
  x=as.numeric(paste(final$Sub_metering_2)),
  col="red"
))
with(final, lines(
  x=as.numeric(paste(final$Sub_metering_3)),
  col="blue"
))
legend("topright",pch=1,col=c("black","red","blue"),
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

# row 2 col 2
plot(
  x=as.numeric(paste(final$Global_reactive_power)),
  xlab="datetime",
  type="l",
  ylab="Global_reactive_power"
)

dev.off()
