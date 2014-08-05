library(data.table)
library(sqldf)

filename = "data/household_power_consumption.txt"
#read csv file using sql select
D <- read.csv2.sql(filename,sep=";", sql = "select * from file where Date = '1/2/2007' or Date = '2/2/2007' ")
#convert Date, Time to datetime in posix 
D[,"datetime"] <- as.POSIXct(strptime(paste(D$Date, D$Time), format="%d/%m/%Y %H:%M:%S", tz="EST"))

#Plot 2
with(D, {
    plot(datetime, Global_active_power,type="l", xlab="Global Activity Power (kilowatts)", ylab="Frequency", main="Global Activity Power")
    dev.copy(png,"figure/plot2.png",width=480,height=480,units="px")
    dev.off()
})

