#!/bin/sh

# Executable script for the ismip6aissvn Pegasus workflow.
# Called with argument: "$@"

# "$@": ./filename1  arg1 ... argn,
# where filename1 is a matlab executable compiled with mcc:

# From the ccr linux front end machine:

# module load gcc/10.2.0
# module load matlab/R2019b
# mcc -m filename1.m filname2.m ... filenamen.m -o filename1

# mcc creates matlab executables to run on a platform corresponding to the platform on which they are generated

echo "$@"
module load gcc/10.2.0
LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/util/academic/matlab/R2019b/bin/glnxa64
LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/util/academic/matlab/R2019b/runtime/glnxa64
export LD_LIBRARY_PATH
#echo LD_LIBRARY_PATH is ${LD_LIBRARY_PATH};
eval "$@"
