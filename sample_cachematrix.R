## sample_cachematrix.R
## sample usage of the cachematrix.R functions

source("cachematrix.R")


# here's a basic matrix
m1 <- matrix(c(0, 1, -3, -3, -4, 4, -2, -2, 1), nrow = 3, ncol = 3)
m1

# here's is it's inverse"
Im1 <- solve(m1)
Im1
# to prove it, here's the result of multiplying the matrix and it's inverse
round(m1 %*% Im1, 3)

#using the cached matrix here are two successive calls to get the inverse using cachSolve()
cm1 <- makeCacheMatrix(m1)
cacheSolve(cm1)
# the second call will get the cached inverse ...
cacheSolve(cm1)

# now let's reset the cached matrix with new data ...
n2 <- matrix(c(4, 5, -8, -5, -6, 9, -2, -2, 3), nrow = 3, ncol = 3)
print(n2)
cm1$set(n2)
# if we try and access the inverse directly with n2$getInv() we can see the inverse has been reset
cm1$getInv()
# using the newly cached matrix here are two successive calls to get the inverse using cachSolve()
# the first call will create and cache a new inverse ...
cacheSolve(cm1)
# the second call will get the newly cached inverse ...
cacheSolve(cm1)
# and proving the inverse ...
round(cm1$get() %*% cm1$getInverse(), 3)
