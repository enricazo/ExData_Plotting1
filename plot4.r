##########################
#Plot4
#Generates plots for
# "Global Active Power", "Voltage",
# "Energy sub mettering" and "Global Reactive Power" in png format

##########################
#File read section
##########################

rm(list=ls())
origwd <- getwd()

#setwd("C:\\Users\\enrique\\Downloads\\Coursera\\20150504 Exploratory Data Analysis\\Assignment 1")

if(!file.exists("data")) {
        dir.create("data")
}
if(!file.exists("./data/household_power_consumption.txt")) {
        fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
        download.file(fileUrl, destfile="./data/household_power_consumption.zip", mode="wb")
        unzip("./data/household_power_consumption.zip", exdir = "./data")
}

##########################
#Data subset section
##########################

full_data <- read.table("data/household_power_consumption.txt", 
           colClasses=c("character", "character", "numeric",
                        "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"),
           sep=";", header=TRUE,
           na.strings="?")

data <- full_data[which(full_data$Date == "1/2/2007" |full_data$Date == "2/2/2007"),]

x <- paste(data$Date,data$Time)
datetime<- strptime(x, "%d/%m/%Y %H:%M:%S")
data <- cbind(datetime,data)

##########################
#Plot section
##########################

#Need to set locale becase default in my computer is Spanish
Sys.setlocale("LC_TIME","English")

png("plot4.png",width=480,height=480,units="px",bg = "transparent")
par(mfrow = c(2, 2))

#1 Global Active Power
#2 Voltage
#3 Energy sub metering
#4 Global Reactive Power

with(data, {
     plot(x=datetime,
          y=Global_active_power,
          type="l",
          col="black",
          xlab="",
          ylab="Global Active Power"
          )
     plot(x=datetime,
          y=Voltage,
          type="l",
          col="black",
          xlab="datetime",
          ylab="Voltage"
          )
     plot(x=datetime,
          y=Sub_metering_1,
          type="l",
          col="black",
          xlab="",
          ylab="Energy sub metering"
          )
     lines(x=datetime,y=Sub_metering_2,type="l",col="red")
     lines(x=datetime,y=Sub_metering_3,type="l",col="blue")
     legend("topright", lty = c(1,1,1), bty="n",
            col = c("black", "blue", "red"),
            legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
     plot(x=datetime,
          y=Global_reactive_power,
          type="l",
          col="black")
     })

dev.off()

setwd(origwd)
