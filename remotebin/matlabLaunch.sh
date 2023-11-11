#!/bin/bash -l

# Executable launch script for the Pegasus workflow.
# Called with argument: "$@"

# "$@": ./filename1  arg1 ... argn,
# where filename1 is a matlab executable compiled with mcc.
# Also see ./build_matlab_executables.sh

echo "$@"

matlab_bin_dir='/projects/grid/ghub/Tools/software/2023.01/matlab/ghubex3/v1.0.0/bin'
#echo ${matlab_bin_dir}

PATH=$PATH:${matlab_bin_dir}
export PATH
echo PATH is ${PATH}

# vortex
module load gcc/10.2.0
LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/util/academic/matlab/R2019b/bin/glnxa64
LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/util/academic/matlab/R2019b/runtime/glnxa64
# vortex-future
#module load gcc/11.2.0
#LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/cvmfs/soft.ccr.buffalo.edu/versions/2023.01/easybuild/software/Core/matlab/2021b/bin/glnxa64
#LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/cvmfs/soft.ccr.buffalo.edu/versions/2023.01/easybuild/software/Core/matlab/2021b/runtime/glnxa64
export LD_LIBRARY_PATH
echo LD_LIBRARY_PATH is ${LD_LIBRARY_PATH}

eval "$@"
