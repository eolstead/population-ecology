### Dem_stochasticity_illustration.R

# Illustrate how abundance can affect demographic stochasticity 

# --------------------------------------------------------------------------------

### First, a single run of the simulation to illustrate how the population model works

 N            <- 200  # Set no. breeding pairs
 avgOffspring <- 2    # Set average no. offspring produced per pair 
 
# Use Poisson distribution to set the no. offspring produced by each pair

 nOffspring <- rpois(N, avgOffspring) # Establish the no. offspring born per pair and save as a vector

 mean(nOffspring) # compute the average no. offspring for all pairs
 hist(nOffspring) #

# Each offspring undergoes a Bernoulli trial (i.e., it survives or not)
# The no. of successful trials is a binomial count (i.e., no. surviving offspring)

 pSurv <- 0.5                                   # Set prob(survival) for each offspring
 nSurv <- rbinom(nOffspring, nOffspring, pSurv) # Determine no. offspring that survive for each pair
 
# Check a few values, compute the average per pair, sum the total offspring that survived

 head(nSurv)
 mean(nSurv) # should be near 1
 sum(nSurv)  # should be near N (200)
 
# Compare % change in no. offspring to starting N -- i.e., compute the change in N

(sum(nSurv) - N) / N*100   # % change in N ; should be near zero

# --------------------------------------------------------------------------------

### Second, 1000 runs of the same simulation
 
# Stochastic models are run many times to observe the full range of results possible
# Code below is the same as the run above, but adds a loop to control the no. simulations

 nSims <- 1000              # no. simulations

# Run for a population of N = 10000 then for N = 10 

 N <- 10000                 # set number of pairs in population
 # N <- 10  
 avgOffspring <- 2          # set average number of offspring produced per pair
 allOffspring <- numeric(0) # create object to hold total number of offspring produced in each run
 pSurv <- 0.5               # set prob survival for each offspring
 
 for (j in 1:nSims)         # Simulation loop to work through the runs, from 1 to nSims
     {
     nOffspring      <- rpois(N, avgOffspring)                # no. offspring for each pair
     nSurv           <- rbinom(nOffspring, nOffspring, pSurv) # no. offspring that survive for each pair
     allOffspring[j] <- sum(nSurv)                            # total number of offspring produced
     }

# Run the next three lines only after running N = 10000

 avgChange10000 <- (mean(allOffspring) - N) / N*100   # average % change in N 
 minChange10000 <- (min(allOffspring) - N) / N*100    # lowest % change in N 
 hist((allOffspring - N) / N*100, xlim=c(-125, 125), main='N = 10,000') # results from all simulations 
 
 ### Go back up, set N = 10, and rerun the simulation loop

# Run the next three lines only after running N = 10
 
 avgChange10 <- (mean(allOffspring) - N) / N*100      # average % change in N 
 minChange10 <- (min(allOffspring) - N) / N*100       # lowest % change in N 
 hist((allOffspring - N) / N*100, xlim=c(-125, 125), main='N = 10') # results from all simulations
 
 # Compare average % change in N for N = 10000 vs N = 10
 
 avgChange10000
 avgChange10
 
 # Compare worst case for % change in N for N = 10000 vs N = 10
 # The next bit is the key result!
 
 minChange10000
 minChange10

