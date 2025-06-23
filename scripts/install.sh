#!/bin/sh
#*=====================================================================*/
#*    serrano/diffusion/article/flt/artifact/scripts/install.sh        */
#*    -------------------------------------------------------------    */
#*    Author      :  Manuel Serrano                                    */
#*    Creation    :  Thu Oct  3 09:44:21 2024                          */
#*    Last change :  Fri Jun 20 10:28:22 2025 (serrano)                */
#*    Copyright   :  2024-25 Manuel Serrano                            */
#*    -------------------------------------------------------------    */
#*    Install all the FLT compilers                                    */
#*=====================================================================*/

#*---------------------------------------------------------------------*/
#*    Configuration                                                    */
#*---------------------------------------------------------------------*/
path=`realpath $0`
dir=`dirname $path`

. $dir/env.sh

# compilers
$dir/bigloo.sh
$dir/bigloo_flt.sh
$dir/bigloo_fltlb.sh
$dir/bigloo_fltv.sh
$dir/bigloo_fltnz.sh
$dir/bigloo_flt1.sh
$dir/bigloo_nan.sh
$dir/bigloo_nun.sh

# $dir/hop.sh
# $dir/hop_flt.sh
# $dir/hop_fltlb.sh
# $dir/hop_fltv.sh
# $dir/hop_fltnz.sh
# $dir/hop_flt1.sh
# $dir/hop_nan.sh
# $dir/hop_nun.sh

# benchmark suites
$dir/bglstone.sh
$dir/bglstone_flt.sh
$dir/bglstone_fltv.sh
$dir/bglstone_fltlb.sh
$dir/bglstone_fltnz.sh
$dir/bglstone_flt1.sh
$dir/bglstone_nan.sh
$dir/bglstone_nun.sh

# $dir/jsbench.sh
