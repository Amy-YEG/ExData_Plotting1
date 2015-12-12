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

#create plot2.png
png(filename = "plot2.png",
    width = 480, height = 480,units = "px") 
plot(febData$Time, febData$Global_active_power, type = "n", xlab= "", ylab = "Global Active Power (kilowatts)")
lines(febData$Time, febData$Global_active_power, type="l")
dev.off()