#!/bin/sh
#*=====================================================================*/
#*    serrano/diffusion/article/flt/fst-artifact/scripts/plot.sh       */
#*    -------------------------------------------------------------    */
#*    Author      :  Manuel Serrano                                    */
#*    Creation    :  Mon Mar 24 14:11:49 2025                          */
#*    Last change :  Wed Jul  2 14:42:03 2025 (serrano)                */
#*    Copyright   :  2025 Manuel Serrano                               */
#*    -------------------------------------------------------------    */
#*    Generate the plots, invoked automatically by run.sh              */
#*=====================================================================*/

#*---------------------------------------------------------------------*/
#*    Configuration                                                    */
#*---------------------------------------------------------------------*/
path=`realpath $0`
dir=`dirname $path`

. $dir/env.sh

mkdir -p $PLOTDIR

#*---------------------------------------------------------------------*/
#*    unprefix                                                         */
#*---------------------------------------------------------------------*/
unprefix() {
  file=$1
  cat $1 | sed -e 's/r7rs-//' > $file.tmp
  mv $file.tmp $file
}

#*---------------------------------------------------------------------*/
#*    plot                                                             */
#*---------------------------------------------------------------------*/
plot() {
  pdf=$1
  plotdir=`dirname $pdf`
  plot=`basename $pdf .pdf`
  shift
  colors=$1
  shift
  size=$1
  shift
  bmargin=$1
  shift
  key=$1
  shift
  title=$1
  shift
  range=$1
  shift
  stats=$*

  if [ ! -f $pdf ] || [ $pdf -ot $plot.plot ]; then
    $downloaddir/bglstone/bin/gnuplothistogram -o $plotdir/$plot --size $size --relative-sans-left $stats --benchmarks "$SCM_BENCHMARKS" --logscale --separator 12 --rename "Bigloo.fltlb" "self-tagging (2-tag, mantissa low-bits)" --rename "Bigloo.fltnz" "self-tagging (2-tag)" --rename "Bigloo.flt" "self-tagging (3-tag)" --rename "Bigloo.flt1" "self-tagging (1-tag)" --rename "Bigloo.nan" "NaN-boxing" --rename "Bigloo.nun" "NuN-boxing" --rename "Bigloo.bigloo" "alloc" --rename "Bigloo" "alloc" --rename "Gambit.nun" "NuN-boxing" --rename "Gambit.0" "alloc" --rename "Gambit.1" "self-tagging (1-tag)" --rename "Gambit.2" "self-tagging (2-tag)" --rename "Gambit.3" "self-tagging (3-tag)" --rename "Gambit.4" "self-tagging (4-tag)" --values --colors "$colors" --bmargin $bmargin --key "$key" --title "$title" --v-fontsize 4 --range $range \
      && (cd $plotdir; unprefix $plot.csv) \
      && (cd $plotdir; gnuplot $plot.plot) 
  fi
}

#*---------------------------------------------------------------------*/
#*    COMP_time_nun_ARCH.pdf                                           */
#*---------------------------------------------------------------------*/
plot $PLOTDIR/bigloo_time_nun_$host.pdf "$COLORFLTONE,$COLORFLTNZ,$COLORFLT,$COLORNAN" "6,3" "5" "under nobox" "Relative time (@PROCESSOR@)" "[0.5:2.5]" $STATS/bigloo_nun.stat $STATS/bigloo_flt1.stat $STATS/bigloo_fltnz.stat $STATS/bigloo_flt.stat $STATS/bigloo_nan.stat
plot $PLOTDIR/gambit_time_nun_$host.pdf "$COLORFLTONE,$COLORFLTNZ,$COLORFLT,$COLORFLTFOUR" "6,3" "5" "under nobox" "Relative time (@PROCESSOR@)" "[0.5:2.5]" $STATS/gambit_nun.stat $STATS/gambit_1.stat $STATS/gambit_2.stat $STATS/gambit_3.stat $STATS/gambit_4.stat

#*---------------------------------------------------------------------*/
#*    COMP_time_alloc_ARCH.pdf                                         */
#*---------------------------------------------------------------------*/
plot $PLOTDIR/bigloo_time_alloc_$host.pdf "$COLORFLTONE" "6,3" "5" "under nobox" "Relative time (@PROCESSOR@)" "[0.5:2.5]" $STATS/bigloo.stat $STATS/bigloo_flt1.stat
plot $PLOTDIR/gambit_time_alloc_$host.pdf "$COLORFLTONE" "6,3" "5" "under nobox" "Relative time (@PROCESSOR@)" "[0.5:2.5]" $STATS/gambit_0.stat $STATS/gambit_1.stat

#*---------------------------------------------------------------------*/
#*    COMP_time_mantissa_ARCH.pdf                                      */
#*---------------------------------------------------------------------*/
plot $PLOTDIR/bigloo_time_mantissa_$host.pdf "$COLORFLTLB" "6,3" "5" "under nobox" "Relative time (@PROCESSOR@)" "[0.5:2.5]" $STATS/bigloo.stat $STATS/bigloo_fltlb.stat

#*---------------------------------------------------------------------*/
#*    COMP_mem_ARCH.pdf                                                */
#*---------------------------------------------------------------------*/
(cd $BMEMS; $installdir/bigloo/bin/bigloo -i $dir/bmem2csv.scm bigloo_mem_$host $SCM_BENCHMARKS --key "off" --separator 12 --colors "#ff0,$COLORFLTONE,$COLORFLTNZ,$COLORFLT,$COLORNAN,$COLORNUN" -:- bigloo bigloo_flt1 bigloo_fltnz bigloo_flt bigloo_nan bigloo_nun 2> ../$PLOTDIR/bigloo_mem_$host.plot | sed -e 's/r7rs-//'  > ../$PLOTDIR/bigloo_mem_$host.csv) && (cd $PLOTDIR; gnuplot bigloo_mem_$host.plot)

#*---------------------------------------------------------------------*/
#*    COMP_branch_ARCH.pdf                                             */
#*---------------------------------------------------------------------*/
if [ -f $BRANCHS/r7rs-compiler/bigloo.branch ]; then
  (cd $BRANCHS; $installdir/bigloo/bin/bigloo -i $dir/branch2csv.scm bigloo_branch_$host $SCM_BENCHMARKS --key "off" --separator 12 --colors "#ff0,$COLORFLTONE,$COLORFLTNZ,$COLORFLT,$COLORNAN,$COLORNUN" -:- bigloo bigloo_flt1 bigloo_fltnz bigloo_flt bigloo_nan bigloo_nun 2> ../$PLOTDIR/bigloo_branch_$host.plot | sed -e 's/r7rs-//'  > ../$PLOTDIR/bigloo_branch_$host.csv) && (cd $PLOTDIR; gnuplot bigloo_branch_$host.plot)
fi

#*---------------------------------------------------------------------*/
#*    Heap                                                             */
#*---------------------------------------------------------------------*/
mkdir -p $PLOTDIR/gc

for benchmark in $SCM_FLOAT_BENCHMARKS; do
  gnuplot -e "benchmark='$benchmark'" \
          -e "bigloo_orig='$HEAPS/$benchmark/bigloo.heap'" \
          -e "bigloo_fst='$HEAPS/$benchmark/bigloo_flt1.heap'" \
          -e "gambit_orig='$HEAPS/$benchmark/gambit_0.heap'" \
          -e "gambit_fst='$HEAPS/$benchmark/gambit_1.heap'" \
          -e "output='$PLOTDIR/gc/$benchmark.pdf'" \
	  -e "smallest_non_zero_vector='$SCM_SMALLEST_NON_ZERO_SIZE'" \
          $dir/plot_gc.gp
done

#*---------------------------------------------------------------------*/
#*    Scheme performance                                               */
#*---------------------------------------------------------------------*/
#* # figure 5.b                                                        */
#* plot $PLOTDIR/bigloo_vs_fltlb.pdf "$COLORLB" "6,2" "3" "off" "" "[0:*]" $STATS/bigloo.stat $STATS/bigloo_fltlb.stat */
#*                                                                     */
#* # figure 7                                                          */
#* plot $PLOTDIR/bigloo_vs_flt1.pdf "$COLORLB" "6,2" "3" "off" ""  "[0:*]" $STATS/bigloo.stat $STATS/bigloo_flt1.stat */
#*                                                                     */
#* # figure 9                                                          */
#* plot $PLOTDIR/bigloo_vs_flt.pdf "$COLORFLTONE,$COLORFLTNZ,$COLORFLT,$COLORNAN" "6,3" "5" "under nobox" "Relative time (@PROCESSOR@)" "[0.5:2.5]" $STATS/bigloo_nun.stat $STATS/bigloo_flt1.stat $STATS/bigloo_fltnz.stat $STATS/bigloo_flt.stat $STATS/bigloo_nan.stat */
#*                                                                     */
#* plot $PLOTDIR/gambit_vs_flt.pdf "$COLORFLTONE,$COLORFLTNZ,$COLORFLT,$COLORFLTFOUR" "6,3" "5" "under nobox" "Relative time (@PROCESSOR@)" "[0.5:2.5]" $STATS/gambit_nun.stat $STATS/gambit_1.stat $STATS/gambit_2.stat $STATS/gambit_3.stat $STATS/gambit_4.stat */
#*                                                                     */
#* # figure 11                                                         */
#* plot $PLOTDIR/bigloo_vs_nan.pdf "$COLORNAN,$COLORNUN,$COLORFLTONE" "6,3" "5" "under nobox" "Relative time (@PROCESSOR@)" "[0:*]" $STATS/bigloo.stat $STATS/bigloo_nan.stat $STATS/bigloo_nun.stat $STATS/bigloo_flt1.stat */
#*                                                                     */
# figure 8 (gc)

# The line below is used to generate the legend
#gnuplot -e "legend_only=1" \
#        -e "output='$PLOTDIR/gc/legend.pdf'" \
#        $dir/plot_gc.gp

#* {*---------------------------------------------------------------------*} */
#* {*    Memory                                                           *} */
#* {*---------------------------------------------------------------------*} */
#* # figure 5.a                                                        */
#* (cd $BMEMS; $installdir/bigloo/bin/bigloo -i $dir/bmem2csv.scm bigloo_vs_fltlb_bmem $SCM_BENCHMARKS --key "off" --separator 12 --colors "#000,$COLORLB" -:- bigloo bigloo_fltlb 2> ../$PLOTDIR/bigloo_vs_fltlb_bmem.plot | sed -e 's/r7rs-//' > ../$PLOTDIR/bigloo_vs_fltlb_bmem.csv) && (cd $PLOTDIR; gnuplot bigloo_vs_fltlb_bmem.plot) */
#*                                                                     */
#* # figure 8                                                          */
#* (cd $BMEMS; $installdir/bigloo/bin/bigloo -i $dir/bmem2csv.scm bigloo_vs_flt_bmem $SCM_BENCHMARKS --key "off" --separator 12 --colors "#000,$COLORFLT,$COLORFLTNZ,$COLORFLTONE" -:- bigloo bigloo_flt bigloo_fltnz bigloo_flt1 2> ../$PLOTDIR/bigloo_vs_flt_bmem.plot | sed -e 's/r7rs-//'  > ../$PLOTDIR/bigloo_vs_flt_bmem.csv) && (cd $PLOTDIR; gnuplot bigloo_vs_flt_bmem.plot) */
#*                                                                     */
#* {*---------------------------------------------------------------------*} */
#* {*    Branch prediction (generated only if branch profile files exist) *} */
#* {*---------------------------------------------------------------------*} */
#* # figure 5.c                                                        */
#* if [ -f $BRANCHS/r7rs-compiler/bigloo.branch ]; then                */
#*   (cd $BRANCHS; $installdir/bigloo/bin/bigloo -i $dir/branch2csv.scm bigloo_vs_fltlb_branch $SCM_BENCHMARKS --key "off" --separator 12 --colors "#000,$COLORLB" -:- bigloo bigloo_fltlb 2> ../$PLOTDIR/bigloo_vs_fltlb_branch.plot | sed -e 's/r7rs-//'  > ../$PLOTDIR/bigloo_vs_fltlb_branch.csv) && (cd $PLOTDIR; gnuplot bigloo_vs_fltlb_branch.plot) */
#*                                                                     */
#*   (cd $BRANCHS; $installdir/bigloo/bin/bigloo -i $dir/branch2csv.scm bigloo_vs_flt_branch $SCM_BENCHMARKS --key "off" --separator 12 --colors "#000,$COLORLB" -:- bigloo bigloo_flt bigloo_fltnz 2> ../$PLOTDIR/bigloo_vs_flt_branch.plot | sed -e 's/r7rs-//'  > ../$PLOTDIR/bigloo_vs_flt_branch.csv) && (cd $PLOTDIR; gnuplot bigloo_vs_flt_branch.plot) */
#* fi                                                                  */

#*---------------------------------------------------------------------*/
#*    Hop performance                                                  */
#*---------------------------------------------------------------------*/
# conf=`echo $hop | sed -e 's/hop//'`
# confname=`echo $hop | sed -e 's/hop_//'`
# jsbench="jsbench$conf"
# 
# logs=""
# for b in $JS_BENCHMARKS; do
#   logs="$logs $LOGS/$b.log.json"
# done
#
# $installdir/hop/bin/hop --no-server -- $downloaddir/$jsbench/tools/logbench.js gnuplothistogram.js --nosort --relativesans  --logscale y --engine=$downloaddir/$jsbench/tools/engines -e hop -e hop_nan -e hop_nun -e hop_flt1 --xtics=rotater --target=hop.pdf --format=pdf --size "6,3" --alias "hop.nan=JavaScript NaN-boxing" --alias "hop.nun=JavaScript NuN-boxing" --alias "hop.flt1=JavaScript self-tagging (1-tag)" --alias "hop=orig" --yrange "[0:*]" --colors "red,$COLORNAN,$COLORNUN,$COLORFLTONE" --values --separator 28 --bmargin 6 $logs
# 
# mv hop.plot $PLOTDIR/hop.plot
# mv hop.csv $PLOTDIR/hop.csv
# 
# figure 12
# (cd $PLOTDIR; gnuplot hop.plot)

#*---------------------------------------------------------------------*/
#*    Float Distribution                                               */
#*---------------------------------------------------------------------*/

get_float_percentage() {
  local pattern=$1
  local file=$2
  awk -F, -v "p=$pattern" 'BEGIN {
      total = 0;
      target = 0;
    }
    { 
      total += $2;
      if (match($1, "^" p)) target += $2
    }
    END {
      if (target > 0 && total > 0) { printf "%.0f%% ", (100 * target / total); }
      else { printf "- "; }
    }' $file
}

float_buckets="zero nan inf"
for i in $(seq 0 31); do
  bin=$(printf "%05d" "$(echo "obase=2;$i" | bc)")
  float_buckets="$float_buckets $bin"
done

float_table_csv=$PLOTDIR/floats.csv
echo -n "high-bits $SCM_FLOAT_BENCHMARKS" > $float_table_csv
for pattern in $float_buckets; do
  echo >> $float_table_csv
  echo -n $pattern >> $float_table_csv
  for benchmark in $SCM_FLOAT_BENCHMARKS; do
    echo -n " $(get_float_percentage $pattern "$FLOATS/$benchmark/$benchmark.floats")" >> $float_table_csv
  done
done
cat $float_table_csv | tr -s ' ' | column -t > $PLOTDIR/floats.txt
