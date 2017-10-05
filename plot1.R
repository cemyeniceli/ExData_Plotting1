# Getting sqdlf to filter date values during the import of the dataset
# Uncomment the "install packages" line if sqdlf is not in the packages
# install.packages("sqldf")
library(sqldf)

# Importing dataset by filtering the date between 1/2/2007 and 2/2/2007
data <- read.csv.sql("household_power_consumption.txt",
                     "select * from file where Date = '1/2/2007' or Date = '2/2/2007' ",sep=";")

# Creating POSIXlt object from "Date" and "Time" variables
date_time = strptime(paste(data[,1], data[,2]), format = "%d/%m/%Y %H:%M:%S")

# Creating the histogram plot for "Global_active_power"
par(mar = c(5, 4, 4,2)) # margin parameters
hist(data[,3],
      col = "red",
      main = "Global Active Power",
      xlab = "Global Active Power (kilowatts)")

# Copying plot to PNG file
dev.copy(png, file = "plot1.png")
dev.off()