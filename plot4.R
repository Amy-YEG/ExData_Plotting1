#load data into R, specified the column classes so that numbers are loaded as numeric
powerData <- read.table("household_power_consumption.txt", header=T, sep=";", 
                        na.strings = "?"
                        ,colClasses = c("factor", "factor","numeric","numeric","numeric","numeric","numeric","numeric","numeric"))
#convert Date+Time to POSIXlt, replace the Time column with the POSIXlt date+time format data
powerData$Time<-strptime(paste(powerData$Date,",",powerData$Time), '%d/%m/%Y , %H:%M:%S')
#convert Date column from factor to Date format
powerData$Date<-as.Date(powerData$Date,'%d/%m/%Y')
#subset to get data from two days 2007-02-01 and 2007-02-02; 
febData<-subset(powerData,Date == '2007-02-01'|Date == '2007-02-02')


#create plot4.png
png(filename = "plot4.png",
    width = 480, height = 480,units = "px") 
par(mfrow=c(2,2))
#uppper left time~global_active_power
plot(febData$Time, febData$Global_active_power, type = "n", xlab= "", ylab = "Global Active Power (kilowatts)")
lines(febData$Time, febData$Global_active_power, type="l")
#upper right time~voltage
plot(febData$Time, febData$Voltage, type = "n", xlab= "datetime", ylab = "Voltage")
lines(febData$Time, febData$Voltage, type="l")

#lower left - time~sub_metering1/2/3, legend has no box

plot(febData$Time, febData$Sub_metering_1, type = "n", xlab= "", ylab = "Engery sub metering")
lines(febData$Time, febData$Sub_metering_1, type="l",col="black")
lines(febData$Time, febData$Sub_metering_2, type="l",col="red")
lines(febData$Time, febData$Sub_metering_3, type="l",col="blue")
legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),bty="n", lty=c(1,1,1), col=c("black","red","blue"),cex=0.5)

#lower right - time~global_reactive_power
plot(febData$Time, febData$Global_reactive_power, type = "n", xlab= "datetime", ylab = "Global_reactive_power")
lines(febData$Time, febData$Global_reactive_power, type="l")
dev.off()
