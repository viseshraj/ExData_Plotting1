#Create Plot1 (Histogram of Global Active Power for 1st and 2nd Feb 2007)

elecpwconsump <- read.table("./household_power_consumption.txt",header = TRUE,sep = ";")
elecpwconsump$Date <- as.Date(as.character(elecpwconsump$Date),"%d/%m/%Y")
filteredelecdata <- subset(elecpwconsump,
                    as.POSIXlt(elecpwconsump$Date)$year == 107 
                    & months(elecpwconsump$Date) == "February" 
                    & as.POSIXlt(elecpwconsump$Date)$mday %in% c("1","2"))
hist(as.numeric(as.character(filteredelecdata$Global_active_power)),
     xlab = "Global Active Power (kilowatts)",
     col = "red",
     main="Global Active Power")
dev.copy(png,file="plot1.png",w=480, h=480)
dev.off()