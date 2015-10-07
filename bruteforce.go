package main

import (
	"bufio"
	"container/heap"
	"fmt"
	"io/ioutil"
	"strconv"
	"strings"
	"time"
)

func main() {
	b, _ := ioutil.ReadFile("terrain.dat")
	r := strings.NewReader(string(b))
	scan := bufio.NewScanner(r)
	scan.Split(bufio.ScanWords)

	scan.Scan()
	dim, _ := strconv.Atoi(scan.Text())

	// var dim int
	// fmt.Scanf("%d", &dim)

	matrix := make([][]int, dim)
	allocation := make([]int, dim*dim)
	for i := range matrix {
		matrix[i] = allocation[i*dim : (i+1)*dim]
	}

	for i := 0; i < dim; i++ {
		for j := 0; j < dim; j++ {
			// var value int
			// fmt.Scanf("%d", &value)
			scan.Scan()
			value, _ := strconv.Atoi(scan.Text())
			matrix[i][j] = value
		}
	}

	time_begin := time.Now()
	fmt.Println("Brute Force timing started with", dim, "x", dim, "matrix. ")
	ph := make(PoolHeap, 0)
	heap.Init(&ph)
	for i := 0; i < dim-1; i++ {
		for j := 0; j < dim-1; j++ {
			height := matrix[i][j]

			for increment := 1; max(i, j)+increment != dim; increment++ {
				h_prime := matrix[i+increment][j+increment]
				if h_prime == height {
					for side_step := 0; side_step < increment; side_step++ {
						if matrix[i+increment][j+side_step] == height && matrix[i+side_step][j+increment] == height {
							continue
						} else {
							goto Next
						}
					}
					pool := &Pool{
						p:     Point{x: i, y: j},
						width: increment + 1,
						h:     height,
					}
					heap.Push(&ph, pool)
				} else {
					goto Next
				}
			}
		Next: //thank you, come again;)
		}
	}

	res := heap.Pop(&ph).(*Pool)
	time_end := time.Now()
	fmt.Println("Timing ends, used", time_end.Sub(time_begin).String())
	fmt.Println("The best is", res)
}

func max(a, b int) int {
	if a >= b {
		return a
	} else {
		return b
	}
}

type Pool struct {
	p     Point
	width int
	h     int
	// index int
}
type PoolHeap []*Pool

func (ph PoolHeap) Len() int {
	return len(ph)
}
func (ph PoolHeap) Less(i, j int) bool {
	return ph[i].width > ph[j].width || (ph[i].width == ph[j].width && ph[i].h < ph[j].h)
}
func (ph PoolHeap) Swap(i, j int) {
	ph[i], ph[j] = ph[j], ph[i]
	// ph[i].index = i
	// ph[j].index = j
}
func (ph *PoolHeap) Push(x interface{}) {
	// n := len(*ph)
	p := x.(*Pool)
	// p.index = n
	*ph = append(*ph, p)
}
func (ph *PoolHeap) Pop() interface{} {
	old := *ph
	n := len(old)
	pool := old[n-1]
	// pool.index = -1
	*ph = old[0 : n-1]
	return pool
}

// for update, might not use
// func (ph *PoolHeap) update(pool *Pool, p Point, w int, h int) {
// 	pool.h = h
// 	pool.p = p
// 	pool.width = w
// 	heap.Fix(ph, pool.index)
// }
func (p Pool) String() string {
	return fmt.Sprintf("at %v, where there is a %dx%d Pool with height %d", p.p, p.width, p.width, p.h)
}

type Point struct {
	x, y int
}

func (p Point) String() string {
	return fmt.Sprintf("(%d,%d)", p.x, p.y)
}
