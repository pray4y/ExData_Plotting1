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
hist(data$V3, col = "red", main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)", ylab = "frequency")
        ## plot a red histogram with a title and x,y labels
dev.copy(png, file = "plot1.png")
        ## Copy plot 1 to a PNG file
dev.off()
        ## close the PNG device