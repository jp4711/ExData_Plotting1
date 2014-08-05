library(data.table)
library(sqldf)

filename = "data/household_power_consumption.txt"
#read csv file using sql select
D <- read.csv2.sql(filename,sep=";", sql = "select * from file where Date = '1/2/2007' or Date = '2/2/2007' ")
#convert Date, Time to datetime in posix 
D[,"datetime"] <- as.POSIXct(strptime(paste(D$Date, D$Time), format="%d/%m/%Y %H:%M:%S", tz="EST"))

#Plot 3
with(D, {
    plot(datetime, Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
    lines(datetime, Sub_metering_2, type="l", col="blue")
    lines(datetime, Sub_metering_3, type="l", col="red")
    legend("topright", inset=.0, c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), 
           col=c("black","red","blue"), lty=1, horiz=FALSE)
    dev.copy(png,"figure/plot3.png",width=480,height=480,units="px")
    dev.off()
})

