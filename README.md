## https://github.com/rljbufny1/ghub_exercise1

- Demonstrates the procedure for hosting the Github tool, ghub_exercise1, on Ghub.
- Demonstrates running a Ghub Pegasus Workflow Management System (WMS) workflow with MATLAB coordinate conversion executables on University at Buffalo (UB)'s Center For Computational Research (CCR)'s generally accessible high performance compute cluster, UB-HPC.
- See https://theghub.org for more information on the Ghub Science Gateway.<br /> 
- See https://www.buffalo.edu/ccr.html for more information on CCR.<br />
- See https://pegasus.isi.edu/documentation/index.html for more information on the Pegasus WMS.<br /> 
- See https://www.mathworks.com/matlabcentral/fileexchange/10915-deg2utm?status=SUCCESS and https://www.mathworks.com/matlabcentral/fileexchange/10914-utm2deg?s_tid=FX_rc1_behavfor for more information on the MATLAB coordinate conversion scripts used for this exercise.

### Requirements:

#### ghub_exercise1.ipynb

#### src and bin directories

The MATLAB scripts need to be compiled on CCR and the executables copied to the bin directory. See src/build_matlab_executables.sh for more information.

Note: The executable files must have the executable file permission bits set. For example, use chmod 755 deg2utm and chmod 755 utm2deg to set the executable file permissions bits.

#### middleware directory

The middleware directory contains the invoke script which enables the ghub_exercise1.ipynb Jupyter Notebook to be launched on Ghub from the Ghub Dashboard's My Tools component.

Note: The invoke script must have the executable file permission bits set. For example, use chmod 755 invoke to set the executable file permission bits.

### Install and Run the Tool on Ghub for Initial Testing (optional):

#### Launch the Workspace 10 Tool from the Ghub Dashboard's My Tools component and in a xterm terminal window enter:<br />

```
git clone https://github.com/rljbufny1/ghub_exercise1
```
or 
```
wget https://github.com/rljbufny1/ghub_exercise1/releases/download/v1.0.0/ghub_exercise1-src.tar.gz
tar xvzf ghub_exercise1-src.tar.gz
```

#### Launch the Jupyter Notebooks (202210) Tool from the Ghub Dashboard's My Tools component:<br />

Open ghub_exercise1/ghub_exercise1.ipynb.<br />
Click the Appmode button.<br />

### Create New Tool on Ghub:

Follow the instructions on the https://theghub.org/tools/create web page. Select the Repository Host, Host GIT repository on Github, Gitlab, etc.. Select the Publishing Option, Jupyter Notebook.  

Note: created tools are launched from the Ghub Dashboard's My Tools component.
