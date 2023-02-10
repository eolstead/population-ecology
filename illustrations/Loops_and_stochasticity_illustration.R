### Loops_and_stochasticity_illustration.R

### Loops are one way to execute a set of commands multiple times

### One common loop type is a 'for' loop, which executes a set of commands for a fixed number of times.
#  The number of times is set with a loop index or counter that is incremented after each loop cycle.

 for (i in 1:5) { print(i) }   # an object (here, i) is identified as the loop index to
                               #  track the cycle number (here i goes from 1 to 5)
                               # commands in brackets { } are what is executed

 for (z in 1:5) { print(1:z) } # here, z is used as the name for the loop index


### Tip: defining objects can make your code more convenient

# Define loop indexes and other variables as objects rather than using the actual numbers 
# in the script. So if you want to use the script with different values, you need only change the 
# values once where you define them rather than changing them everywhere they occur in the script.

 n.runs <- 5
 for (i in 1:n.runs) { print(i) }  # executes the loop 5 times

 n.runs <- 500
 for (i in 1:n.runs) { print(i) }  # executes the loop 500 times


### --- Project abundance through time for birth-pulse species when resources are not limited --- ###
 
 # Basic form: Nt+1 = Nt * lambda
 
 ### Define objects and assign starting values

 nYears <- 100            # number of years for the projection
 lambda <- 1.25           # growth rate
 N      <- rep(0, nYears) # create vector N to hold computed values; fill it with zeroes
 N[1]   <- 2              # assign starting value of N in year 1 to the first value in the vector
 N                        # check values in the vector
 
 
### Define the loop and the sequences of commands between {}

 for (t in 1:nYears)
    { 
      N[t+1] <- N[t] * lambda   # compute N for next time interval -- compare to basic form above
      print(round(N[t+1],0))    # print the value to the console after rounding to 0 decimal places
    }

 ### Plot the results
 
 yrs   <- 1:(nYears+1)    # establish values to represent year
 plot(yrs,N)              # plot projection of N
 plot(yrs, log(N))        # plot projection of ln(N)


### --- Add stochastic variation to lambda for the projection --- ###

# Define objects to hold the lower and upper limits for lambda

 lowerLim <- lambda - 0.35
 upperLim <- lambda + 0.35

 hist(runif(1000, lowerLim, upperLim))  # illustrate the range of possible values for lambda

 for (t in 1:nYears)
    { 
      N[t+1] <- N[t] * runif(1, lowerLim, upperLim) # lambda is a random value from a uniform distribution
    }

 yrs   <- 1:(nYears+1)    # establish values to represent year
 plot(yrs,log(N))         # plot ln(N) projection


### Use regression to estimate lambda with data from the stochastic projection

lrm   <- lm(log(N) ~ yrs)               # fit regression model -- remember to use log(N) not N
slope <- summary(lrm)$coefficients[2,1] # extract the estimated slope 
(estlambda <- exp(slope))               # backtransform to original scale -- should be near value of lambda

abline(lrm, col='blue', lwd=2)          # add the fitted line to the plot


