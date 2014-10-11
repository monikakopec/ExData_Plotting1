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
png(file="plot2.png", width=480, height=480)
plot(
  x=as.numeric(paste(final$Global_active_power)),
  xlab="",
  type="l",
  ylab="Global Active Power (kilowatts)"
)
dev.off()
