## cachematrix.R defines functions for creating a
## matrix whose inverse can be cached


## qualifiedMatrix() evaluates an object to see if it
## has a possible inverse matrix
qualifiedMatrix <- function(A) {
    if (is.null(A)) {
        return (FALSE)
    } else if (is.null(dim(A))) {
        return (FALSE)
    } else if (dim(A)[1] != dim(A)[2]) {
        return (FALSE)
    } else if (det(A) == 0) {
        return (FALSE)
    } else {
        return (TRUE)
    }
}


## makeCacheMatrix() creates a matrix capable of caching 
## its inverse in order to avoid an expensive recalculation
## every time the inverse is needed
makeCacheMatrix <- function(M = matrix()) {
    IM <- NULL
    
    if (! qualifiedMatrix(M)) {
        stop("there is no inverse for this matrix")
    }
    
    set <- function(A) {
        M <<- A
        IM <<- NULL
    }
    get <- function() M
    
    setInverse <- function(inv) IM <<- inv
    getInverse <- function() IM
    
    list(
        set = set, 
        get = get, 
        setInverse = setInverse, 
        getInverse = getInverse)
}


## cacheSolve either returns the cached value
## of the matix's inverse if it exists, or computes
## and caches the inverse before returning it
cacheSolve <- function(A, ...) {
    IA <- A$getInv()
    if(!is.null(IA)) {
        message("getting cached data")
    } else {
        data <- A$get()
        IA <- solve(data, ...)
        A$setInv(IA)
    }
    
    IA
}
