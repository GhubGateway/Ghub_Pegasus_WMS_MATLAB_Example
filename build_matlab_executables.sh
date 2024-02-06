#!/bin/bash -l

# Compile Matlab executables on CCR for the Pegasus workflow.
# Usage: login to CCR before running this script.

module load ccrsoft/2023.01
module load gcc/11.2.0
module load matlab/2021b

# Note for ../remotebin/matlabLaunch.sh LD_LIBRARY_PATH
which gcc
which matlab

rm -rf ./matlab_executables_build_dir
git clone https://github.com/GhubGateway/Ghub_Pegasus_WMS_MATLAB_Example ./matlab_executables_build_dir
cd ./matlab_executables_build_dir

echo 'building deg2utm...'
# mcc creates MATLAB executables to run on a platform corresponding to the platform on which they are generated
mcc -m ./src/deg2utm.m -o deg2utm
mv deg2utm ./bin

echo 'building utm2deg...'
# mcc creates MATLAB executables to run on a platform corresponding to the platform on which they are generated
mcc -m ./src/utm2deg.m -o utm2deg
mv utm2deg ./bin

git add ./bin/deg2utm
git update-index --chmod=+x ./bin/deg2utm
git add ./bin/utm2deg
git update-index ./bin/utm2deg
git commit -m "Update compiled MATLAB executables"
git status

# You will be prompted for your GitHub user name and password.
# Enter a personal access token for the password,
# select the repo option (Full control of private repositories) when creating the personal access token.
git config --global push.default matching
git push

cd ..
rm -rf ./matlab_executables_build_dir
