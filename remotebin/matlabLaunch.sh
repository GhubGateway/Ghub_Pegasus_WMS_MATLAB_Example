#!/bin/bash -l

# Executable launch script for the Pegasus workflow.
# Called with argument: "$@"

# "$@": ./filename1  arg1 ... argn,
# where filename1 is a matlab executable compiled with mcc.
# Also see ./build_matlab_executables.sh

echo "$@"

module load ccrsoft/2023.01
module load matlab/2021b

# Avoid contention accessing /user/ghub/.mcrCache*
export MCR_CACHE_ROOT=${PWD}/mcrCache
echo ${MCR_CACHE_ROOT}

MCRROOT=/cvmfs/soft.ccr.buffalo.edu/versions/2023.01/easybuild/software/Core/matlab/2021b
LD_LIBRARY_PATH=.:${MCRROOT}/runtime/glnxa64;
LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:${MCRROOT}/bin/glnxa64;
LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:${MCRROOT}/sys/os/glnxa64;
LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:${MCRROOT}/sys/opengl/lib/glnxa64;
export LD_LIBRARY_PATH
echo LD_LIBRARY_PATH is ${LD_LIBRARY_PATH}

eval "$@"
