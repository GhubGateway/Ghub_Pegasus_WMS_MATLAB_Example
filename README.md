## Pegasus WMS Workflow MATLAB Example

- Demonstrates hosting a GitHub tool on the Ghub Science Gateway and running a Ghub Pegasus Workflow Management System (WMS) workflow, comprising MATLAB executables, on the University at Buffalo (UB)'s Center For Computational Research (CCR)'s generally accessible high performance compute cluster, UB-HPC.
- See https://theghub.org for more information on the Ghub Science Gateway.<br /> 
- See https://www.buffalo.edu/ccr.html for more information on CCR.<br />
- See https://pegasus.isi.edu/documentation/index.html for more information on the Pegasus WMS.<br /> 
- See https://www.mathworks.com/matlabcentral/fileexchange/10915-deg2utm?status=SUCCESS and https://www.mathworks.com/matlabcentral/fileexchange/10914-utm2deg?s_tid=FX_rc1_behavfor for more information on the MATLAB coordinate conversion scripts used for this exercise.

### Launch the MATLAB Executables:

To compile the MATLAB Executables, see the Compile the MATLAB Executables section below.

#### ghubex3.ipynb

This Jupyter Notebook provides the user interface for the Pegasus WMS workflow.

#### src directory

This directory contains the MATLAB scripts for this tool. 

#### bin directory

This directory contains the submit wrapper script, launchWrapper.py, used to plan the Pegasus WMS workflow. This directory also contains the compiled MATLAB executables.

#### remoteBin directory

This directory contains the bash script, matlabLaunch.sh, used by the Pegasus WMS to launch the MATLAB executables.

#### middleware directory

This directory contains the invoke script which enables the ghubex3.ipynb Jupyter Notebook to be launched on Ghub.

Note: the invoke script must have the executable file permission bits set. For example, use chmod 755 invoke to set the executable file permission bits.

### Create New Tool on Ghub:

Note: created tools are launched from the Ghub Dashboard's My Tools component.

Note: when a new tool is created you will receive an email with a link to the tool's status page. The tool's status page will allow you to let the Ghub administrators know when you are ready to update, install, approve or publish your tool.

Follow the instructions on the https://theghub.org/tools/create web page.  Enter the name of your tool, for this tool, ghubex3 was entered. Select the Repository Host, Host GIT repository on Github, Gitlab. Enter the Git Repository URL, for this tool, https://github.com/GhubGateway/Ghub_Pegasus_WMS_MATLAB_Example was entered. Select the Publishing Option, Jupyter Notebook. 

### Run the Tool on Ghub for Testing after the Tool is installed:

#### Launch the Workspace 10 Tool from the Ghub Dashboard's My Tools component and in a xterm terminal window enter:<br />

```
git clone https://github.com/GhubGateway/Ghub_Pegasus_WMS_MATLAB_Example ghubex3
```
#### Launch the Jupyter Notebooks (202210) Tool from the Ghub Dashboard's My Tools component:<br />

##### Launch the MATLAB Executables

Open ghubex3/ghubex3.ipynb.<br />
Click the Appmode button.<br />
Click the Run Workflow button to lauch the MATLAB ececutables.<br />

##### Compile the MATLAB Executables

### Build The MATLAB Exectables:

This section is intended for tool developers.

#### matlabBuild.ipynb

This Jupyter Notebook provides tool developers a mechanism to compile the MATLAB executables on CCR from the MATLAB scripts in the src directory and copy the compiled MATLAB executables to the bin directory.<br /> 

Open ghubex3/matlabBuild.ipynb.<br />
Click the Appmode button.<br />
Click the Run Workflow button to compile the MATLAB ececutables.<br />

#### src directory

This directory contains the MATLAB scripts for this tool. 

#### bin directory

This directory also contains the submit wrapper script, buildWrapper.py. Compiled MATLAB executables are copied to this directory.

#### remoteBin directory

This directory also contains the bash script, matlabBuild.sh.

