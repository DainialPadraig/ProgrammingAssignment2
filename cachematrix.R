## This file contains two functions for inverting a matrix that will cache
## results in order to save repeated computations of the same result. This can
## potentially reduce the time to calculate the inverse of very large matrices.

## This function creates a special matrix object that can cache its inverse.

makeCacheMatrix <- function(x = matrix()) {
    
    matInv <- NULL  ## placeholder for the matrix inverse

    ## Store the matrix specified in the argument in cache.
    ## (Note that the matrix is assumed to be invertible.)
    set <- function(y) {  
        x <<- y         ## cache value of matrix y
        matInv <<- NULL ## ensure previous calculated cache inverse is cleared
    }
    
    ## Retrieve the cached matrix.
    get <- function() x  
    
    ## Cache the matrix inverse.
    setinv <- function(inv) matInv <<- inv
    
    ## Return the cached matrix inverse.
    getinv <- function() matInv  
    
    ## Return a list of functions cache matrices and matrix inverses.
    list(set = set, get = get, setinv = setinv, getinv = getinv)

}


## This function computes the inverse of the special matrix returned by the
## makeCacheMatrix() function. If the matrix is unchanged and the inverse has
## already been calculated, this function will use the cached value instead of
## recalculating the inverse.

cacheSolve <- function(x, ...) {
    
    matInv <- x$getinv()  ## get the matrix inverse from cache
    
    if (!is.null(matInv)) { ## check to see if the inverse was in the cache
        message("getting cached data...")  ## if so, inform user
        return(matInv)  ## and return the matrix inverse from the cache
    }
    mat <- x$get()  ## if the inverse wasn't cached, get the cached matrix
    matInv <- solve(mat, ...)  ## if so, calculate the inverse of the matrix
    x$setinv(matInv)
    
    matInv  ## return the inverse of the matrix

}
