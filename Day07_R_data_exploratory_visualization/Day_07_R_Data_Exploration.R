# Check working directory path
getwd()

# -----------------------------
# Step 1: Create sample dataset
# -----------------------------

country <- c("USA", "India", "Germany", "Brazil", "Australia", "Japan")
region <- c("North America", "Asia", "Europe", "South America", "Oceania", "Asia")
under <- c(5.2, 18.4, 4.9, 12.1, 3.8, 6.1)
over <- c(36.2, 22.5, 29.8, 26.4, 31.7, 24.3)
life_expectancy <- c(78.9, 69.7, 81.1, 75.9, 83.2, 84.6)

#Save It as a CSV
health_data <- data.frame(
  country,
  region,
  under,
  over,
  life_expectancy
)

health_data

#saving the file as csv
write.csv(health_data, "health_data.csv", row.names = FALSE)


#Read the File Back In
who <- read.csv("health_data.csv")

#checking the structure and summary of the file
str(who)
summary(who)

#ls gives names of all columns of the dataset
ls()
names(who)

#accesing a column and performing stats on it
who$under
mean(who$under)
summary(who$life_expectancy)
sd(who$over)

#subsetting data from the existing ones
asia_data <- subset(who, region == "Asia")
asia_data

#subsetting with multiple conditions
outliers <- subset(who, under > 10 & over > 25)
nrow(outliers)
outliers

#selecting specific columns
who_small <- who[c("country", "under", "over")]
who_small

#scatter plot
plot(
  who$under,
  who$over,
  xlab = "Underweight %",
  ylab = "Overweight %",
  main = "Underweight vs Overweight"
)

#Histogram
hist(
  who$life_expectancy,
  main = "Distribution of Life Expectancy",
  xlab = "Life Expectancy",
  col = "lightblue"
)

#boxplot
boxplot(
  who$life_expectancy ~ who$region,
  xlab = "Region",
  ylab = "Life Expectancy",
  main = "Life Expectancy by Region"
)

#tables and grouped analysis
table(who$region)

tapply(who$over, who$region, mean)

tapply(who$life_expectancy, who$region, summary)


#creating indicator variables
who$HighUnder <- as.numeric(who$under > mean(who$under))
who$HighOver <- as.numeric(who$over > mean(who$over))

str(who)
who

