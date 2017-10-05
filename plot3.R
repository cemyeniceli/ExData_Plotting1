# Getting sqdlf to filter date values during the import of the dataset
# Uncomment the "install packages" line if sqdlf is not in the packages
# install.packages("sqldf")
library(sqldf)

# Importing dataset by filtering the date between 1/2/2007 and 2/2/2007
data <- read.csv.sql("household_power_consumption.txt",
                     "select * from file where Date = '1/2/2007' or Date = '2/2/2007' ",sep=";")

# Creating POSIXlt object from "Date" and "Time" variables
date_time = strptime(paste(data[,1], data[,2]), format = "%d/%m/%Y %H:%M:%S")

# Creating the line plot for Energy sub-metering vs time
plot(date_time, data[,7], type = "n", xlab = "", ylab = "Energy sub metering")
lines(date_time, data[,7], type = "l", col = "black")
lines(date_time, data[,8], type = "l", col = "red")
lines(date_time, data[,9], type = "l", col = "blue")
temp = legend("topright", legend = c("", "", ""), 
       col = c("black","red", "blue"), yjust = 1,
       lty = 1, xjust = 1, text.width = strwidth("Sub_meter"), y.intersp = 0.6)
text(temp$rect$left + temp$rect$w, temp$text$y,
     c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"), pos = 2)
# Copying plot to PNG file
dev.copy(png, file = "plot3.png")
dev.off()