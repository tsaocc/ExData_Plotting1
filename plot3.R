#plot3
#clean the global environment
rm(list=ls())
#load data
data <- read.table("./household_power_consumption.txt", sep=";",
                   header = T, na.strings = "?")
#change to date format
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")
#subset data within 2007-02-01 ~ 2007-02-02
SubsetData<- subset(data, Date >= "2007-02-01" & Date <= "2007-02-02")
#changeto 
SubsetData$datetime <- strptime(paste(SubsetData$Date, SubsetData$Time), 
                                "%Y-%m-%d %H:%M:%S")
SubsetData$datetime <- as.POSIXct(SubsetData$datetime)

#open graphic device (png)
png("plot3.png", width = 480, height = 480)
#create base plot
with(SubsetData, plot(Sub_metering_1 ~ datetime, type = "l", 
                      ylab = "Energy sub metering", xlab = ""))
#add two additional lines
lines(SubsetData$Sub_metering_2 ~ SubsetData$datetime, col="red")
lines(SubsetData$Sub_metering_3 ~ SubsetData$datetime, col="blue")
#add a legend
legend("topright", col= c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty= 1)
#close graphic device
dev.off()
