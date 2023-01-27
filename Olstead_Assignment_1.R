### Assignment 1. Complete this exercise during lab and submit this file via D2L.  

### Before you begin, please read/work through the Introduction to R pdf on D2L

### 1. Insert the appropriate R code below each comment or answer the question asked

# Add 8 plus 7 and send the result to the console

8+7

# Create the object x and assign it the result of 8 plus 7

x <- 8+7

# Create the object y and assign it the result of the function square root of nine

y <- sqrt(9)

# Create the object z and assign it the result of x divided by y

z <- x/y

# Raise z to the third power and send the result to the console

z^3

# What is the name of an R object that holds only one value? 
# Your answer: scalar


# What is the name of an R object that holds multiple values of the same type, such as a number? 
# Your answer: vector


# Create the object num.vec that contains the values 1, 3, 5, 7

num.vec <- c(1,3,5,7)

# Multiply three times each value in num.vec and send the result to the console

num.vec*3

# Execute the line below to create the object heights ; Note, NA is the value
# used by R to identify missing data 

heights <- c(63, 69, 60, 65, NA, 68, 61, 70, 61, 59, 64, 69, 63, 63, NA, 72, 65, 64, 70, 63, 65)


# Use the mean() function to calculate the mean value in height and send the result to the console

mean(heights)

# This should yield an odd result caused by the NAs; to resolve this, use the help function
# to learn about the argument na.rm = TRUE that applies to many R functions

help(mean)

# Below, issue a revised command to calculate the mean value of height and send the result to the console

mean(heights, na.rm=TRUE)

# Execute the line below

heights_above_67 <- heights[heights > 67]

# What does this line do?
# Answer: It creates the object heights_above_67, which contains all values for heights above 67.


# Execute the two lines below

length(heights)
length(heights_above_67)

# What do these lines tell us?
# Answer: They tell us how many height values are in each object, with there being 21 in the first object and 8 in the second. 



# Create the object char.vec that contains the values A, C, D, C

char.vec <- c('A','B','C','D')

# Issue the lines below

char.vec == 'C'
char.vec != 'C'

# What do these lines do?
# Answer: The first line returns true or false depending on which values in the vector are equal to 'C.' It returns true for 'C' and false for other values.
# The second line returns true or false depending on what values in the vector are not equal to 'C,' returning true for those that are not 'C.'


 
### 2. Create each of the four objects described below, then assemble them into a data frame
 
# Plot:	  sequential integers, 1-250 to represent IDs for 250 simulated plots
# X1:	    250 random numbers drawn from a normal distribution with mean=50 and SD=5
# X2:	    250 random numbers drawn from a Poisson distribution with mean=2.5 
# Log_X2: natural log of X2

plot <- seq(1, 250, by=1)
X1 <- rnorm(250, mean=50, sd=5)
X2 <- rpois(250, 2.5)
Log_X2 <- log(X2)

### When you are finished, save this script, then upload the script file to D2L
### Unless you have changed your working directory with the setwd() function, 
###  you should find your script file there 
### Issue the line below to see the location set as your working directory

getwd()

