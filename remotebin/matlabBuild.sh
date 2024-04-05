#!/bin/bash -l

# Componet of ghubex3 (github.com)

params=$@
#split params string based on spaces
IFS=' ' read -ra array <<< $params
echo "${array[*]}"

module load ccrsoft/2023.01
module load matlab/2021b

# mcc creates MATLAB executables to run on a platform corresponding to the platform on which they are generated.

mcc=$(which mcc)
echo 'mcc: '${mcc}

${mcc} -v -m ./deg2utm.m -o deg2utm
${mcc} -v -m ./utm2deg.m -o utm2deg
