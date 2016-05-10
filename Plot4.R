setwd("~/Documents/R Working Directory/Exploratory_Data_Analytis")
fulldataset<-read.csv(file="household_power_consumption.txt", header=TRUE, sep=";",na.strings="?") ## Load the file
fulldataset$DateTime <-paste(fulldataset$Date, fulldataset$Time) # Concatenate the Date & Time Strings into a common DateTime Field
fulldataset$DateTime <-as.POSIXlt(fulldataset$DateTime, format="%d/%m/%Y %H:%M:%S") ## Convert the DATETIME string into a date and time field
fulldataset$Date <-as.Date(fulldataset$Date,"%d/%m/%Y")
fulldataset<-na.omit(fulldataset)
df1<-subset(fulldataset,Date=='2007-02-01') ## Select only the entries where the data is equal to 1/2/2007
df2<-subset(fulldataset,Date=='2007-02-02') ## Selctt only the entries where the date is equal to 2/2/2007
fulldataset <-0 ## remove the full table from memory
df3<-rbind(df1,df2) ## Create a single data set with the two dates
df4<-na.omit(df3)   ## Get rid of the NAs


## Plot 4 - Puttig them all together
par(mfcol=c(2,2))    ## Set the item to plot in 2 x 2 chart

# Plot the first chart (1,1)
plot(df4$DateTime,
     as.double(df4$Global_active_power),
     type="l",
     col="black",
     xlab="",
     ylab="Global Active Power (Kilowatts)",
     pch="null")

## Plot the chart (1,2)
with(df4, 
     plot(df4$DateTime,
          as.double(df4$Sub_metering_1),
          type="l",
          col="black",
          xlab="",
          ylab="Energy in Sub Metering",
          pch="null"))
with(df4, points(
    df4$DateTime,
    as.double(df4$Sub_metering_2),
    type="l",
    col="blue",
    pch="null"))
with(df4, points(
    df4$DateTime,
    as.double(df4$Sub_metering_3),
    type="l",
    col="red",
    pch="null")
)
legend("topright",pch="___",col=c("black","blue","red"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

# Plot (2,1)
plot(df4$DateTime,
     as.double(df4$Voltage),
     type="l",
     col="black",
     xlab="datetime",
     ylab="Voltage",
     pch="null")

# Plot (2,2)
plot(df4$DateTime,
     as.double(df4$Global_reactive_power),
     type="l",
     col="black",
     xlab="datetime",
     ylab="Global_reactive_power",
     pch="null")

#dev.size(units=c("px"))
#dev.new(width=480, height=480)
dev.copy(png,'plot4.png')
dev.off()