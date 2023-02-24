### LESLIE MATRIX / ABUNDANCE / LAMBDA ######

# Create and fill Leslie matrix, L

L <- matrix(c(   0,  2.5,  5.0, 5.0, 
                 0.20,    0,    0,   0,
                 0, 0.35,    0,   0,
                 0,    0, 0.45,   0), 
            byrow=T, nrow=4, ncol=4)
L

# Create and fill Transition matrix, N

N0 <- matrix(c(100, 30, 20, 10), byrow=T, nrow=4, ncol=1)
N0

# Abundance projection

N1 <- L %*% N0
N1

# Create an empty matrix [filled with NAs] to store the set of projected population vectors  
# for n.years into the future, starting with initial abundances defined by N0 above

n.years <- 25    # set the number of years for the projection
Nt      <- matrix(NA, nrow=nrow(L), ncol=n.years) 
Nt[ ,1] <- N0
Nt

# Project abundances for n.years, from year 2 to year n.years 

for (t in 2:n.years) {
  Nt[ ,t] <- L %*% Nt[ ,t-1]  
}

# Display the first 10 years of the projection rounded to whole numbers

print(round(Nt[ , 1:10], digits=0))

# Sum abundances for all ages using the apply() function
# 1 = apply function to columns, 2 = apply to rows, c(1, 2) = apply to rows and columns

Nproj <- apply(Nt, 2, sum)
plot(1:length(Nproj), Nproj, ylim=c(0,250), ylab="N", xlab="Years", type="l", lwd=2)

# Plot abundances for each age separately

plot(1:n.years,  Nt[1,], ylim=c(0,300), ylab="N", xlab="Years", type="l", col=1, lwd=2)
lines(1:n.years, Nt[2,], type="l", col=2, lwd=2)
lines(1:n.years, Nt[3,], type="l", col=3, lwd=2)
lines(1:n.years, Nt[4,], type="l", col=4, lwd=2)

# Use eigen() function to find all the eigenvalues and eigenvectors for matrix L

L_eigen <- eigen(L)
L_eigen

# Extract lambda (the first or 'leading' eigenvalue): Re() extracts the real (versus imaginary) part

lambda  <- Re(L_eigen$values[1])  # Save the real part of lambda
lambda

# Extract the stable-age distribution from the first eigenvector 
# Note: Need to divide each element by the sum of all elements to create the proportion we want

stable_age <- Re(L_eigen$vectors[,1]/sum(L_eigen$vectors[,1]))
stable_age


### SENSITIVITIES ######

# Add 0.1 (or any small constant) to each vital rate individually, then recompute lambda

# Year 2 Fecundity

LF2 <- matrix(c(   0,  2.6,  5.0, 5.0, 
                 0.20,    0,    0,   0,
                 0, 0.35,    0,   0,
                 0,    0, 0.45,   0), 
            byrow=T, nrow=4, ncol=4)
LF2

L_eigenF2 <- eigen(LF2)
L_eigenF2

lambdaF2  <- Re(L_eigenF2$values[1])
lambdaF2

# Year 3 Fecundity

LF3 <- matrix(c(   0,  2.5,  5.1, 5.0, 
                   0.20,    0,    0,   0,
                   0, 0.35,    0,   0,
                   0,    0, 0.45,   0), 
              byrow=T, nrow=4, ncol=4)
LF3

L_eigenF3 <- eigen(LF3)
L_eigenF3

lambdaF3  <- Re(L_eigenF3$values[1])
lambdaF3

# Year 4 Fecundity

LF4 <- matrix(c(   0,  2.5,  5.0, 5.1, 
                   0.20,    0,    0,   0,
                   0, 0.35,    0,   0,
                   0,    0, 0.45,   0), 
              byrow=T, nrow=4, ncol=4)
LF4

L_eigenF4 <- eigen(LF4)
L_eigenF4

lambdaF4  <- Re(L_eigenF4$values[1])
lambdaF4

# Year 1 Survival

LS1 <- matrix(c(   0,  2.5,  5.0, 5.0, 
                   0.3,    0,    0,   0,
                   0, 0.35,    0,   0,
                   0,    0, 0.45,   0), 
              byrow=T, nrow=4, ncol=4)
LS1

L_eigenS1 <- eigen(LS1)
L_eigenS1

lambdaS1  <- Re(L_eigenS1$values[1])
lambdaS1

# Year 2 Survival

LS2 <- matrix(c(   0,  2.5,  5.0, 5.0, 
                   0.2,    0,    0,   0,
                   0, 0.45,    0,   0,
                   0,    0, 0.45,   0), 
              byrow=T, nrow=4, ncol=4)
LS2

L_eigenS2 <- eigen(LS2)
L_eigenS2

lambdaS2  <- Re(L_eigenS2$values[1])
lambdaS2

# Year 3 Survival

LS3 <- matrix(c(   0,  2.5,  5.0, 5.0, 
                   0.2,    0,    0,   0,
                   0, 0.35,    0,   0,
                   0,    0, 0.55,   0), 
              byrow=T, nrow=4, ncol=4)
LS3

L_eigenS3 <- eigen(LS3)
L_eigenS3

lambdaS3  <- Re(L_eigenS3$values[1])
lambdaS3

# New Lambdas; Original = 1.002814

# F2 = 1.010311
# F3 = 1.005425
# F4 = 1.003986
# S1 = 1.170796
# S2 = 1.053409
# S3 = 1.015531

# Computing Sensitivities

SensF2 <- (lambdaF2-lambda)/0.1
SensF3 <- (lambdaF3-lambda)/0.1
SensF4 <- (lambdaF4-lambda)/0.1
SensS1 <- (lambdaS1-lambda)/0.1
SensS2 <- (lambdaS2-lambda)/0.1
SensS3 <- (lambdaS3-lambda)/0.1


### ELASTICITIES ######

F2 <- 2.5
F3 <- 5
F4 <- 5
S1 <- 0.2
S2 <- 0.35
S3 <- 0.45

ElasF2 <- ((lambdaF2-lambda)/lambda) / (0.1/F2)
ElasF3 <- ((lambdaF3-lambda)/lambda) / (0.1/F3)
ElasF4 <- ((lambdaF4-lambda)/lambda) / (0.1/F4)
ElasS1 <- ((lambdaS1-lambda)/lambda) / (0.1/S1)
ElasS2 <- ((lambdaS2-lambda)/lambda) / (0.1/S2)
ElasS3 <- ((lambdaS3-lambda)/lambda) / (0.1/S3)


### REVISED LESLIE MATRIX ######

Lrev <- matrix(c(   0,  2.5,  5.0, 5.0, 
                 0.20,    0,    0,   0,
                 0, 0.35,    0,   0,
                 0,    0, 0.45,   0.25), 
            byrow=T, nrow=4, ncol=4)
Lrev

Lrev_eigen <- eigen(Lrev)
Lrev_eigen

lambda  <- Re(Lrev_eigen$values[1])  
lambda
