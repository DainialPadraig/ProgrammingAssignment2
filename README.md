# Programming Assignment 2
## Caching matrix operations

### Description of the program

This program file (cachematrix.R) contains two functions: makeCacheMatrix() and
cacheSolve(x). As the name implies, makeCacheMatrix() creates a "special" matrix
object that implements the cached data operations and cacheSolve(x) operates on
the "special" matrix object created by makeCacheMatrix() to calculate the
inverse of a matrix.

These functions are based on the makeVector() and cachemean(x) functions
provided in the description of this second programming assignment in the R
Programming course on Coursera. (https://class.coursera.org/rprog-006)

### Examples of use

The order of calling the functions in cachematrix does matter. makeCacheMatrix()
needs to be called first, in order to create the caching matrix object. 
cacheSolve(x) operates on the caching matrix object created by 
makeCacheMatrix(). You will get an error if you try run cacheSolve(x) on a
regular matrix object:

    > cacheSolve(invertibleMatrix)
    Error in x$getinv : $ operator is invalid for atomic vectors

It also may be tempting to use a shortcut and embed the makeCacheMatrix() 
function in the arguments for the call to cacheSolve(x). This will work (no 
error message will be returned), but it won't allow for caching of the
calculated inverse (since you will have to recreate the caching matrix object
every time you call cacheSolve(x)):

    > cacheSolve(makeCacheMatrix())
         [,1]
    [1,]   NA
    > cacheSolve(makeCacheMatrix())
         [,1]
    [1,]   NA

Note from the example above that, while makeCacheMatrix() does have a default
argument of x = matrix(), if you don't supply a matrix argument, an NA matrix
will be returned.

The following are a couple of examples of the proper use of the cachematrix
functions and the expected results:

    > invertibleMatrix <- matrix(c(2, 2, 3, 2), 2, 2)
    > cachedMatrix <- makeCacheMatrix(invertibleMatrix)
    > cacheSolve(cachedMatrix)
         [,1] [,2]
    [1,]   -1  1.5
    [2,]    1 -1.0
    > cacheSolve(cachedMatrix)
    getting cached data...
         [,1] [,2]
    [1,]   -1  1.5
    [2,]    1 -1.0

    > largerInvertibleMatrix <- matrix(c(1, 0, 5, 2, 1, 6, 3, 4, 0), 3, 3)
    > cachedMatrix <- makeCacheMatrix(largerInvertibleMatrix)
    > cacheSolve(cachedMatrix)
         [,1] [,2] [,3]
    [1,]  -24   18    5
    [2,]   20  -15   -4
    [3,]   -5    4    1
    > cacheSolve(cachedMatrix)
    getting cached data...
         [,1] [,2] [,3]
    [1,]  -24   18    5
    [2,]   20  -15   -4
    [3,]   -5    4    1

    > nonInvertibleMatrix <- matrix(c(2, 6, 1, 2, 6, 4, 3, 9, 8), 3, 3)
    > cachedMatrix <- makeCacheMatrix(nonInvertibleMatrix)
    > cacheSolve(cachedMatrix)
     Error in solve.default(mat, ...) : 
      Lapack routine dgesv: system is exactly singular: U[3,3] = 0 

Notice from the last example that cacheSolve(x) will return an error if the 
matrix is not invertible, so you should always check that a matrix is invertible
(det(matrix) != 0) before using the cachematrix functions on it.

### Notes
This code was written for a class assignment. Real production code should have
been more extensively tested and should contain more tests to catch error
conditions (like non-square matrices and non-invertible matrices). 

#### DON'T USE THIS CODE IN A PRODUCTION ENVIRONMENT!