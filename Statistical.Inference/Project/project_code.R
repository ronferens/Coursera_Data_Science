nosim <- 1000
n <- 40
lambda <- 0.2

## Simulate nosim averages of 40 exponential distribution
mean(apply(matrix( rexp((nosim * n), lambda), nosim), 1, mean))

## Theoretical mean of the exponential distribution is 1/lambda
1/lambda

##========================================

## Simulate nosim averages of 40 exponential distribution
mean(apply(matrix( rexp((nosim * n), lambda), nosim), 1, sd))^2

## Theoretical variance of the exponential distribution is lambda^-2
lambda^-2

##========================================
library(ggplot2)

x <- apply(matrix(rexp((nosim * n), lambda), nosim), 1, mean)
data <- as.data.frame(x)
ggplot(data, aes(x = x)) + 
  geom_histogram(binwidth = 0.4, color = 'black', fill = 'white', aes(y = ..density..)) +
  stat_function(aes(x = c(2, 8)), fun = dnorm, color = 'red', 
                args = list(mean = 1/lambda, sd = (1/lambda/sqrt(n)))) +
  xlab('Sample mean') +
  ylab('Density') +
  ggtitle('Comparison of the sample distribution\n and the theoretical distribution')