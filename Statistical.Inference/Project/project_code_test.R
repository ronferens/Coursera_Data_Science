nosim <- 1000
lambda <- 0.2

cfunc <- function(x, n) (mean(x) - (1/lambda)) / sqrt(lambda^-2 / n)
dat <- data.frame(
  x = c(apply(matrix(rexp((nosim * 40) , lambda), 40), 1, cfunc, nosim),
        apply(matrix(rexp((nosim * 40), lambda), nosim), 1, cfunc, 40)
  ),
  size = factor(rep(c(nosim, 40), rep(nosim, 2))))
g <- ggplot(dat, aes(x = x, fill = size)) + geom_histogram(alpha = .20, binwidth=.3, colour = "black", aes(y = ..density..)) 
g <- g + stat_function(fun = dnorm, size = 2)
g + facet_grid(. ~ size)