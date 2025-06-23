#!/bin/sh
#*=====================================================================*/
#*    serrano/diffusion/article/flt/artifact/scripts/plot.sh           */
#*    -------------------------------------------------------------    */
#*    Author      :  Manuel Serrano                                    */
#*    Creation    :  Mon Mar 24 14:11:49 2025                          */
#*    Last change :  Fri Jun 20 09:09:14 2025 (serrano)                */
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
  stats=$*

  if [ ! -f $pdf ] || [ $pdf -ot $plot.plot ]; then
    $ROOT/download/bglstone/bin/gnuplothistogram -o $plotdir/$plot --size $size --relative-sans-left $stats --benchmarks "$SCM_BENCHMARKS" --logscale --separator 12 --rename "Bigloo.fltlb" "self-tagging (2-tag, mantissa low-bits)" --rename "Bigloo.fltnz" "self-tagging (2-tag)" --rename "Bigloo.flt" "self-tagging (3-tag)" --rename "Bigloo.flt1" "self-tagging (1-tag)" --rename "Bigloo.nan" "NaN-boxing" --rename "Bigloo.nun" "NuN-boxing" --rename "Bigloo.bigloo" "orig" --rename "Bigloo" "orig" --values --colors "$colors" --bmargin $bmargin --key "$key" --title "$title" --v-fontsize 4 \
      && (cd $plotdir; unprefix $plot.csv) \
      && (cd $plotdir; gnuplot $plot.plot) 
  fi
}

#*---------------------------------------------------------------------*/
#*    Scheme performance                                               */
#*---------------------------------------------------------------------*/
# figure 5.b
plot $PLOTDIR/bigloo_vs_fltlb.pdf "$COLORLB" "6,2" "3" "off" "" $STATS/bigloo.stat $STATS/bigloo_fltlb.stat

# figure 7
plot $PLOTDIR/bigloo_vs_flt1.pdf "$COLORLB" "6,2" "3" "off" "" $STATS/bigloo.stat $STATS/bigloo_flt1.stat

# figure 9
plot $PLOTDIR/bigloo_vs_flt.pdf "$COLORFLT,$COLORFLTNZ,$COLORFLTONE" "6,3" "5" "under nobox" "Relative time (@PROCESSOR@)" $STATS/bigloo_nun.stat $STATS/bigloo_flt1.stat $STATS/bigloo_flt.stat $STATS/bigloo_fltnz.stat $STATS/bigloo_flt.stat $STATS/bigloo_nan.stat

# figure 11
plot $PLOTDIR/bigloo_vs_nan.pdf "$COLORNAN,$COLORNUN,$COLORFLTONE" "6,3" "5" "under nobox" "Relative time (@PROCESSOR@)" $STATS/bigloo.stat $STATS/bigloo_nan.stat $STATS/bigloo_nun.stat $STATS/bigloo_flt1.stat 

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
# $ROOT/install/hop/bin/hop --no-server -- $ROOT/download/$jsbench/tools/logbench.js gnuplothistogram.js --nosort --relativesans  --logscale y --engine=$ROOT/download/$jsbench/tools/engines -e hop -e hop_nan -e hop_nun -e hop_flt1 --xtics=rotater --target=hop.pdf --format=pdf --size "6,3" --alias "hop.nan=JavaScript NaN-boxing" --alias "hop.nun=JavaScript NuN-boxing" --alias "hop.flt1=JavaScript self-tagging (1-tag)" --alias "hop=orig" --yrange "[0:*]" --colors "red,$COLORNAN,$COLORNUN,$COLORFLTONE" --values --separator 28 --bmargin 6 $logs
# 
# mv hop.plot $PLOTDIR/hop.plot
# mv hop.csv $PLOTDIR/hop.csv
# 
# figure 12
# (cd $PLOTDIR; gnuplot hop.plot)

#*---------------------------------------------------------------------*/
#*    Memory                                                           */
#*---------------------------------------------------------------------*/
# figure 5.a
(cd $BMEMS; $ROOT/install/bigloo/bin/bigloo -i $dir/bmem2csv.scm bigloo_vs_fltlb_bmem $SCM_BENCHMARKS --key "off" --separator 12 --colors "#000,$COLORLB" -:- bigloo bigloo_fltlb 2> ../$PLOTDIR/bigloo_vs_fltlb_bmem.plot | sed -e 's/r7rs-//' > ../$PLOTDIR/bigloo_vs_fltlb_bmem.csv) && (cd $PLOTDIR; gnuplot bigloo_vs_fltlb_bmem.plot)

# figure 8
(cd $BMEMS; $ROOT/install/bigloo/bin/bigloo -i $dir/bmem2csv.scm bigloo_vs_flt_bmem $SCM_BENCHMARKS --key "off" --separator 12 --colors "#000,$COLORFLT,$COLORFLTNZ,$COLORFLTONE" -:- bigloo bigloo_flt bigloo_fltnz bigloo_flt1 2> ../$PLOTDIR/bigloo_vs_flt_bmem.plot | sed -e 's/r7rs-//'  > ../$PLOTDIR/bigloo_vs_flt_bmem.csv) && (cd $PLOTDIR; gnuplot bigloo_vs_flt_bmem.plot)

#*---------------------------------------------------------------------*/
#*    Branch prediction                                                */
#*---------------------------------------------------------------------*/
# figure 5.c
(cd $BRANCHS; $ROOT/install/bigloo/bin/bigloo -i $dir/branch2csv.scm bigloo_vs_fltlb_branch $SCM_BENCHMARKS --key "off" --separator 12 --colors "#000,$COLORLB" -:- bigloo bigloo_fltlb 2> ../$PLOTDIR/bigloo_vs_fltlb_branch.plot | sed -e 's/r7rs-//'  > ../$PLOTDIR/bigloo_vs_fltlb_branch.csv) && (cd $PLOTDIR; gnuplot bigloo_vs_fltlb_branch.plot)

(cd $BRANCHS; $ROOT/install/bigloo/bin/bigloo -i $dir/branch2csv.scm bigloo_vs_flt_branch $SCM_BENCHMARKS --key "off" --separator 12 --colors "#000,$COLORLB" -:- bigloo bigloo_flt bigloo_fltnz 2> ../$PLOTDIR/bigloo_vs_flt_branch.plot | sed -e 's/r7rs-//'  > ../$PLOTDIR/bigloo_vs_flt_branch.csv) && (cd $PLOTDIR; gnuplot bigloo_vs_flt_branch.plot)

