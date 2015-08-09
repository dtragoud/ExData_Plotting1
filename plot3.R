## Read the full dataset
dataset1 <- read.csv("./exdata_data_household_power_consumption/household_power_consumption.txt", header=T, sep=';', na.strings="?", 
                     nrows=2075259, check.names=F, stringsAsFactors=F, comment.char="", quote='\"')

## Convert the Date variable to Date class in R (facilitate subsetting)
dataset1$Date <- as.Date(dataset1$Date, format="%d/%m/%Y")

## Subsetting the full dataset for the dates to be used for plotting
dataset2 <- subset(dataset1, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))

## Delete the full dataset
rm(dataset1)

## Convert the Time variable to Time class in R
datestimes <- paste(as.Date(dataset2$Date), dataset2$Time)
dataset2$DateTimes <- as.POSIXct(datestimes)

## Plot 3 the data using proper descriptives
with(dataset2, {
        plot(Sub_metering_1~DateTimes, type="l",
             ylab="Global Active Power (Kilowatts/KWs)", xlab="")
        lines(Sub_metering_2~DateTimes,col='Red')
        lines(Sub_metering_3~DateTimes,col='Blue')
})
legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

## Saving to file to a png with the proper dimensions
dev.copy(png, file="plot3.png", height=480, width=480)
dev.off()