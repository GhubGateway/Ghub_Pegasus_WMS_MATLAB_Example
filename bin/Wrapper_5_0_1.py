#----------------------------------------------------------------------------------------------------------------------
# Class: Wrapper_5.0.1
# Component of: ghubex3 (github.com)
# Called from: ghubex3.ipynb
# Purpose: Run a Pegasus WMS 5.0.1 workflow via the HUBzero hublib.cmd interface
# Author: Renette Jones-Ivey
# Date: Sept 2023
#---------------------------------------------------------------------------------------------------------------------

import ast
import os
import sys

#import Rappture
#from Rappture.tools import executeCommand as RapptureExec
# Modified for Python 2 to 3
import hublib.cmd
#help (hublib.cmd.command.executeCommand)

# API for generating Pegasus YML files
from Pegasus.api import *

# Wrapper class
# Called from ghub_exercise1.ipynb
class Wrapper():
    

    def __init__(self, parent, tooldir, bindir, datadir, workingdir, rundir, latitude, longitude, maxwalltime):

        self.parent = parent
        self.tooldir = tooldir
        self.bindir = bindir
        self.datadir = datadir
        self.workingdir = workingdir
        self.rundir = rundir
        self.latitude = latitude
        self.longitude = longitude
        self.maxwalltime = maxwalltime

        #'''
        print('self.parent: ', self.parent)
        print('self.tooldir: ', self.tooldir)
        print('self.bindir: ', self.bindir)
        print('self.datadir: ', self.datadir)
        print('self.workingdir: ', self.workingdir)
        print('self.rundir: ', self.rundir)
        print('self.latitude: ', self.latitude)
        print('self.longitude: ', self.longitude)
        print('self.maxwalltime: ', self.maxwalltime)
        #'''
        
        self.run()

    def run(self):

        try:

            #########################################################
            # Create the Pegasus WMS workflow
            #########################################################
            print ('Wrapper_5_0_1...')
    
            wf = Workflow('ghubex3-workflow')
            tc = TransformationCatalog()
            rc = ReplicaCatalog()

            # See ../build_matlab_executables.sh for more information on creating the MATLAB executables for this tool.

            # Add the MATLAB launch script to the transformation catalog. The launch script is run on CCR to run the MATLAB executables.
                
            tooldir = os.path.dirname(os.path.dirname(os.path.realpath(os.path.abspath(__file__))))
            print ('tooldir: ', tooldir)
            matlab_launch_exec_path =  os.path.join(tooldir, 'remotebin', 'matlabLaunch.sh')
            print ("matlab_launch_exec_path: %s" %matlab_launch_exec_path)
            
            matlablaunch = Transformation(
                'matlablaunch',
                site='local',
                pfn=matlab_launch_exec_path,
                is_stageable = True, #Stageable or installed
                arch=Arch.X86_64,
                os_type=OS.LINUX,
                os_release="rhel")

            tc.add_transformations(matlablaunch)
            wf.add_transformation_catalog(tc)

            # All files in a Pegasus workflow are referred to in the DAX using their Logical File Name (LFN).
            # These LFNs are mapped to Physical File Names (PFNs) when Pegasus plans the workflow.
            # Add input files to the DAX-level replica catalog

            rc.add_replica('local', File('deg2utm'), os.path.join(self.bindir, 'deg2utm'))
            rc.add_replica('local', File('utm2deg'), os.path.join(self.bindir, 'utm2deg'))
            wf.add_replica_catalog(rc)

            # Add job(s) to the workflow

            # Note: on CCR, the current directory is not added to $PATH automatically.
            # On Ghub, .add_outputs register_replica must be set to False (the default is True) to prevent
            # Pegasus from returning with a post script failure.

            deg2utm_job = Job(matlablaunch)\
                .add_args('''./deg2utm %s %s''' %(self.latitude, self.longitude))\
                .add_inputs(File('deg2utm'))\
                .add_outputs(File('utm.txt'), stage_out=True, register_replica=False)\
                .add_metadata(time='%d' %self.maxwalltime)
                
            wf.add_jobs(deg2utm_job)

            utm2deg_job = Job(matlablaunch)\
                .add_args('''./utm2deg''')\
                .add_inputs(File('utm2deg'))\
                .add_inputs(File('utm.txt'), bypass_staging=True)\
                .add_outputs(File('deg.txt'), stage_out=True, register_replica=False)\
                .add_metadata(time='%d' %self.maxwalltime)
                
            wf.add_jobs(utm2deg_job)
            
            # utm2deg_job depends on the deg2utm_job completing
            
            wf.add_dependency(utm2deg_job, parents=[deg2utm_job])

            #########################################################
            # Create the Pegasus Workflow YML file
            #########################################################
    
            # Create the YML file
            try:
                wf.write()
            except PegasusClientError as e:
                print(e)

            # Verify contents
            #fp = open('workflow.yml', 'r')
            #file_contents = fp.read()
            #print (file_contents)
            #fp.close()
            
            sys.stdout.flush()
            
            #########################################################
            # Submit the Pegasus Workflow Plan
            #########################################################
    
            #'''
            submitcmd = ['submit', '--venue', 'WF-vortex-ghub', 'pegasus-plan', '--dax', 'workflow.yml']
            #print ('submitcmd: ', submitcmd)

            # submit blocks.
            exitCode,pegasusStdout,pegasusStderr = hublib.cmd.command.executeCommand(submitcmd,streamOutput=True)

            if (exitCode == 0):

                return

            else:
            
                # In this case, look for .stderr and .stdout files in the work directory
                print ('Wrapper.py: hublib.cmd.command.executeCommand(%s) returned with a non zero exit code = %d\n' %(submitcmd, exitCode))
                files = os.listdir(self.workingdir)
                files.sort(key=lambda x: os.path.getmtime(x))
                for file in files:
                    # Get the numbered Pegasus work directory
                    #print ('type(file): ', type(file)) #<class 'str'>
                    if os.path.isfile(file) and file[0].isdigit() and file.endswith('.stderr'):
                        print ('stderr file: %s\n' %os.path.join(self.workingdir, file))
                        print ('For the ghubex1 tool, the following errors were returned while running a Pegasus workflow: ')
                        with open(file) as f:
                            lines = f.readlines()
                            for line in lines:
                                if 'WARNING' not in line:
                                    print (line)
                        # In case there is more than one stderr file in the working directory
                        break
                return
              #'''
             
        except Exception as e:
            
            print ('Wrapper.py Exception: %s\n' %str(e))
            
        return


#######################################################

if __name__ == '__main__':

    print ('sys.argv: ', sys.argv)

    parent = sys.argv[1]
    tooldir = sys.argv[2]
    bindir = sys.argv[3]
    datadir = sys.argv[4]
    workingdir = sys.argv[5]
    rundir = sys.argv[6]
    latitude = sys.argv[7]
    longitude = sys.argv[8]
    maxwalltime = sys.argv[9]
    
    Wrapper(parent, tooldir, bindir, datadir, workingdir, rundir, latitude, longitude, maxwalltime)
