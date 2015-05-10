##########################
#Plot3
#Generates a histogram for "Global Active Power" in png format

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

png("plot3.png",width=480,height=480,units="px",bg = "transparent")

plot(x=data$datetime,
     y=data$Sub_metering_1,
     type="l",
     col="black",
     xlab="",
     ylab="Energy sub metering"
     )
lines(x=data$datetime,
     y=data$Sub_metering_2,
     type="l",
     col="red")
lines(x=data$datetime,
     y=data$Sub_metering_3,
     type="l",
     col="blue")
legend("topright", lty = c(1,1,1), col = c("black", "blue", "red"),
       legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

dev.off()

setwd(origwd)
