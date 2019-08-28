# Read file into R

library(lubridate)
library(dplyr)
##get information from the flat file
df <- read.table("C:\\Users\\thomas.myslinski\\Documents\\household_power_consumption.txt",header = TRUE, sep=";", stringsAsFactors=FALSE, dec=".")

##convert the data information to the correct date format
df$Date <- as.Date(df$Date, format = "%d/%m/%Y")

##Filter out the data needed for the graph
dfwork <- df %>%
  select(Date, Time, Global_active_power, Global_reactive_power, Voltage, Global_intensity, Sub_metering_1, Sub_metering_2, Sub_metering_3) %>%
  filter(Date >= "2007-02-01" & Date <= "2007-02-02")

##Set the device to output the graph to a PNG file
png("plot1.png", height = 480, width = 480)

##Create the graph 
hist(as.numeric(dfwork$Global_active_power), col = "red", main = "Global Active Power", xlab = "Global Active Power(kilowatts)")

##close the PNG device
dev.off()