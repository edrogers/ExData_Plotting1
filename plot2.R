## plot2.R - ExData_Plotting1 - 8 May 2015
##
## This code is to be run in a directory along 
## with the "household_power_consumption.txt"
## file, which must be unzipped.
## It loads the entire file into memory as a
## data.frame, so it may not perform well on
## older machines
##

## First, load the file contents into memory
householdPowerConsumption <- read.table(file = "household_power_consumption.txt", sep = ";", na.strings = "?", header = TRUE)

## Copy to a second data.frame, merging the
## first two columns into a single, POSIXct
## column.
timeHouseholdPowerConsumption <- cbind(as.POSIXct(strptime(do.call(paste,c(householdPowerConsumption[,1:2],sep = " ")),format = "%d/%m/%Y %T")),householdPowerConsumption[,c(3,4,5,6,7,8,9)])

## Fix the ugly column name left by cbind
newColNames <- colnames(timeHouseholdPowerConsumption)
newColNames[1] <- "Time"
colnames(timeHouseholdPowerConsumption) <- newColNames

## Subset data.frame to relevant dates only
startDate <- as.POSIXct("2007-02-01")
stopDate  <- as.POSIXct("2007-02-03")
rowsInSubset <- (timeHouseholdPowerConsumption$Time >= startDate) & 
                (timeHouseholdPowerConsumption$Time < stopDate)
subsetHouseholdPowerConsumption <- timeHouseholdPowerConsumption[rowsInSubset,]

## Make Plot 2:
png("plot2.png")
plot(subsetHouseholdPowerConsumption$Time,
     subsetHouseholdPowerConsumption$Global_active_power, 
     type="l",xlab="",ylab="Global Active Power (kilowatts)")
dev.off()
