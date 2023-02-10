### Estimating lambda from abundance data

# Transform a single value (a scalar) to a different scale

log(100)
x <- 100        # assign a value to object x (a vector of length = 1)
log.x <- log(x) # apply natural log function (base e = 2.718...) to object x
log.x           # view contents of log.x

# What's going on here?

log(-1)
log(0)

# Create a vector of values between 0.1 and 100; plot these and their logged values

z <- seq(0.1, 100, by = 0.1)
plot(z, log(z), typ = "l", col = "blue")
abline(v = 0, col = "red", lty = 2) # abline() adds a line to the plot

# Backtransform to the original scale

y <- exp(log.x)  # apply exponential function to raise log.x to the base e
y                # view

# Transform all values in a vector to a different scale

z <-rnorm(100, 50, 5)   # Create n = 100 random values from normal dist with mean = 50, SD = 5
hist(z)                 # Create histogram

log.z <- log(z)         # apply natural log function to vector z 
hist(log.z)

exp.log.z <- exp(log.z) # back-transform
hist(exp.log.z)


# Estimate lambda from abundance data collected over time
# Example from lecture: Human population, 1950-1995

N  <- c(2.51, 3.62, 3.97, 4.41, 4.84, 5.29, 5.75) # billions
yr <- c(1950, 1970, 1975, 1980, 1985, 1990, 1995)

plot(yr, N)   # plot the raw data -- plot() wants the values for the x-axis first

lnN <- log(N) # natural log transform of values in vector N

plot(yr, lnN) # plot transformed values of N

lm(lnN ~ yr) # fit a linear regression model and output results to console

lrm <- lm(lnN ~ yr) # fit same model but save results to an object

### R saves lots of information from models

lrm             # shows little by default when we view contents of the object
names(lrm)      # list of names of the attributes associated with an object
summary(lrm)    # a more complete summary of model results

# We can access specific portions of model objects

summary(lrm)$coefficients        # summary of estimated model coefficients (here, slope and intercept)
class(summary(lrm)$coefficients) # tells us how the object is stored in R
summary(lrm)$coefficients[ ,1:2] # shows all rows and first two columns in the object (a matrix)
summary(lrm)$coefficients[2,1:2] # shows second row and first two columns -- here, the slope and SE
summary(lrm)$coefficients[2,1]   # shows second row and first column subset -- here, the slope
coef(lrm)                        # another option to display the model coefficients

(est <- summary(lrm)$coefficients[2,1])            # Save estimate of slope (it is on ln scale)
(orig.est <- exp(summary(lrm)$coefficients[2,1]))  # Save on original scale after backtransforming

### Plot the fitted line, which is a model of the relationship between ln(N) and Year

plot(yr, lnN)  # plot transformed values of N
abline(lrm)    # add the fitted line from the model to the plot


### To copy a plot and paste a plot into a MS Word document:

#  - Click the Export icon above the plot
#  - Choose 'Copy to clipboard'
#  - Choose 'Copy plot'
#  - In Word, click the 'Paste' icon or use the ctrl-v shortcut
#  - To resize it, click on the image, select a corner with the mouse, and drag it

