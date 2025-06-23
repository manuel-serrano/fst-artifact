#!/bin/sh
#*=====================================================================*/
#*    serrano/diffusion/article/flt/artifact/scripts/run.sh            */
#*    -------------------------------------------------------------    */
#*    Author      :  Manuel Serrano                                    */
#*    Creation    :  Thu Oct  3 09:44:21 2024                          */
#*    Last change :  Fri Jun 20 10:28:46 2025 (serrano)                */
#*    Copyright   :  2024-25 Manuel Serrano                            */
#*    -------------------------------------------------------------    */
#*    Run all the FLT benchmarks                                       */
#*=====================================================================*/

#*---------------------------------------------------------------------*/
#*    Configuration                                                    */
#*---------------------------------------------------------------------*/
path=`realpath $0`
dir=`dirname $path`

. $dir/env.sh


# output directories
mkdir -p $STATS
mkdir -p $BMEMS
mkdir -p $BRANCHS
mkdir -p $LOGS

#*---------------------------------------------------------------------*/
#*    benchmark executions                                             */
#*---------------------------------------------------------------------*/
# performance
for bigloo in $BIGLOOS; do
  echo "\e[1;30m=== bglstone ($bigloo)\e[0m"
  conf=`echo $bigloo | sed -e 's/bigloo//'`
  bglstone="bglstone$conf"

  if [ "$conf " = "bigloo " ]; then
    confname=""
  else
    confname=".`echo $bigloo | sed -e 's/bigloo_//'`"
  fi

  if [ ! -f $STATS/$bigloo.stat ]; then
    (cd $ROOT/download/$bglstone \
       && make run TARGETS="bigloo" BENCH=$BENCH REPETITION="-r $REPETITION") \
      && cat $ROOT/download/$bglstone/src/bigloo.stat \
	| sed -e "s/Bigloo/Bigloo${confname}/" > $STATS/$bigloo.stat
   fi
done

# memory
for bigloo in $BIGLOOS; do
  echo "\e[1;31m=== bmem ($bigloo)\e[0m"
  conf=`echo $bigloo | sed -e 's/bigloo//'`
  bglstone="bglstone$conf"

  for benchmark in $SCM_BENCHMARKS; do
    echo "  $benchmark"
    if [ ! -f $BMEMS/$benchmark/$bigloo.bmem ]; then
      mkdir -p $BMEMS/$benchmark
      (cd $ROOT/download/$bglstone/src/$benchmark/bigloo \
	 && $ROOT/install/$bigloo/bin/bigloo ${benchmark}.scm -O3 -unsafe -pmem \
	 && BMEMVERBOSE=0 BMEMFORMAT=sexp $ROOT/install/$bigloo/bin/bglmemrun ./a.out pmem) \
	&& mv $ROOT/download/$bglstone/src/$benchmark/bigloo/a.bmem $BMEMS/$benchmark/$bigloo.bmem
    fi
  done
done

# branch prediction
for bigloo in $BIGLOOS; do
  echo "\e[1;32m=== branch ($bigloo)\e[0m"
  conf=`echo $bigloo | sed -e 's/bigloo//'`
  bglstone="bglstone$conf"

  for benchmark in $SCM_BENCHMARKS; do
    echo "  $benchmark"
    if [ ! -f $BRANCHS/$benchmark/$bigloo.branch ]; then
      mkdir -p $BRANCHS/$benchmark
      (cd $ROOT/download/$bglstone/src/$benchmark/bigloo \
	 && perf stat -x , -e branch-misses ./bigloo.exe 2>&1 > /dev/null | awk -F, '{print $1}' > a.branch) \
	&& mv $ROOT/download/$bglstone/src/$benchmark/bigloo/a.branch $BRANCHS/$benchmark/$bigloo.branch
    fi
  done
done

# hop
# echo "\e[1;33m=== jsbench\e[0m"
# conf=`echo $hop | sed -e 's/hop//'`
# confname=`echo $hop | sed -e 's/hop_//'`
# jsbench="jsbench$conf"
# 
# logs=""
# for b in $JS_BENCHMARKS; do
#   logs="$logs $LOGS/$b.log.json"
# done
# 
# if [ ! -f $LOGS/SUMMARY.txt ]; then
#   (cd $ROOT/download/$jsbench \
#      && ./hopstone.sh --hopc=$ROOT/install/hop/bin/hopc --hop=$ROOT/install/hop/bin/hop --dir=$LOGS -e hop -e hop_flt -e hop_nan -e hop_nun -e hop_fltlb -e hop_fltnz -e hop_flt1 octane jetstream sunspider bglstone)
# fi
  
#*---------------------------------------------------------------------*/
#*    PDF barcharts                                                    */
#*---------------------------------------------------------------------*/
sh $dir/plot.sh

#*---------------------------------------------------------------------*/
#*    last message                                                     */
#*---------------------------------------------------------------------*/
echo "\e[1;29m*** $PLOTDIR\e[0m complete."
