### plot_param.gp ###

# Require bigloo_orig, bigloo_fst, gambit_orig, gambit_fst, output, benchmark

set output output

if (exists("legend_only")) {
    #set terminal pngcairo size 1200, 400
    set terminal pdf font 'Verdana,28' size 8,1
    set xrange [0:1]
    set yrange [0:1]

    unset xtics
    unset ytics
    unset border

    set key bottom center
    set key spacing 1.5
    set lmargin at screen 0.55
    set rmargin at screen 1
    set key below columns 3
    set key width -10
    set key samplen 7

    plot \
        NaN with linespoints title "Bigloo (self-tagging)" linecolor "dark-blue" ps 2 lw 3 pointtype 9, \
        NaN with linespoints title "Gambit (self-tagging)" linecolor "dark-red" ps 2 lw 3 pointtype 5, \
        NaN with linespoints title "Bigloo (orig)" linecolor "dark-blue" dashtype (30,15,30,15) ps 2 lw 3 pointtype 8, \
        NaN with linespoints title "Gambit (orig)" linecolor "dark-red" dashtype (30,15,30,15) ps 2 lw 3 pointtype 4, \

    exit 0
}

graph_title = sprintf("%s", benchmark)

# Set the CSV separator to comma
set datafile separator ','

set terminal pdf font 'Verdana,12' size 8,6

# Optionally, set a title and labels
# set title font ",40" 
# set title graph_title

set xlabel sprintf("Prealloacted Heap Data Size", allocator) font ",32" 
set ylabel "Execution time (s)" font ",32" 

set xtics font ",30"
set ytics font ",30"

# Enable grid if desired
set grid

# Add some extra bottom margin
set bmargin 10

# Y logscale
# set logscale y 10
# set yrange [10:*]

# Y no-logscale
set yrange [0:*]

#if (benchmark eq "pnpoly") {
#    set yrange [0:50]
#}

# Build pseudo-logscale
set format x '%.0s%cB'

set logscale x 10
unset mxtics

# Rotate xtic labels if they are long (optional)
set xtics rotate by 55 right

xzero=smallest_non_zero_vector / 10
set xtics add ("" (xzero + 0.01))
set xrange [xzero:*]

set label "0B" at graph 0, graph 0 font ",30" offset -1, -2

break_size = 0.3
break_offset = 3
break_line_width = 0.01
break_start = xzero * break_offset
break_end = xzero * (break_offset + break_size)
break_angle = 65

set pointsize 0.7

set arrow 500 from first break_start,0 to first break_end,0
set arrow 500 linecolor "white" front nohead

set arrow 501 from first break_start,0 length graph break_line_width angle break_angle
set arrow 501 linecolor "black" front nohead
set arrow 502 from first break_start,0 length graph break_line_width angle (break_angle + 180)
set arrow 502 linecolor "black" front nohead

set arrow 503 from first break_end,0 length graph break_line_width angle break_angle
set arrow 503 linecolor "black" front nohead
set arrow 504 from first break_end,0 length graph break_line_width angle (break_angle + 180)
set arrow 504 linecolor "black" front nohead

zx(x) = (x <= xzero) ? xzero : x;

unset xlabel
unset ylabel
set bmargin 7
unset key

plot \
    bigloo_orig using (zx($1)):2 with linespoints title "Bigloo (orig)" linecolor "dark-blue" dashtype (50,30,50,30) ps 2 lw 2 pointtype 8, \
    gambit_orig using (zx($1)):2 with linespoints title "Gambit (orig)" linecolor "dark-red" dashtype (50,30,50,30) ps 2 lw 2 pointtype 4, \
    gambit_fst  using (zx($1)):2 with linespoints title "Gambit (self-tagging)" linecolor "dark-red" ps 2 lw 3 pointtype 5, \
    bigloo_fst  using (zx($1)):2 with linespoints title "Bigloo (self-tagging)" linecolor "dark-blue" ps 2 lw 3 pointtype 9

exit 0
