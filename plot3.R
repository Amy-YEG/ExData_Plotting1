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

#create plot3.png
png(filename = "plot3.png",
    width = 480, height = 480,units = "px") 
plot(febData$Time, febData$Sub_metering_1, type = "n", xlab= "", ylab = "Engery sub metering")
lines(febData$Time, febData$Sub_metering_1, type="l",col="black")
lines(febData$Time, febData$Sub_metering_2, type="l",col="red")
lines(febData$Time, febData$Sub_metering_3, type="l",col="blue")
legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty=c(1,1,1),lwd=c(2,2,2), col=c("black","red","blue"),cex=0.75)
dev.off()