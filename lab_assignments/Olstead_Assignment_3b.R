# data and plot

Year <- c(1850,1860,1870,1880,1890,1900,1910,1920,1930,1940,1950,1960,1970,1980,1990,2000,2010,2020)
People <- c(400,915,3215,7007,5150,7531,13193,20292,32506,35752,45454,212892,262933,330537,405371,486699,520116,542629)
plot(Year,People)

# rate of change

lnPeople <- log(People)
lm(lnPeople~Year)
lrm <- lm(lnPeople~Year)
tlambda <- 0.04194    # transformed lambda
lambda <- exp(tlambda)   # backtransformed lambda

# estimate using for loop

nYears <- 20
N <- rep(0, nYears)
N[1] <- 542629
N

for (t in 1:nYears)
{ 
  N[t+1] <- N[t] * lambda   
  print(round(N[t+1],0))    
}

Years   <- 1:(nYears+1)   
plot(Years,N)             

# stochastic variation

lowerLim <- lambda - 0.10
upperLim <- lambda + 0.10

hist(runif(1000, lowerLim, upperLim))  # illustrate the range of possible values for lambda

for (t in 1:nYears)
{ 
  N[t+1] <- N[t] * runif(1, lowerLim, upperLim) # lambda is a random value from a uniform distribution
}

yrs   <- 1:(nYears+1)    # establish values to represent year
plot(yrs,log(N))         # plot ln(N) projection

# revised model with carrying capacity

nYears <- 20
N <- rep(0, nYears)
N[1] <- 542629
N
K <- 1000000

for (t in 1:nYears)
{ 
  N[t+1] <- N[t] * (lambda^(1-(N[t]/K)))   
  print(round(N[t+1],0))    
}

Years   <- 1:(nYears+1)   
plot(Years,N)         
