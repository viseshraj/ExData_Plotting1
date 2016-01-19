#Create multiple plots
library(lubridate)
library(grDevices)

elecpwconsump <- read.table("./household_power_consumption.txt",header = TRUE,sep = ";")
elecpwconsump$Date <- as.Date(as.character(elecpwconsump$Date),"%d/%m/%Y")
filteredelecdata <- subset(elecpwconsump,
                           as.POSIXlt(elecpwconsump$Date)$year == 107 
                           & months(elecpwconsump$Date) == "February" 
                           & as.POSIXlt(elecpwconsump$Date)$mday %in% c("1","2"))
filteredelecdata$Time <- ymd_hms(paste(filteredelecdata$Date,filteredelecdata$Time))

#Initialize the PNG graphic file device
png("plot4.png",width = 480 , height = 480)
par(mfrow = c(2,2))
#First plot
with(filteredelecdata,plot(Time,
                           as.numeric(as.character(Global_active_power)),
                           main = "",
                           ylab = "Global Active Power (kilowatt)",
                           xlab = "",
                           type = "l"))
#Second plot
with(filteredelecdata,plot(Time,
                           as.numeric(as.character(Voltage)),
                           main = "",
                           ylab = "Voltage",
                           xlab = "datetime",
                           type = "l"))
#Third plot
with(filteredelecdata,
     plot(Time,
          as.numeric(as.character(Sub_metering_1)),
          ylab = "Energy sub metering",
          xlab = "",
          type = "l"))
lines(filteredelecdata$Time,
      as.numeric(as.character(filteredelecdata$Sub_metering_2)),
      col="red")
lines(filteredelecdata$Time,
      as.numeric(as.character(filteredelecdata$Sub_metering_3)),
      col="blue")
legend("topright",
       lty = c(1,1,1),
       col = c("black","red","blue"),
       legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       lwd = 1,
       cex = 0.7)
#Fourth plot
with(filteredelecdata,plot(Time,
                           as.numeric(as.character(Global_reactive_power)),
                           main = "",
                           ylab = "Global_reactive_power",
                           xlab = "datetime",
                           type = "l"))
dev.off()