#Create plot2 (Create a line plot for time and Global Active Power)
library(lubridate)

elecpwconsump <- read.table("./household_power_consumption.txt",header = TRUE,sep = ";")
elecpwconsump$Date <- as.Date(as.character(elecpwconsump$Date),"%d/%m/%Y")
filteredelecdata <- subset(elecpwconsump,
                           as.POSIXlt(elecpwconsump$Date)$year == 107 
                           & months(elecpwconsump$Date) == "February" 
                           & as.POSIXlt(elecpwconsump$Date)$mday %in% c("1","2"))
filteredelecdata$Time <- ymd_hms(paste(filteredelecdata$Date,filteredelecdata$Time))

with(filteredelecdata,plot(Time,
                           as.numeric(as.character(Global_active_power)),
                           main = "",
                           ylab = "Global Active Power (kilowatt)",
                           type = "l")
     )
dev.copy(png,"plot2.png",w=480, h=480)
dev.off()