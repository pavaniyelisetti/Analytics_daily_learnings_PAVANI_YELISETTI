#accessing the downloaded file by changing the location
getwd()

setwd("C:/Users/pavan/Downloads")
mvt <- read.csv("mvtWeek1.csv")
mvt

#Problem 1: Basic Exploration
# 1.1 Number of observations
nrow(mvt)

# 1.2 Number of variables
ncol(mvt)

# 1.3 Maximum ID
max(mvt$ID)

# 1.4 Minimum Beat
min(mvt$Beat)

# 1.5 Number of arrests
sum(mvt$Arrest == TRUE)

# 1.6 Number of crimes in ALLEY
sum(mvt$LocationDescription == "ALLEY")

#Problem 2: Dates
# Date format
mvt$Date[1]

# Convert Date
DateConvert <- as.Date(
  strptime(mvt$Date, "%m/%d/%y %H:%M")
)

summary(DateConvert)

# Extract Month & Weekday
mvt$Month <- months(DateConvert)
mvt$Weekday <- weekdays(DateConvert)
mvt$Date <- DateConvert

# Fewest thefts by month
table(mvt$Month)

# Most thefts by weekday
table(mvt$Weekday)

# Month with most arrests
table(mvt$Month[mvt$Arrest == TRUE])

#Problem 3: Visualization
# Histogram
hist(mvt$Date, breaks = 100,
     main = "Motor Vehicle Thefts in Chicago (2001–2012)",
     xlab = "Year")

# Arrests over time
boxplot(mvt$Date ~ mvt$Arrest,
        main = "Arrests Over Time",
        xlab = "Arrest Made",
        ylab = "Date")

# Proportion of arrests by year
prop.table(table(mvt$Arrest[mvt$Year == 2001]))[2]
prop.table(table(mvt$Arrest[mvt$Year == 2007]))[2]
prop.table(table(mvt$Arrest[mvt$Year == 2012]))[2]

#Problem 4: Top Locations
# Top locations
sort(table(mvt$LocationDescription), decreasing = TRUE)

# Subset Top 5
Topfive <- subset(
  mvt,
  LocationDescription %in% c(
    "STREET",
    "PARKING LOT/GARAGE (NON RESIDENTIAL)",
    "ALLEY",
    "GAS STATION",
    "DRIVEWAY - RESIDENTIAL"
  )
)

# Refresh factor
Topfive$LocationDescription <- factor(Topfive$LocationDescription)

# Arrest rates by location
m <- table(Topfive$LocationDescription, Topfive$Arrest)
prop.table(m, 1)

# Weekday patterns
n <- table(Topfive$LocationDescription, Topfive$Weekday)
prop.table(n, 1)

