# Sets working directory
setwd("C:/Users/andre/Desktop/CMSC197/specdata/household_power_consumption_data")

#Packages 
require("data.table")

#Load Data
my_file <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?")
extractedData <- my_file[grep("^[1,2]/2/2007", my_file$Date), ]
dateTime <- strptime(paste(extractedData$Date, extractedData$Time, sep = " "), "%d/%m/%Y %H:%M:%S")
final_data <- cbind(dateTime, extractedData)


#Plot 1
plot1 <- function(){
  hist(final_data$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)", ylab = "")
}

#Plot2
plot2 <- function(){
  plot(final_data$dateTime, final_data$Global_active_power, type = "l", col = "black", xlab = "", ylab = "Global Active Power (kilowatts)")
}

#Plot3
plot3 <- function(){
  plot(final_data$dateTime, final_data$Sub_metering_1, type = "l", col = "black", xlab = "", ylab = "Energy sub metering")
  lines(final_data$dateTime, final_data$Sub_metering_2,  col = "red")
  lines(final_data$dateTime, final_data$Sub_metering_3, col = "blue") 
  legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lty = "solid")
}

#Plot 4
plot4 <- function(){
  par(mfrow = c(2, 2), mar = c(4, 4, 2, 1), oma = c(0, 0, 2, 0))
  plot2()
  plot(final_data$dateTime, final_data$Voltage, type = "l", col = "black", xlab = "datetime", ylab = "Voltage")
  plot3()
  plot(final_data$dateTime, final_data$Global_reactive_power, type = "l", col = "black", xlab = "datetime", ylab = "Global_reactive_power")
}

#Display the plots
plot1()
plot2()
plot3()
plot4()

#Generate png files
plot_png <- c("plot1()", "plot2()", "plot3()", "plot4()")
for(i in 1:length(plot)){
  png(paste0("C:/Users/andre/Desktop/CMSC197/specdata/household_power_consumption_data/plot",i,".png"), width = 1000, height = 1000)
  eval(parse(text = plot_png[i]))
  dev.off()
}


