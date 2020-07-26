
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
subpower$Voltage=as.numeric(subpower$Voltage)
subpower$Global_reactive_power=as.numeric(subpower$Global_reactive_power)
# Create a new feature with the date and time as Date type
subpower$datetime=paste(subpower$Date,subpower$Time)
subpower$datetime=strptime(subpower$datetime,"%e/%m/%Y %H:%M:%S")
# Plot it
par(mar=c(5.1,4.1,4.1,2.1),mfcol = c(2,2))
subpower$Voltage=as.numeric(subpower$Voltage)
subpower$Global_reactive_power=as.numeric(subpower$Global_reactive_power)

with(subpower,plot(datetime,Global_active_power,type='l',
                   main='',ylab='Global Active Power',
                   xlab=''))
with(subpower,{plot(datetime,Sub_metering_1,type='l',
                    main='',ylab='Energy sub metering',
                    xlab='')

  lines(datetime,Sub_metering_2,col='red')
  lines(datetime,Sub_metering_3,col='blue')
  legend("topright",legend = c('Sub_metering_1','Sub_metering_2','Sub_metering_3'),
         col = c("black","red",'blue'), lty=1,cex=0.95,
         inset=-0.1,y.intersp=0.35, box.lty = 0, bg = 'transparent'
         )
})

###Observation
## Depending of your graphic configuration you can use this parameters
## in order to obtain the same asked graphic for the legend
# , box.lty = 0 ,cex=0.95, inset=.004,y.intersp=0.3 x=1170337018,
# y=40.35584 ,text.width=75500
## Vary a lot whether you are using jupyter or Rstudio

with(subpower,plot(datetime,Voltage,type='l',
                   main=''))
with(subpower,plot(datetime,Global_reactive_power,type='l',
                   main=''))
# Save it in a PNG file
dev.copy(png,"plot4.png", width=480, height=480)
dev.off()