set output '/dev/null'
set terminal dumb

set arrow 1 from graph 0, first 1 to graph 1, first 1 nohead lc 'red' lw 2 dt '---' front
set label 1 'orig' font 'Verdana,10' at 20,1 offset -0.5,0.5 tc 'red'

plot \
  'bigloo_mem_redrock2020.csv' u 2:xtic(1) title 'Scheme self tagging (1 tag)' ls 2,\
  'bigloo_mem_redrock2020.csv' u 3:xtic(1) title 'Scheme self tagging (2 tags)' ls 3,\
  'bigloo_mem_redrock2020.csv' u 4:xtic(1) title 'Scheme self tagging (3 tags)' ls 4,\
  'bigloo_mem_redrock2020.csv' u 5:xtic(1) title 'Scheme nan tagging' ls 5,\
  'bigloo_mem_redrock2020.csv' u 6:xtic(1) title 'orig_nun' ls 6,\
  'bigloo_mem_redrock2020.csv' u ($0+-0.5):($2+.1):(sprintf("%3.2f",$2)) with labels font 'Verdana,6' rotate by 90 notitle,\
  'bigloo_mem_redrock2020.csv' u ($0+-0.3333333333333333):($3+.1):(sprintf("%3.2f",$3)) with labels font 'Verdana,6' rotate by 90 notitle,\
  'bigloo_mem_redrock2020.csv' u ($0+-0.16666666666666666):($4+.1):(sprintf("%3.2f",$4)) with labels font 'Verdana,6' rotate by 90 notitle,\
  'bigloo_mem_redrock2020.csv' u ($0+0):($5+.1):(sprintf("%3.2f",$5)) with labels font 'Verdana,6' rotate by 90 notitle,\
  'bigloo_mem_redrock2020.csv' u ($0+0.16666666666666666):($6+.1):(sprintf("%3.2f",$6)) with labels font 'Verdana,6' rotate by 90 notitle

reset

set output 'bigloo_mem_redrock2020.pdf'
set terminal pdf font 'Verdana,12' size 6,2

#set title 'Memory allocation'
set ylabel 'relative allocation' offset 0,0

set auto x

set style data histogram
set style histogram gap 1
set errorbars lc rgb '#444444'
set xtics rotate by 45 right

set xtics font 'Verdana,8'
set ytics font 'Verdana,10'

set boxwidth 0.9
set style fill solid

set style line 1 linecolor rgb '#ff0' linetype 1 linewidth 1
set style line 2 linecolor rgb '#fa9600' linetype 1 linewidth 1
set style line 3 linecolor rgb '#3264c8' linetype 1 linewidth 1
set style line 4 linecolor rgb '#159a2b' linetype 1 linewidth 1
set style line 5 linecolor rgb '#edd20b' linetype 1 linewidth 1
set style line 6 linecolor rgb '#109318' linetype 1 linewidth 1
set style line 7 linecolor rgb '#00a0bf' linetype 1 linewidth 1
set style line 8 linecolor rgb '#72bf00' linetype 1 linewidth 1
set style line 9 linecolor rgb '#969996' linetype 1 linewidth 1
set style line 10 linecolor rgb '#4b30ed' linetype 1 linewidth 1
set style line 100 linecolor rgb '#000000' linetype 1 linewidth 1
set style line 1000 linecolor rgb '#555555 linewidth 20

set grid ytics
set xtics scale 0
set datafile separator ','

set yrange [0:*]

set lmargin 6
set rmargin 1
set bmargin 3
set key off
set arrow 1 from graph 0, first 1 to graph 1, first 1 nohead lc 'red' lw 2 dt '---' front
set label 1 'orig' font 'Verdana,10' at 20,1 offset -0.5,0.5 tc 'red'

set arrow from 11.5,0 to 11.5,GPVAL_Y_MAX nohead ls 1000 dashtype 2 front

plot \
  'bigloo_mem_redrock2020.csv' u 2:xtic(1) title 'Scheme self tagging (1 tag)' ls 2,\
  'bigloo_mem_redrock2020.csv' u 3:xtic(1) title 'Scheme self tagging (2 tags)' ls 3,\
  'bigloo_mem_redrock2020.csv' u 4:xtic(1) title 'Scheme self tagging (3 tags)' ls 4,\
  'bigloo_mem_redrock2020.csv' u 5:xtic(1) title 'Scheme nan tagging' ls 5,\
  'bigloo_mem_redrock2020.csv' u 6:xtic(1) title 'orig_nun' ls 6,\
  'bigloo_mem_redrock2020.csv' u ($0+-0.5):($2+.1):(sprintf("%3.2f",$2)) with labels font 'Verdana,6' rotate by 90 notitle,\
  'bigloo_mem_redrock2020.csv' u ($0+-0.3333333333333333):($3+.1):(sprintf("%3.2f",$3)) with labels font 'Verdana,6' rotate by 90 notitle,\
  'bigloo_mem_redrock2020.csv' u ($0+-0.16666666666666666):($4+.1):(sprintf("%3.2f",$4)) with labels font 'Verdana,6' rotate by 90 notitle,\
  'bigloo_mem_redrock2020.csv' u ($0+0):($5+.1):(sprintf("%3.2f",$5)) with labels font 'Verdana,6' rotate by 90 notitle,\
  'bigloo_mem_redrock2020.csv' u ($0+0.16666666666666666):($6+.1):(sprintf("%3.2f",$6)) with labels font 'Verdana,6' rotate by 90 notitle
