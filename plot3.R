# Read file into R

library(lubridate)
library(dplyr)
##get information from the flat file
df <- read.table("C:\\Users\\thomas.myslinski\\Documents\\household_power_consumption.txt",header = TRUE, sep=";", stringsAsFactors=FALSE, dec=".")

##convert the data information to the correct date format
dt <- strptime(paste(df$Date, df$Time, sep=" "), "%d/%m/%Y %H:%M:%S")
df <- cbind(df, dt)

df$Date <- as.Date(df$Date, format = "%d/%m/%Y")

##Filter out the data needed for the graph
dfwork <- df %>%
  select(Date, Time, Global_active_power, Global_reactive_power, Voltage, Global_intensity, Sub_metering_1, Sub_metering_2, Sub_metering_3,dt) %>%
  filter(Date >= "2007-02-01" & Date <= "2007-02-02")



##Set the device to output the graph to a PNG file
png("plot3.png", height = 480, width = 480)

##Create the graph
plot(dfwork$dt, as.numeric(dfwork$Sub_metering_1), type = "l",xlab = "" ,ylab = "Energy Sub Metering")
lines(dfwork$dt, as.numeric(dfwork$Sub_metering_2), type = "l", col = "red")
lines(dfwork$dt, as.numeric(dfwork$Sub_metering_3), type = "l", col = "blue")

legend("topright",c("Sub_Metering_1","Sub_Metering_2","Sub_Metering_3"), lty= 1, lwd=5, col=c("black", "red","blue"))

##close the PNG device
dev.off()