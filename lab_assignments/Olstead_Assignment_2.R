# nesting data and plot

Year <- c(1995,1996,1997,1998,1999,2000,2001,2002,2003,2004,2005,2006,2007,2008,2009,2010,2011)
Nests <- c(43,46,43,42,50,61,65,82,82,82,87,79,88,94,137,171,163)
plot(Year, Nests)

# rate of change

lnNests <- log(Nests) # natural log transform
lm(lnNests ~ Year)  # linear regression model
lrm <- lm(lnNests~Year)
plot(Year, lnNests)
lambda <- 0.08444 # rate of change transformed
exp.lambda <- exp(lambda) # backtransformed rate of change

# doubling time

dt <- log(2)/log(exp.lambda)

# nests for 25-year period

yr0 <- 43*(exp.lambda^0)
yr1 <- 43*(exp.lambda^1)
yr2 <- 43*(exp.lambda^2)
yr3 <- 43*(exp.lambda^3)
yr4 <- 43*(exp.lambda^4)
yr5 <- 43*(exp.lambda^5)
yr6 <- 43*(exp.lambda^6)
yr7 <- 43*(exp.lambda^7)
yr8 <- 43*(exp.lambda^8)
yr9 <- 43*(exp.lambda^9)
yr10 <- 43*(exp.lambda^10)
yr11 <- 43*(exp.lambda^11)
yr12 <- 43*(exp.lambda^12)
yr13 <- 43*(exp.lambda^13)
yr14 <- 43*(exp.lambda^14)
yr15 <- 43*(exp.lambda^15)
yr16 <- 43*(exp.lambda^16)
yr17 <- 43*(exp.lambda^17)
yr18 <- 43*(exp.lambda^18)
yr19 <- 43*(exp.lambda^19)
yr20 <- 43*(exp.lambda^20)
yr21 <- 43*(exp.lambda^21)
yr22 <- 43*(exp.lambda^22)
yr23 <- 43*(exp.lambda^23)
yr24 <- 43*(exp.lambda^24)

nestEst <- c(yr0,yr1,yr2,yr3,yr4,yr5,yr6,yr7,yr8,yr9,yr10,yr11,yr12,yr13,yr14,yr15,yr16,yr17,yr18,yr19,yr20,yr21,yr22,yr23,yr24)

twentyfiveYear <- seq(1995,2019,by=1)
plot(twentyfiveYear, nestEst)
