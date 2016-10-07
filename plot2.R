#plot2
#clean the global environment
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

#open graphic device (png)
png("plot2.png", width = 480, height = 480)
#make a plot
with(SubsetData, plot(Global_active_power~datetime, type = "l",
                      ylab="Global Active Power (kilowatts)", xlab=""))
#close the device
dev.off()
