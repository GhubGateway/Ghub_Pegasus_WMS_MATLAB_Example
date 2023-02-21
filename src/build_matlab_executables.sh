#!/bin/sh

# Compile Matlab executables for the Pegasus workflow.
# Required per the CCR Matlab license.

module load gcc/10.2.0
module load matlab/R2019b

matlab_executables_dir="./matlab_executables"
echo ${matlab_executables_dir}

if ! [ -d ${matlab_executables_dir} ] ; then
    echo "Creating the ${matlab_executables_dir} directory"
    mkdir ${matlab_executables_dir}
else
    echo "The ${matlab_executables_dir} directory exists"
fi

echo 'building deg2utm...'
mcc -m deg2utm.m -o deg2utm
mv deg2utm ${matlab_executables_dir}
mv run_deg2utm.sh ${matlab_executables_dir}

echo 'building utm2deg...'
mcc -m utm2deg.m -o utm2deg
mv utm2deg ${matlab_executables_dir}
mv run_utm2deg.sh ${matlab_executables_dir}

