## Pegasus WMS MATLAB Workflow Example

- Demonstrates hosting a GitHub tool on the Ghub Science Gateway and running a Ghub Pegasus Workflow Management System (WMS) MATLAB executables workflow on the University at Buffalo (UB)'s Center For Computational Research (CCR)'s generally accessible high performance compute cluster, UB-HPC.
- See https://theghub.org for more information on the Ghub Science Gateway.<br /> 
- See https://www.buffalo.edu/ccr.html for more information on CCR.<br />
- See https://pegasus.isi.edu/documentation/index.html for more information on the Pegasus WMS.<br /> 
- See https://www.mathworks.com/matlabcentral/fileexchange/10915-deg2utm?status=SUCCESS and https://www.mathworks.com/matlabcentral/fileexchange/10914-utm2deg?s_tid=FX_rc1_behavfor for more information on the MATLAB coordinate conversion scripts used for this exercise.

### Requirements:

#### ghub_exercise3.ipynb

This Jupyter Notebook provides the user interface for the Pegasus WMS workflow.

#### src directory

This directory contains the MATLAB scripts to run on CCR's high performance compute cluster. The MATLAB scripts need to be compiled on CCR and the executables copied to the bin directory and committed. See src/build_matlab_executables.sh for more information. If you need assistance compiling the MATLAB scripts for your tool, please open a Ghub support ticket.

#### bin directories

This directory contains the MATLAB executables to run on CCR's high performance compute cluster. See the src/build_matlab_executables.sh for more information.

Note: the executable files must have the executable file permission bits set. For example, use chmod 755 deg2utm and chmod 755 utm2deg to set the executable file permissions bits.

#### remoteBin directory

This directory contains the bash script, matlabLaunch.sh, used by the Pegasus WMS to launch the MATLAB executables contained in the bin directory. See remotebin/matlabLaunch.sh for details. 

#### middleware directory

This directory contains the invoke script which enables the ghub_exercise3.ipynb Jupyter Notebook to be launched on Ghub.

Note: the invoke script must have the executable file permission bits set. For example, use chmod 755 invoke to set the executable file permission bits.

### Create New Tool on Ghub:

Note: created tools are launched from the Ghub Dashboard's My Tools component.

Note: when a new tool is created you will receive an email with a link to the tool's status page. The tool's status page will allow you to let the Ghub administrators know when you are ready to update, install, approve or publish your tool.

#### Host GIT repository on Github, Gitlab

Follow the instructions on the https://theghub.org/tools/create web page. Select the Repository Host, Host GIT repository on Github, Gitlab. Select the Publishing Option, Jupyter Notebook. Enter the name of your tool, for example, ghubex3.

#### Host subversion repository on HUB

Alernately, follow the instructions on the https://theghub.org/tools/create web page to create a new tool and select the Repository Host: Host subversion repository on HUB. Select the Publishing Option, Jupyter Notebook, and enter the name of your tool, for example, ghubex3.

In this case, the middleware/invoke script will be created automatically and stored in the subversion repository (svn) on Ghub. You will need to add ghub_exercise1.ipynb and the bin and remotebin directory files to the svn repository.

Example svn commands:

Enter svn checkout https://theghub.org/tools/ghubex3/svn/trunk ghubex3 to checkout files from the svn repository for your tool.<br />
Enter svn add <filename> to add files to the svn repository.<br />
Enter svn commit -m "commit message" to check updates into the svn repository.<br />

### Run the Tool on Ghub for Testing after the Tool is installed:

#### Launch the Workspace 10 Tool from the Ghub Dashboard's My Tools component and in a xterm terminal window enter:<br />

```
git clone https://github.com/GhubGateway/Ghub_Pegasus_WMS_MATLAB_Example
```
#### Launch the Jupyter Notebooks (202210) Tool from the Ghub Dashboard's My Tools component:<br />

Open ghub_exercise1/ghub_exercise3.ipynb.<br />
Click the Appmode button.<br />
