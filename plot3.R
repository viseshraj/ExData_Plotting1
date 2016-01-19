#Create sub-metering plot
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
png("plot3.png",width = 480, height = 480)

with(filteredelecdata,
     plot(Time,
          as.numeric(as.character(Sub_metering_1)),
          ylab = "Energy sub metering",
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
       lwd = 1,cex = 0.7)
dev.off()