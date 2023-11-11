#!/bin/bash -l

# Compile Matlab executables on CCR for the Pegasus workflow

# vortex
module load gcc/10.2.0
module load matlab/R2019b
# vortex-future
#module load gcc/11.2.0
#module load matlab/2021b

# Note: for ../remotebin/matlabLaunch.sh LD_LIBRARY_PATH
which gcc
which matlab

matlab_bin_dir='/projects/grid/ghub/Tools/software/2023.01/matlab/ghubex3/v1.0.0/bin'
#echo ${matlab_bin_dir}
mkdir -p ${matlab_bin_dir}

echo 'building deg2utm...'
rm -f 'deg2utm.m'
# Click the GitHub Raw button to get this link
wget -q https://raw.githubusercontent.com/GhubGateway/Ghub_Pegasus_WMS_MATLAB_Example/main/src/deg2utm.m
# mcc creates matlab executables to run on a platform corresponding to the platform on which they are generated
mcc -m deg2utm.m -o deg2utm
chmod +x deg2utm
mv -f deg2utm ${matlab_bin_dir}

echo 'building utm2deg...'
rm -f 'utm2deg.m'
# Click the GitHub Raw button to get this link
wget -q https://raw.githubusercontent.com/GhubGateway/Ghub_Pegasus_WMS_MATLAB_Example/main/src/utm2deg.m
# mcc creates matlab executables to run on a platform corresponding to the platform on which they are generated
mcc -m utm2deg.m -o utm2deg
chmod +x utm2deg
mv -f utm2deg ${matlab_bin_dir}
