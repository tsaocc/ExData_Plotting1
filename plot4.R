#plot4
#clean teh global environment
rm(list=ls())
#load data
data <- read.table("./household_power_consumption.txt", sep=";",
                   header = T, na.strings = "?")
#change to date format
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")
#subset data within 2007-02-01 ~ 2007-02-02
SubsetData<- subset(data, Date >= "2007-02-01" & Date <= "2007-02-02")
#change to POSIXct format
SubsetData$datetime <- strptime(paste(SubsetData$Date, SubsetData$Time), 
                                "%Y-%m-%d %H:%M:%S")
SubsetData$datetime <- as.POSIXct(SubsetData$datetime)

#open a graphic device
png("plot4.png", width = 480, height = 480)
#set plot format (4 plots in a frame)
par(mfrow=c(2,2))
#1st plot (topleft)
with(SubsetData, plot(Global_active_power~datetime, type = "l",
                      ylab="Global Active Power", xlab=""))
#2nd plot (topright)
with(SubsetData, plot(Voltage~datetime, type ="l"))
#3rd plot (belowleft)
with(SubsetData, plot(Sub_metering_1 ~ datetime, type = "l", 
                      ylab = "Energy sub metering", xlab = ""))
lines(SubsetData$Sub_metering_2 ~ SubsetData$datetime, col="red")
lines(SubsetData$Sub_metering_3 ~ SubsetData$datetime, col="blue")
legend("topright", col= c("black", "red", "blue"), bty = "n",
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty= 1)
#4th plot (belowright)
with(SubsetData, plot(Global_reactive_power~datetime, type ="l"))
#close the device
dev.off()