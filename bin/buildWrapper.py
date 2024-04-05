#----------------------------------------------------------------------------------------------------------------------
# Class: buildWrapper
# Component of: ghubex3 (github.com)
# Purpose: Build matlab executables on CCR
# Author: Renette Jones-Ivey
# Date: March 2024
#---------------------------------------------------------------------------------------------------------------------

import ast
import os
import sys
import glob

#Reference: https://stackoverflow.com/questions/4836710/is-there-a-built-in-function-for-string-natural-sortdef natural_sort(l):
import re

def natural_sort(l):
    convert = lambda text: int(text) if text.isdigit() else text.lower()
    alphanum_key = lambda key: [convert(c) for c in re.split('([0-9]+)', key)]
    return sorted(l, key=alphanum_key)

#import Rappture
#from Rappture.tools import executeCommand as RapptureExec
# Modified for Python 2 to 3
import hublib.cmd
#help (hublib.cmd.command.executeCommand)

# API for generating Pegasus YML files
from Pegasus.api import *

# Wrapper class
# Called from ghubex3.ipynb
class buildWrapper():
    
    def __init__(self, parent, workingdir, binfiles, maxwalltime):

        self.parent = parent
        self.workingdir = workingdir
        self.binfiles = binfiles
        self.maxwalltime = maxwalltime

        #'''
        print('self.parent: ', self.parent)
        print('self.workingdir: ', self.workingdir)
        print('self.binfiles: ', self.binfiles)
        print('self.maxwalltime: ', self.maxwalltime)
        #'''
        
        self.run()

    def run(self):

        try:

            #########################################################
            # Create the Pegasus WMS workflow
            #########################################################
            print ('buildWrapper...')
    
            wf = Workflow('matlabBuild-workflow')
            tc = TransformationCatalog()
            wf.add_transformation_catalog(tc)
            rc = ReplicaCatalog()
            wf.add_replica_catalog(rc)

            # See ../build_matlab_executables.sh for more information on creating the MATLAB executables for this tool.

            # Add the MATLAB launch script to the transformation catalog. The launch script is run on CCR to run the MATLAB executables.
                
            tooldir = os.path.dirname(os.path.dirname(os.path.realpath(os.path.abspath(__file__))))
            print ('tooldir: ', tooldir)
            remotebindir = os.path.join(tooldir, "remotebin")
            print ('remotebindir: ', remotebindir)
            srcdir = os.path.join(tooldir, "src")
            print ('srcdir: ', srcdir)

            matlab_build_exec_path =  os.path.join(remotebindir, 'matlabBuild.sh')
            print ("matlab_build_exec_path: %s" %matlab_build_exec_path)
            
            matlabBuild = Transformation(
                'matlabBuild',
                site='local',
                pfn=matlab_build_exec_path,
                is_stageable = True, #Stageable or installed
                arch=Arch.X86_64,
                os_type=OS.LINUX,
                os_release="rhel")

            tc.add_transformations(matlabBuild)
 
            # All files in a Pegasus workflow are referred to in the DAX using their Logical File Name (LFN).
            # These LFNs are mapped to Physical File Names (PFNs) when Pegasus plans the workflow.
            # Add input files to the DAX-level replica catalog
            
            # Add job to the workflow

            # On Ghub, .add_outputs register_replica must be set to False (the default is True) to prevent
            # Pegasus from returning with a post script failure.

            build_job = Job(matlabBuild)\
                .add_metadata(time='%d' %self.maxwalltime)

            srcfilepaths = natural_sort(glob.glob(srcdir + '/*.m'))
            print ('srcfilepaths: ', srcfilepaths)
            
            for i in range(len(srcfilepaths)):
            
                srcfile = os.path.basename(srcfilepaths[i])
                rc.add_replica('local', File('%s' %srcfile), os.path.join(srcdir, '%s' %srcfile))
                build_job.add_inputs(File('%s' %srcfile))
            
            for i in range(len(self.binfiles)):
                
                binfile = self.binfiles[i]
                build_job.add_outputs(File('%s' %binfile), stage_out=True, register_replica=False)
                
            wf.add_jobs(build_job)

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
                print ('buildWrapper.py: hublib.cmd.command.executeCommand(%s) returned with a non zero exit code = %d\n' %(submitcmd, exitCode))
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
            
            print ('buildWrapper.py Exception: %s\n' %str(e))
            
        return


#######################################################

if __name__ == '__main__':

    print ('sys.argv: ', sys.argv)

    parent = sys.argv[1]
    workingdir = sys.argv[2]
    binfiles = sys.argv[3]
    maxwalltime = sys.argv[4]
    
    buildWrapper(parent, workingdir, maxwalltime)
