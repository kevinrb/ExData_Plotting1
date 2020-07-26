# Use data.table library for big tables
library("data.table")
power<-fread("household_power_consumption.txt",sep=";",dec=".",na.strings="?")
# Filter the required data and convert it to data.frame
subpower<-power[(Date=="1/2/2007" | Date=="2/2/2007")]
subpower<-data.frame(subpower)
# Transform the feature I'm going to use to numeric
subpower$Global_active_power=as.numeric(subpower$Global_active_power)
# plot it
with(subpower,hist(Global_active_power,col='red',
                   main='Global Active Power',
                   xlab='Global Active Power (Kilowatts)'))
# Save it in a PNG file
dev.copy(png,"plot1.png", width=480, height=480)
dev.off()