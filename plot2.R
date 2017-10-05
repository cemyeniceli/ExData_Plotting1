# Getting sqdlf to filter date values during the import of the dataset
# Uncomment the "install packages" line if sqdlf is not in the packages
# install.packages("sqldf")
library(sqldf)

# Importing dataset by filtering the date between 1/2/2007 and 2/2/2007
data <- read.csv.sql("household_power_consumption.txt",
                     "select * from file where Date = '1/2/2007' or Date = '2/2/2007' ",sep=";")

# Creating POSIXlt object from "Date" and "Time" variables
date_time = strptime(paste(data[,1], data[,2]), format = "%d/%m/%Y %H:%M:%S")

# Creating the line plot for "Global_active_power" vs time
par(mar = c(5, 4.5, 4,2)) # margin parameters
plot(date_time, data[,3], type = "n", xlab = "", ylab = "Global Active Power (kilowatts)")
lines(date_time, data[,3], type = "l")

# Copying plot to PNG file
dev.copy(png, file = "plot2.png")
dev.off()