## https://github.com/rljbufny1/ghub_exercise3

- Demonstrates the procedure for hosting the Github tool, ghub_exercise3, on the Ghub Science Gateway.
- Demonstrates running a Ghub Pegasus Workflow Management System (WMS) workflow with MATLAB coordinate conversion executables on University at Buffalo (UB)'s Center For Computational Research (CCR)'s generally accessible high performance compute cluster, UB-HPC.
- See https://theghub.org for more information on the Ghub Science Gateway.<br /> 
- See https://www.buffalo.edu/ccr.html for more information on CCR.<br />
- See https://pegasus.isi.edu/documentation/index.html for more information on the Pegasus WMS.<br /> 
- See https://www.mathworks.com/matlabcentral/fileexchange/10915-deg2utm?status=SUCCESS and https://www.mathworks.com/matlabcentral/fileexchange/10914-utm2deg?s_tid=FX_rc1_behavfor for more information on the MATLAB coordinate conversion scripts used for this exercise.

### Requirements:

#### ghub_exercise3.ipynb

#### src and bin directories

The MATLAB scripts need to be compiled on CCR and the executables copied to the bin directory. See src/build_matlab_executables.sh for more information.

Note: the executable files must have the executable file permission bits set. For example, use chmod 755 deg2utm and chmod 755 utm2deg to set the executable file permissions bits.

#### middleware directory

This directory contains the invoke script which enables the ghub_exercise3.ipynb Jupyter Notebook to be launched on Ghub.

Note: the invoke script must have the executable file permission bits set. For example, use chmod 755 invoke to set the executable file permission bits.

### Install and Run the Tool on Ghub for Initial Testing (optional):

#### Launch the Workspace 10 Tool from the Ghub Dashboard's My Tools component and in a xterm terminal window enter:<br />

```
git clone https://github.com/rljbufny/ghub_exercise3
```
or 
```
wget https://github.com/rljbufny/ghub_exercise3/releases/download/v1.0.0/ghub_exercise3-src.tar.gz
tar xvzf ghub_exercise3-src.tar.gz
```

#### Launch the Jupyter Notebooks (202210) Tool from the Ghub Dashboard's My Tools component:<br />

Open ghub_exercise3/ghub_exercise3.ipynb.<br />
Click the Appmode button.<br />

### Create New Tool on Ghub:

Note: created tools are launched from the Ghub Dashboard's My Tools component.

Note: when a new tool is created you will receive an email with a link to the tool's status page. The tool's status page will allow you to let the Ghub administrators know when you are ready to install updates for your tool or publish your tool.

#### Host GIT repository on Github, Gitlab

Follow the instructions on the https://theghub.org/tools/create web page. Select the Repository Host, Host GIT repository on Github, Gitlab. Select the Publishing Option, Jupyter Notebook.   Enter the name of your tool, for example, ghubex3. The name of your tool should be the same as the name of your tool specfied in the middleware/invoke script's /usr/bin/invoke_app's -t option.  

#### Host subversion repository on HUB

Alernately, follow the instructions on the https://theghub.org/tools/create web page to create a new tool and select the Repository Host: Host subversion repository on HUB. Select the Publishing Option, Jupyter Notebook, and enter the name of your tool, for example, ghubex3.

In this case, the middleware/invoke script will be created automatically and stored in the subversion repository (svn) on Ghub. You will need to add ghub_exercise3.ipynb and the src and bin directory files to the svn repository.

Example svn commands:

Enter svn checkout https://theghub.org/tools/ghubex3/svn/trunk ghubex3 to checkout files from the svn repository for your tool.<br />
Enter svn add <filename> to add files to the svn repository.<br />
Enter svn commit -m "commit message" to check updates into the svn repository.<br />

