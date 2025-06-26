#!/bin/bash
#*=====================================================================*/
#*    .../diffusion/article/flt/fst-artifact/scripts/versions.sh       */
#*    -------------------------------------------------------------    */
#*    Author      :  Manuel Serrano                                    */
#*    Creation    :  Thu Oct  3 09:53:13 2024                          */
#*    Last change :  Thu Jun 26 12:56:39 2025 (serrano)                */
#*    Copyright   :  2024-25 Manuel Serrano                            */
#*    -------------------------------------------------------------    */
#*    Package versions                                                 */
#*=====================================================================*/

# bigloo
bigloo_giturl=https://github.com/manuel-serrano/bigloo
bigloo_commit=688e83cd951060c36d9585394f381689fc2fa14d
bigloo_branch=master
bigloo_configure_opts="--disable-gmp --disable-libunistring --disable-pcre2 --disable-pcre --disable-libuv"

bigloo_flt_giturl=$bigloo_giturl
bigloo_flt_commit=$bigloo_commit
bigloo_flt_branch=$bigloo_branch

bigloo_fltv_giturl=$bigloo_giturl
bigloo_fltv_commit=$bigloo_commit
bigloo_fltv_branch=$bigloo_branch

bigloo_fltlb_giturl=$bigloo_giturl
bigloo_fltlb_commit=$bigloo_commit
bigloo_fltlb_branch=$bigloo_branch

bigloo_fltnz_giturl=$bigloo_giturl
bigloo_fltnz_commit=$bigloo_commit
bigloo_fltnz_branch=$bigloo_branch

bigloo_flt1_giturl=$bigloo_giturl
bigloo_flt1_commit=$bigloo_commit
bigloo_flt1_branch=$bigloo_branch

bigloo_fltcell_giturl=$bigloo_giturl
bigloo_fltcell_commit=$bigloo_commit
bigloo_fltcell_branch=$bigloo_branch

bigloo_nan_giturl=$bigloo_giturl
bigloo_nan_commit=$bigloo_commit
bigloo_nan_branch=$bigloo_branch

bigloo_nun_giturl=$bigloo_giturl
bigloo_nun_commit=$bigloo_commit
bigloo_nun_branch=$bigloo_branch

# hop
hop_giturl=https://github.com/manuel-serrano/hop
hop_commit=17ed772272fc7aa34b28b2965cc6cfc52073e871
hop_branch=master

hop_flt_giturl=$hop_giturl
hop_flt_commit=$hop_commit
hop_flt_branch=$hop_branch

hop_fltv_giturl=$hop_giturl
hop_fltv_commit=$hop_commit
hop_fltv_branch=$hop_branch

hop_fltlb_giturl=$hop_giturl
hop_fltlb_commit=$hop_commit
hop_fltlb_branch=$hop_branch

hop_fltnz_giturl=$hop_giturl
hop_fltnz_commit=$hop_commit
hop_fltnz_branch=$hop_branch

hop_flt1_giturl=$hop_giturl
hop_flt1_commit=$hop_commit
hop_flt1_branch=$hop_branch

hop_fltcell_giturl=$hop_giturl
hop_fltcell_commit=$hop_commit
hop_fltcell_branch=$hop_branch

hop_nan_giturl=$hop_giturl
hop_nan_commit=$hop_commit
hop_nan_branch=$hop_branch

hop_nun_giturl=$hop_giturl
hop_nun_commit=$hop_commit
hop_nun_branch=$hop_branch

# bglstone
bglstone_giturl=https://github.com/manuel-serrano/bglstone
bglstone_commit=4b483e69ee44f36982b26e8d05cdd34413cee26b
bglstone_branch=master

bglstone_bflags="-O6 -freturn -freturn-goto -copt -O3 -static-all-bigloo"

bglstone_flt_giturl=$bglstone_giturl
bglstone_flt_commit=$bglstone_commit
bglstone_flt_branch=$bglstone_branch

bglstone_fltv_giturl=$bglstone_giturl
bglstone_fltv_commit=$bglstone_commit
bglstone_fltv_branch=$bglstone_branch

bglstone_fltlb_giturl=$bglstone_giturl
bglstone_fltlb_commit=$bglstone_commit
bglstone_fltlb_branch=$bglstone_branch

bglstone_fltnz_giturl=$bglstone_giturl
bglstone_fltnz_commit=$bglstone_commit
bglstone_fltnz_branch=$bglstone_branch

bglstone_flt1_giturl=$bglstone_giturl
bglstone_flt1_commit=$bglstone_commit
bglstone_flt1_branch=$bglstone_branch

bglstone_fltcell_giturl=$bglstone_giturl
bglstone_fltcell_commit=$bglstone_commit
bglstone_fltcell_branch=$bglstone_branch

bglstone_nan_giturl=$bglstone_giturl
bglstone_nan_commit=$bglstone_commit
bglstone_nan_branch=$bglstone_branch

bglstone_nun_giturl=$bglstone_giturl
bglstone_nun_commit=$bglstone_commit
bglstone_nun_branch=$bglstone_branch

# jsbench
jsbench_giturl=https://github.com/manuel-serrano/jsbench
jsbench_commit=7c8fc4e58d2a5c7980c207d302b1d1cb18308a5c
jsbench_branch=master

# gambit
gambit_giturl=https://github.com/gambit/gambit
gambit_commit=f251835e2a1226b1ed70d6f343d41beb8cff2e0b
gambit_branch=master

gambit_0_giturl=$gambit_giturl
gambit_0_commit=$gambit_commit
gambit_0_branch=$gambit_branch

gambit_1_giturl=$gambit_giturl
gambit_1_commit=$gambit_commit
gambit_1_branch=$gambit_branch

gambit_2_giturl=$gambit_giturl
gambit_2_commit=$gambit_commit
gambit_2_branch=$gambit_branch

gambit_3_giturl=$gambit_giturl
gambit_3_commit=$gambit_commit
gambit_3_branch=$gambit_branch

gambit_4_giturl=$gambit_giturl
gambit_4_commit=$gambit_commit
gambit_4_branch=$gambit_branch

gambit_nun_giturl=$gambit_giturl
gambit_nun_commit=$gambit_commit
gambit_nun_branch=$gambit_branch

# bglstone_gambit
bglstone_gambit_0_giturl=$bglstone_giturl
bglstone_gambit_0_commit=$bglstone_commit
bglstone_gambit_0_branch=$bglstone_branch

bglstone_gambit_1_giturl=$bglstone_giturl
bglstone_gambit_1_commit=$bglstone_commit
bglstone_gambit_1_branch=$bglstone_branch

bglstone_gambit_2_giturl=$bglstone_giturl
bglstone_gambit_2_commit=$bglstone_commit
bglstone_gambit_2_branch=$bglstone_branch

bglstone_gambit_3_giturl=$bglstone_giturl
bglstone_gambit_3_commit=$bglstone_commit
bglstone_gambit_3_branch=$bglstone_branch

bglstone_gambit_4_giturl=$bglstone_giturl
bglstone_gambit_4_commit=$bglstone_commit
bglstone_gambit_4_branch=$bglstone_branch

bglstone_gambit_nun_giturl=$bglstone_giturl
bglstone_gambit_nun_commit=$bglstone_commit
bglstone_gambit_nun_branch=$bglstone_branch

# current package
tarballurl=$(eval echo "\$${package}_tarballurl")
giturl=$(eval echo "\$${package}_giturl")
commit=$(eval echo "\$${package}_commit")
branch=$(eval echo "\$${package}_branch")
