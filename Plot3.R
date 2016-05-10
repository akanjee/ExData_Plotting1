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

## Plot 3 - 
par(mfrow=c(1,1))
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

#dev.size(units=c("px"))
#dev.new(width=480, height=480)
dev.copy(png,'plot3.png')
dev.off()