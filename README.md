# Largest Plateau in Terrain Grid

## Problem statement
Given a square Terrain grid, the value of each cell indicates the height of that cell. Find largest plateau in the Terrain.

## Input generation
source the `R` code to generate matrix, first argument is dimension of the square, second is the max height you want to specify. The generated height will range from `0:dim` uniformly.


## Bruteforce

`foreach cell find largest plateau that begins with that cell`

### Quick test with Go
 * generate matrix
 * `go run bruteforce.go`

> If you want to modify the way of treating IO. Remember **avoid** using `fmt.Scanf` for input because it's not buffered and every `Scanf` is syscall.

## Largest Square Area in Histogram

Linear Search with Queue/Stack
