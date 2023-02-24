# Matrix operations in R, part 2: Matrix_illustrations_2.R

# ----------------------------------------------------------------------------
#    Deterministic Lefkovich Matrix for Northern Spotted Owls
# ----------------------------------------------------------------------------

J_Fecund <- 0.09
S_Fecund <- 0.20
A_Fecund <- 0.33

J_Surv <- 0.325
S_Surv <- 0.857
A_Surv <- 0.876

NSO <- matrix(data=c(J_Fecund, S_Fecund, A_Fecund, 
                       J_Surv,        0,        0,
                            0,   S_Surv,  A_Surv), byrow=T, nrow=3, ncol=3)

Lambda_eigen <- eigen(NSO)
Re(Lambda_eigen$values[1])

# original lambda: 0.987

### Sensitivities

# Add 0.1 (or any small constant) to each vital rate individually, then recompute lambda

constant <- 0.1

# Start by increasing J_Fecund ; leave the other values unchanged

J_Fecund <- 0.09 + constant
S_Fecund <- 0.20
A_Fecund <- 0.33

J_Surv <- 0.325
S_Surv <- 0.857
A_Surv <- 0.876

new <- matrix(data=c(J_Fecund, S_Fecund, A_Fecund, 
                       J_Surv,        0,        0,
                            0,   S_Surv,   A_Surv), byrow=T, nrow=3, ncol=3)

lambda_eigen <- eigen(new)
Re(lambda_eigen$values[1])

# Go back and repeat for each non-zero value in the original matrix

# original lambda:  0.987

# J_Fecund: 0.09 to 0.19 =   0.999
# S_Fecund: 0.20 to 0.30 =   0.991
# A_Fecund: 0.33 to 0.43 =   1.013
# J_Surv:   0.325 to 0.425 = 1.016
# S_Surv:   0.857 to 0.957 = 0.998
# A_Surv:   0.876 to 0.976 = 1.069


# ----------------------------------------------------------------------------
#    Optional: Stochastic Lefkovich Matrix for NSO
# ----------------------------------------------------------------------------

# How might we do that?  

# 1. define mean values for each parameter (same values as above)

 J_Fecund <- 0.09  
 S_Fecund <- 0.20  
 A_Fecund <- 0.33  

 J_Surv <- 0.325
 S_Surv <- 0.857
 A_Surv <- 0.876

# 2. define expected variation in each parameter as a standard deviation

 J_F_SD <- 0.03
 S_F_SD <- 0.05
 A_F_SD <- 0.04

 J_S_SD <- 0.09
 S_S_SD <- 0.05
 A_S_SD <- 0.03

# 3. establish the number of runs and create a vector to hold lambda estimates

 n_runs  <- 10000
 lambdas <- numeric(n_runs)  

# 4. create stochastic values for each parameter for each run and save as a vector

 J_F_v <- rnorm(n_runs,J_Fecund,J_F_SD)
 S_F_v <- rnorm(n_runs,S_Fecund,S_F_SD)
 A_F_v <- rnorm(n_runs,A_Fecund,A_F_SD)

 J_S_v <- rnorm(n_runs,J_Surv,J_S_SD)
 S_S_v <- rnorm(n_runs,S_Surv,S_S_SD)
 A_S_v <- rnorm(n_runs,A_Surv,A_S_SD)

 head(A_F_v) # check a few values for one fecundity vector
 head(A_S_v) # for one survival vector

# 5. estimate lambda for each run by looping from 1 to n_runs 

 for (i in 1:n_runs) {
     NSO <- matrix(data=c(J_F_v[i], S_F_v[i], A_F_v[i], 
                          J_S_v[i],        0,        0,
                                 0, S_S_v[i], A_S_v[i]), byrow=T, nrow=3, ncol=3)
     lambda_eigen <- eigen(NSO)
     lambdas[i] <- Re(lambda_eigen$values[1])   # save the real part of lambda
     }

hist(lambdas)
abline(v=1, col='red', lwd=2) # draw a vertical line in red at lambda=1
summary(lambdas)

# proportion of lambdas >= 1.0 (= probability of the population persisting)

sum(lambdas >= 1) / length(lambdas) 
