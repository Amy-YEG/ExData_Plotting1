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


#create plot1.png
png(filename = "plot1.png",
    width = 480, height = 480,units = "px") 
hist(febData$Global_active_power, col="red", xlab="Global Active Power (kilowatts)",ylim=c(0,1200),breaks=12, main="Global Active Power")
dev.off()