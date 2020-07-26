# Use data.table library for big tables
library("data.table")
power<-fread("household_power_consumption.txt",sep=";",dec=".",na.strings="?")
# Filter the required data and convert it to data.frame
subpower<-power[(Date=="1/2/2007" | Date=="2/2/2007")]
subpower<-data.frame(subpower)
# Transform the feature I'm going to use to numeric
subpower$Sub_metering_1=as.numeric(subpower$Sub_metering_1)
subpower$Sub_metering_2=as.numeric(subpower$Sub_metering_2)
subpower$Sub_metering_3=as.numeric(subpower$Sub_metering_3)
# Create a new feature with the date and time as Date type
subpower$datetime=paste(subpower$Date,subpower$Time)
subpower$datetime=strptime(subpower$datetime,"%e/%m/%Y %H:%M:%S")
# Plot it
with(subpower,{plot(datetime,Sub_metering_1,type='l',
                    main='',ylab='Energy sub metering',
                    xlab='')
  lines(datetime,Sub_metering_2,col='red')
  lines(datetime,Sub_metering_3,col='blue')
  legend("topright",legend = c('Sub_metering_1','Sub_metering_2','Sub_metering_3'),
         col = c("black","red",'blue'), lty=1, cex=0.95,y.intersp=0.7
         ,text.width=37000)
})
# Save it in a PNG file
dev.copy(png,"plot3.png", width=480, height=480)
dev.off()