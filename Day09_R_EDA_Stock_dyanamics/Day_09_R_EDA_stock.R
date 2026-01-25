# STOCK DYNAMICS

# Load files
IBM <- read.csv("IBMStock.csv")
GE <- read.csv("GEStock.csv")
ProcterGamble <- read.csv("ProcterGambleStock.csv")
CocaCola <- read.csv("CocaColaStock.csv")
Boeing <- read.csv("BoeingStock.csv")

summary(IBM)
summary(GE)
summary(ProcterGamble)
summary(CocaCola)
summary(Boeing)

# Problem 1.1 - Summary Statistics
IBM$Date = as.Date(IBM$Date, "%m/%d/%y")
GE$Date = as.Date(GE$Date, "%m/%d/%y")
CocaCola$Date = as.Date(CocaCola$Date, "%m/%d/%y")
ProcterGamble$Date = as.Date(ProcterGamble$Date, "%m/%d/%y")
Boeing$Date = as.Date(Boeing$Date, "%m/%d/%y")

## Q.1.1: Our five datasets all have the same number of observations. How many 
## observations are there in each data set?
str(IBM)
str(GE)
str(CocaCola)
str(ProcterGamble)
str(Boeing)
## 480 observations

# Problem 1.2 - Summary Statistics
## Q.1.2: What is the earliest year in our datasets?
summary(IBM)
summary(GE)
summary(CocaCola)
summary(ProcterGamble)
summary(Boeing)
## 1970

# Problem 1.3 - Summary Statistics
## Q.1.3: What is the latest year in our datasets?
## 2009(from previous question)

# Problem 1.4 - Summary Statistics
## Q.1.4: What is the mean stock price of IBM over this time period?
summary(IBM)
## 144.38(from previous question)

# Problem 1.8 - Summary Statistics
## Q.1.8: What is the standard deviation of the stock price of Procter & Gamble 
## over this time period?
sd(ProcterGamble$StockPrice)
## 18.19414

#Visualizing Stock Dynamics
## add the argument type="l" to your plot command, and re-generate the plot (the 
## character is quotes is the letter l, for line). You should now see a line 
## plot of the Coca-Cola stock price.
plot(CocaCola$Date, CocaCola$StockPrice, type = "l")

#You can add a line to a 
## plot in R by using the lines function instead of the plot function. Keeping 
## the plot for Coca-Cola open, type in your R console:
lines(ProcterGamble$Date, ProcterGamble$StockPrice)

plot(CocaCola$Date, CocaCola$StockPrice, type = "l", col = "red")
lines(ProcterGamble$Date, ProcterGamble$StockPrice, col = "blue")

#This generates a vertical line 
## at the date March 1, 2000. The argument lwd=2 makes the line a little 
## thicker. You can change the date in this command to generate the vertical 
## line in different locations.
abline(v=as.Date(c("2000-03-01")), lwd=2, lty = 2)
## some options for changing the line type: lty=2 will make the line dashed, 
## lty=3 will make the line dotted, lty=4 will make the line alternate between 
## dashes and dots, and lty=5 will make the line long-dashed.

## color options are "red", "blue", "green", "purple", "orange", and "black". 
## To see all of the color options in R, type colors() in your R console.
plot(CocaCola$Date[301:432], 
     CocaCola$StockPrice[301:432], 
     type="l", 
     col="red", 
     ylim=c(0,210))
lines(ProcterGamble$Date[301:432], 
      ProcterGamble$StockPrice[301:432], 
      col = "blue")
lines(IBM$Date[301:432], 
      IBM$StockPrice[301:432], 
      col = "green")
lines(GE$Date[301:432], 
      GE$StockPrice[301:432], 
      col = "orange")
lines(Boeing$Date[301:432], 
      Boeing$StockPrice[301:432], 
      col = "black")
abline(v=as.Date(c("2000-03-01")), lty = 2)

# Problem 4.1 - Monthly Trends
## Use the tapply command to calculate the mean stock price of IBM, sorted by 
## months. 
tapply(IBM$StockPrice, months(IBM$Date), mean)
mean(IBM$StockPrice)

# Problem 4.2 - Monthly Trends
tapply(GE$StockPrice, months(GE$Date), mean)
tapply(ProcterGamble$StockPrice, months(ProcterGamble$Date), mean)
tapply(CocaCola$StockPrice, months(CocaCola$Date), mean)
tapply(Boeing$StockPrice, months(Boeing$Date), mean)

## Q.4.2: General Electric and Coca-Cola both have their highest average stock 
## price in the same month. Which month is this?
tapply(GE$StockPrice, months(GE$Date), mean)
tapply(CocaCola$StockPrice, months(CocaCola$Date), mean)
## April


# Problem 4.3 - Monthly Trends
## For the months of December and January, every company's average stock is 
## higher in one month and lower in the other. In which month are the stock 
## prices lower?
tapply(IBM$StockPrice, months(IBM$Date), mean)
tapply(GE$StockPrice, months(GE$Date), mean)
tapply(ProcterGamble$StockPrice, months(ProcterGamble$Date), mean)
tapply(CocaCola$StockPrice, months(CocaCola$Date), mean)
tapply(Boeing$StockPrice, months(Boeing$Date), mean)