# Use data.table library for big tables
library("data.table")
power<-fread("household_power_consumption.txt",sep=";",dec=".",na.strings="?")
# Filter the required data and convert it to data.frame
subpower<-power[(Date=="1/2/2007" | Date=="2/2/2007")]
subpower<-data.frame(subpower)
# Transform the feature I'm going to use to numeric
subpower$Global_active_power=as.numeric(subpower$Global_active_power)
# Create a new feature with the date and time as Date type
subpower$datetime=paste(subpower$Date,subpower$Time)
subpower$datetime=strptime(subpower$datetime,"%e/%m/%Y %H:%M:%S")
# plot it
with(subpower,plot(datetime,Global_active_power,type='l',
                   main='',ylab='Global Active Power (Kilowatts)',
                   xlab=''))
# Save it in a PNG file
dev.copy(png,"plot2.png", width=480, height=480)
dev.off()