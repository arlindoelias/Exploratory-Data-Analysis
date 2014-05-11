
## EXPLORATORY DATA ANALYSIS: COURSE PROJECT 1
## 
## Code for PLOT 04


# 1.Set Working directory and Data processing
setwd("C:/Users/Arlindo Elias/Doutorado/Coursera/Data_Science/4. EDA/Projects")
Sys.setlocale(category = "LC_TIME", locale = "C") # changing system to plot weekdays in english abbreviation



# 1.1 Loading dataset with the required time lapse (01/02/2007 00:00:00  to  02/02/2007 23:59:59 )
dpower <- read.table("household_power_consumption.txt", skip=66637, nrows=2880, sep=";")
View(dpower) 
head(dpower) # Verify the beginning of the dataset
tail(dpower) # Verify the end of the dataset



# 1.2 Transforming variable names
names(dpower)
varnames <- c("date", "time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity",
              "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
names(dpower) <- varnames
names(dpower) <- tolower(names(dpower))
head(dpower) # Check if the variable names were properly changed



# 1.3 Checking varible classes and creating the 'datetime' variable
sapply(dpower[1,], class)

# COMMENT: The date and time variables are classified as factors
dpower$datetime <- as.POSIXlt(paste(dpower$date, dpower$time, sep=" "), format="%d/%m/%Y %H:%M:%S")
dpower$date <- NULL
dpower$time <- NULL

names(dpower) <- tolower(names(dpower))



#1.4 Verify NA entries
for(i in 1:9){
        natab <- table(is.na(dpower[,i]))
        print(natab)
}
# The dataset don't have NA entries


##################

# 2. PLOTS


# 2.4  PLOT4
png(file="plot4.png", width=480, height=480)
par(mfcol=c(2,2)) # Graph window filled column-wise

# First graph
hist(dpower$global_active_power, main= "", xlab="Global Active Power (Kilowatts)", 
     cex.lab=1, col="red")

# Second graph
plot(dpower$datetime, dpower$sub_metering_1, type="l", ylab="Energy sub metering", 
     xlab="", cex.axis=0.9, cex.lab=1)
lines(dpower$datetime, dpower$sub_metering_2, type="l", col="blue")
lines(dpower$datetime, dpower$sub_metering_3, type="l", col="red")
legend("topright", lty=1, legend= c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       col = c("black","blue", "red"), cex=.9, adj=c(0,.5), xjust=.5, bty="n")

# Third Graph
plot(dpower$datetime, dpower$voltage, type="l", ylab="Voltage", 
     xlab="datetime", cex.axis=0.9, cex.lab=1)


# Fourth Graph
plot(dpower$datetime, dpower$global_reactive_power, type="l", ylab="global_reactive_power", 
     xlab="datetime", cex.axis=0.9, cex.lab=1)
dev.off()
