#download the zip file from web
fileUrl1 <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl1, destfile ="./data.zip", method = "curl")
#unzip the file
unzip("data.zip")
#load data 
data <- read.table("./household_power_consumption.txt", sep=";",
                   header = T, na.strings = "?")
#change to date format
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")
#subset the data within 2007-02-01 ~ 2007-02-02
SubsetData<- subset(data, Date >= "2007-02-01" & Date <= "2007-02-02")

#open a graphic device
png("plot1.png", width = 480, height = 480)
#make a plot
with(SubsetData, hist(Global_active_power, col="red", 
                      xlab="Global Active Power (kilowatts)", 
                      ylab="Frequency", main="Global Active Power"))
#close the device
dev.off()
