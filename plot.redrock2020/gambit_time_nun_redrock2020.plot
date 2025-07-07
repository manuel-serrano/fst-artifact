set output '/dev/null'
set terminal dumb

plot \
   'gambit_time_nun_redrock2020.csv' u 2:xtic(1) title 'self-tagging (1-tag)' ls 1,\
   'gambit_time_nun_redrock2020.csv' u 3:xtic(1) title 'self-tagging (2-tag)' ls 2,\
   'gambit_time_nun_redrock2020.csv' u 4:xtic(1) title 'self-tagging (3-tag)' ls 3,\
   'gambit_time_nun_redrock2020.csv' u 5:xtic(1) title 'self-tagging (4-tag)' ls 4, \
   'gambit_time_nun_redrock2020.csv' u ($0+-0.3333333333333333):($2+.15):(sprintf("%3.2f",$2)) with labels font 'Verdana,4' rotate by 90 notitle,\
   'gambit_time_nun_redrock2020.csv' u ($0+-0.16666666666666666):($3+.15):(sprintf("%3.2f",$3)) with labels font 'Verdana,4' rotate by 90 notitle,\
   'gambit_time_nun_redrock2020.csv' u ($0+0.16666666666666666):($4+.15):(sprintf("%3.2f",$4)) with labels font 'Verdana,4' rotate by 90 notitle,\
   'gambit_time_nun_redrock2020.csv' u ($0+0.3333333333333333):($5+.15):(sprintf("%3.2f",$5)) with labels font 'Verdana,4' rotate by 90 notitle
reset

set output 'gambit_time_nun_redrock2020.pdf'
set terminal pdf font "Verdana,12" size 6,3

set title 'Relative time (Intel(R) Xeon(R) W-2245 CPU @ 3.90GHz)'
set ylabel "relative time" offset 0,0

set auto x

set style data histogram
set style histogram gap 1 
set errorbars lc rgb '#444444'
set xtics rotate by 45 right

set xtics font "Verdana,8"
set ytics font "Verdana,10"

set boxwidth 0.9
set style fill solid
set style line 1 linecolor rgb '#fa9600' linetype 1 linewidth 1
set style line 2 linecolor rgb '#3264c8' linetype 1 linewidth 1
set style line 3 linecolor rgb '#159a2b' linetype 1 linewidth 1
set style line 4 linecolor rgb '#e30074' linetype 1 linewidth 1
set style line 5 linecolor rgb '#93ade2' linetype 1 linewidth 1
set style line 6 linecolor rgb '#edd20b' linetype 1 linewidth 1
set style line 7 linecolor rgb '#00a0bf' linetype 1 linewidth 1
set style line 8 linecolor rgb '#72bf00' linetype 1 linewidth 1
set style line 9 linecolor rgb '#969996' linetype 1 linewidth 1
set style line 10 linecolor rgb '#4b30ed' linetype 1 linewidth 1
set style line 100 linecolor rgb '#000000' linetype 1 linewidth 1
set style line 1000 linecolor rgb '#555555 linewidth 20

set grid ytics
set xtics scale 0
set datafile separator ","

set yrange [0.5:2.5]

set lmargin 6
set rmargin 1
set bmargin 5

set key under nobox

set arrow 1 from graph 0, first 1 to graph 1, first 1 nohead lc 'red' lw 2 dt '---' front
set label 1 'NuN-boxing' font 'Verdana,10' at -1,1 offset 0.1,0.4 left tc 'red' front

set logscale y

set arrow from 11.5,GPVAL_Y_MIN to 11.5,GPVAL_Y_MAX nohead ls 1000 dashtype 2

plot \
   'gambit_time_nun_redrock2020.csv' u 2:xtic(1) title 'self-tagging (1-tag)' ls 1,\
   'gambit_time_nun_redrock2020.csv' u 3:xtic(1) title 'self-tagging (2-tag)' ls 2,\
   'gambit_time_nun_redrock2020.csv' u 4:xtic(1) title 'self-tagging (3-tag)' ls 3,\
   'gambit_time_nun_redrock2020.csv' u 5:xtic(1) title 'self-tagging (4-tag)' ls 4, \
   'gambit_time_nun_redrock2020.csv' u ($0+-0.3333333333333333):($2+.15):(sprintf("%3.2f",$2)) with labels font 'Verdana,4' rotate by 90 notitle,\
   'gambit_time_nun_redrock2020.csv' u ($0+-0.16666666666666666):($3+.15):(sprintf("%3.2f",$3)) with labels font 'Verdana,4' rotate by 90 notitle,\
   'gambit_time_nun_redrock2020.csv' u ($0+0.16666666666666666):($4+.15):(sprintf("%3.2f",$4)) with labels font 'Verdana,4' rotate by 90 notitle,\
   'gambit_time_nun_redrock2020.csv' u ($0+0.3333333333333333):($5+.15):(sprintf("%3.2f",$5)) with labels font 'Verdana,4' rotate by 90 notitle