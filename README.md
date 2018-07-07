# Matrix multiplication module
Four versions of matrix multiplication algorithm, each utilising different (or no) optimization technique.

## Compilation & running a performence test

To compile the programme open the terminal in project folder
and use cmake . && make

./bin/task start end size_of_step version

0 - no optimization    

1 - use library dot_product function for calculating each of the result matrix elements    

2 - loop nest optimization    

3 - both of the above    

other - it will use std MATMUL function

It needs ifort in your path, to change it edit "set (CMAKE_Fortran_COMPILER ifort)"
to compiler of your choice or remove it co cmake could find fortran compiler itself

If you encounter problems with matmul not multiplying too large matrices please refer to:
https://software.intel.com/en-us/forums/intel-fortran-compiler-for-linux-and-mac-os-x/topic/269344

To make tests use make check, it will print output of
```
./task 100 1000 100 0
./task 100 1000 100 1
./task 100 1000 100 2
./task 100 1000 100 3
./task 100 1000 100 4 (where 4 will trigger default behavior - multiplying with matmul)
```
to files in ./graphs and update the graphs

## Results
Results of tests with 100 3000 100 v


![alt text](https://github.com/Konrad337/fortranTaskTwo/blob/master/graphs/times3000.png "Results")
