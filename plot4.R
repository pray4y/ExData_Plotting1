library(data.table)
        ## package "data.table" is needed for fread() to work
interval <- difftime(as.POSIXct("2007-02-03"), as.POSIXct("2007-02-01"),
        units = "mins")
        ## time interval between 2007-02-01 and 2007-02-03 is 
        ## the total time from 2007-02-01 to 2007-02-02
rows <- as.numeric(interval)
        ## interval has 2880 minutes (every min as one unit)
data <- fread("household_power_consumption.txt", skip = "1/2/2007", 
              nrows = rows, na.strings = c("?", ""))
        ## read rows from 2007-02-01 to 2007-02-02, excluding NAs
Sys.setlocale(category = "LC_TIME", locale = "C")
        ## set the system language to English so that the y axis labels are 
        ## displayed in English
data$V1 <- as.POSIXct(paste(data$V1, data$V2), format = "%d/%m/%Y %H:%M:%S")
        ## paste date and time together; then convert Date&Time into a time 
        ## series in POSIXct format which R will automatically transform into 
        ## weekday labels on the x axis
par(mfcol = c(2, 2), mar = c(4, 5, 2, 1), cex = 0.6)
        ## organize all four plots based on an order that looks like
        ## 1  3
        ## 2  4
plot(x = data$V1, y = data$V3, type = "l", xlab = "", 
     ylab = "Global Active Power")
        ## top left plot
plot(data$V1, data$V7, type = "l", xlab = "", 
     ylab = "Energy sub metering", col = "black")
        points(data$V1, data$V8, type = "l", col = "red")
        points(data$V1, data$V9, type = "l", col = "blue")
        legend("topright", col = c("black", "red", "blue"), bty = "n", 
               lty = c("solid", "solid", "solid"), 
               legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
        ## bottom left plot
plot(x = data$V1, y = data$V5, type = "l", xlab = "datetime", ylab = "Voltage")
        ## plot a line chart with x, y labels
plot(x = data$V1, y = data$V4, type = "l", xlab = "datetime", 
        ylab = "Global_reactive_power")
        ## plot a line chart with x, y labels
dev.copy(png, file = "plot4.png")
        ## Copy the integrated plot 4 to a PNG file
dev.off()
        ## close the PNG device
