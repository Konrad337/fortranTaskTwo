# Matrix multiplication module
Four versions of matrix multiplication algorithm, each utilising different (or no) optimization technique.

## Compilation & running a performence test

To compile the programme open the terminal in project folder
and use cmake . && make

./task start end size_f_step version

0 - no optimization    

1 - use library dot_product function for calculating each of the result matrix elements    

2 - loop nest optimization    

3 - both of the above    

It needs ifort in your path, to change it edit "set (CMAKE_Fortran_COMPILER ifort)"
to compiler of your choice or remove it co cmake could find fortran compiler itself

To make tests use make check, it will print output of
```
./task 100 2000 100 0
./task 100 2000 100 1
./task 100 2000 100 2
./task 100 2000 100 3
```

to txt files in ./graphs and update the graphs

## Results

![alt text](https://github.com/Konrad337/fortranTaskTwo/blob/master/graphs/times.png "Results")
