# Matrix operations in R, part 1: Matrix_illustrations_1.R

# ---------------------------------------------------------------------------
### Basic matrix operations
# ---------------------------------------------------------------------------

# A matrix is defined by the number of rows x columns [rows, columns]

# Create a matrix -- by default R fills a matrix column-wise (i.e., columns first)

A <- matrix(c(1,2,3,4,5,6), nrow=2, ncol=3) # A is a 2 x 3 matrix (2 rows, 3 columns) 
A

# To fill a matrix row-wise, use the byrow=TRUE option

B <- matrix(c(1,2,3,4,5,6), 2, 3, byrow=TRUE) # B is a 2 x 3 matrix
B

## Extract subsets of a matrix by referencing [row, col] subscripts

# Extract a single element

B[1, 2] # value in row 1, col 2 of matrix B

# Extract a row

B[1, ] # row 1 of matrix B

# Extract a single column

B[ , 2] # column 1 of matrix B

# Extract combinations of multiple rows and/or columns

B[1:2, 2:3] # rows 1 and 2, columns 2 and 3

## Combine matrices

# Append vertically or 'stack' with rbind() = row bind

rbind(A, B)

# Append horizontally with cbind() = column bind

cbind(A, B)

# Add and subtract matrices

 cat("\014") # clear the console -- or use ctrl+L
 A ; B       # print matrices so we can check the next commands

A + B        # adds element by element
A - B        # subtracts element by element

# Multiply each element by a scalar 

3*A

# Transpose a matrix = change columns into rows and rows into columns

C <- t(B) 
C

# Multiply matrices

A%*%C     # use %*% for matrix multiplication

A*B       # note that * multiplies each element (we won't use this function)

# Info about matrices

dim(A)    # dimension = number of rows and columns
nrow(A)
ncol(A)


# Deterministic Leslie Matrix for Merriam's kangaroo rat
# ----------------------------------------------------------------------------

# Create and fill Leslie matrix, L

 L <- matrix(c(   0,  2.6,  3.0, 2.9, 
               0.24,    0,    0,   0,
                  0, 0.38,    0,   0,
                  0,    0, 0.40,   0), 
               byrow=T, nrow=4, ncol=4)
 L

# Create and fill Transition matrix, N

 N0 <- matrix(c(200, 40, 30, 20), byrow=T, nrow=4, ncol=1)
 N0

# Example: Project abundance from N0 to N1 by multiplying Leslie matrix by Transition vector

 N1 <- L %*% N0
 N1

# ---------------------------------------------------------------------------
### Matrix projections
# ---------------------------------------------------------------------------
 
# Create an empty matrix [filled with NAs] to store the set of projected population vectors  
# for n.years into the future, starting with initial abundances defined by N0 above
 
 n.years <- 30    # set the number of years for the projection
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
 plot(1:length(Nproj), Nproj, ylim=c(250,350), ylab="N", xlab="Years", type="l", lwd=2)
 
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
