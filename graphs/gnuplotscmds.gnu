set terminal wxt size 350,262 enhanced font 'Verdana,10' persist

# Line width of the axes
set border linewidth 1.5
# Line styles



set title "Matrix multiplication with diffrent optimalization"
set xlabel "N"
set ylabel "Time"

set style line 1 lc rgb '#0060ad' pt 27 ps 1.2   # ---
set style line 2 lc rgb '#dd181f' pt 27 ps 1.2   # ---
set style line 3 lc rgb '#000000' pt 27 ps 1.2   # ---
set style line 4 lc rgb '#ff00ff' pt 27 ps 1.2   # ---
set style line 5 lc rgb '#00ffff' pt 27 ps 1.2   # ---


set terminal png size 600,600; set output './graphs/times.png';
plot './graphs/test0' title 'v0' with points ls 1, './graphs/test1' title 'v1' with points ls 2, './graphs/test2' title 'v2' with points ls 3,  './graphs/test3' title 'v3' with points ls 4,  './graphs/test3' title 'matmul' with points ls 5
