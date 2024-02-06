#!/bin/bash -l

# Executable launch script for the Pegasus workflow.
# Called with argument: "$@"

# "$@": ./filename1  arg1 ... argn,
# where filename1 is a matlab executable compiled with mcc.
# Also see ./build_matlab_executables.sh

echo "$@"

module load ccrsoft/2023.01
module load gcc/11.2.0
LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/cvmfs/soft.ccr.buffalo.edu/versions/2023.01/easybuild/software/Core/matlab/2021b/bin/glnxa64
LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/cvmfs/soft.ccr.buffalo.edu/versions/2023.01/easybuild/software/Core/matlab/2021b/runtime/glnxa64
export LD_LIBRARY_PATH
echo LD_LIBRARY_PATH is ${LD_LIBRARY_PATH}

eval "$@"
