library(data.table)
library(sqldf)

filename = "data/household_power_consumption.txt"
#read csv file using sql select
D <- read.csv2.sql(filename,sep=";", sql = "select * from file where Date = '1/2/2007' or Date = '2/2/2007' ")
#convert Date, Time to datetime in posix 
D[,"datetime"] <- as.POSIXct(strptime(paste(D$Date, D$Time), format="%d/%m/%Y %H:%M:%S", tz="EST"))

#Plot 4
par(mfrow = c(2, 2), mar = c(4, 4, 2, 1), oma = c(0, 0, 2, 0)) 
with(D, {
    # plot 1,1
    plot(datetime, Global_active_power,type="l", xlab="", ylab="Global Activity Power")
    
    # plot 1,2
    plot(datetime, Voltage,type="l", xlab="datetime", ylab="Voltage")
    
    # plot 2,1
    plot(datetime, Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
    lines(datetime, Sub_metering_2, type="l", col="blue")
    lines(datetime, Sub_metering_3, type="l", col="red")
    legend("topright", inset=.0, c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), 
           col=c("black","red","blue"), lty=1, horiz=FALSE)
    
    #plot 2,2
    plot(datetime, Global_reactive_power ,type="l", xlab="datetime", ylab="Global reactive power")
    
    # copy to png
    dev.copy(png,"figure/plot4.png",width=480,height=480,units="px")
    dev.off()
})

