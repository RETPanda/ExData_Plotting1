# activate packages
library(data.table)
library(lubridate)

# reading data 
variable.class<-c(rep('character',2),rep('numeric',7))
power.consumption<-read.table('household_power_consumption.txt',header=TRUE,sep=';',na.strings='?',colClasses=variable.class)
# select two days from dataset
power.consumption<-power.consumption[power.consumption$Date=='1/2/2007' | power.consumption$Date=='2/2/2007',]

# rename variables
cols<-c('Date','Time','GlobalActivePower','GlobalReactivePower','Voltage','GlobalIntensity',
        'SubMetering1','SubMetering2','SubMetering3')
colnames(power.consumption)<-cols

# change date descriptions 
power.consumption$DateTime<-dmy(power.consumption$Date)+hms(power.consumption$Time)
power.consumption<-power.consumption[,c(10,3:9)]

# open png device
png(filename='plot2.png',width=480,height=480,units='px')

# plot graph
plot(power.consumption$DateTime,power.consumption$GlobalActivePower,ylab='Global Active Power (kilowatts)', xlab='', type='l')

# close device 
x<-dev.off()
