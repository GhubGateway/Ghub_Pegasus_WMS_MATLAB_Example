## Pegasus WMS Workflow MATLAB Example

- Provides a template for hosting a GitHub tool on the GHub Science Gateway and running a GHub Pegasus Workflow Management System (WMS) workflow comprising MATLAB executables, on the University at Buffalo (UB)'s Center For Computational Research (CCR)'s generally accessible high performance compute cluster, UB-HPC.
- See https://theghub.org for more information on the GHub Science Gateway.<br /> 
- See https://www.buffalo.edu/ccr.html for more information on CCR.<br />
- See https://pegasus.isi.edu/documentation/index.html for more information on the Pegasus WMS.<br /> 
- See https://www.mathworks.com/matlabcentral/fileexchange/10915-deg2utm?status=SUCCESS and https://www.mathworks.com/matlabcentral/fileexchange/10914-utm2deg?s_tid=FX_rc1_behavfor for more information on the MATLAB coordinate conversion scripts used for this exercise.

### Description of files and directories provided by this template:

The GHub tool name alias for this template is ghubex3. The files provided by this template are specific for the ghubex3 tool. You will need to replace the files with files specific for your tool as required.

#### ghubex3.ipynb

This Jupyter Notebook provides the user interface for the ghubex3 tool.

#### matlabBuild.ipynb

This Jupyter Notebook provides a mechanism to compile the MATLAB executables required by the ghubex3 tool on CCR and in compliance with the current CCR MATLAB license.

The MATLAB executables are compiled on CCR using the MATLAB mcc function.

For provenance tracking, the compiled MATLAB executables are retained in your tool's bin directory.

#### bin directory

This directory contains the submit wrapper script, buildWrapper.py, used to compile the MATLAB executables on CCR. The compiled MATLAB executables are moved to this directory. This directory also contains the submit wrapper script, launchWrapper.py, used to plan and run the Pegasus WMS workflow. 

#### remoteBin directory

This directory contains the bash script, matlabBuild.sh, used to build the MATLAB executables. This directory also contains the bash script, matlabLaunch.sh, used by the Pegasus WMS to launch the MATLAB executables.

#### middleware directory

This directory contains the invoke script which enables the ghubex3.ipynb Jupyter Notebook to be launched on GHub.

Note: the invoke script must have the executable file permission bits set. For example, use chmod 755 invoke to set the executable file permission bits.

### Create Your Tool on GHub:

Follow the instructions on the https://theghub.org/tools/create web page.  Enter the alias name of your tool, for this template, ghubex3 was entered. Select the Repository Host, Host GIT repository on Github, Gitlab. Enter the Git Repository URL, for this tool, https://github.com/GhubGateway/Ghub_Pegasus_WMS_MATLAB_Example was entered. Select the Publishing Option, Jupyter Notebook. 

Note: when a new tool is created you will receive an email with a link to the tool's status page. The tool's status page will allow you to let the GHub administrators know when you are ready to update, install, approve or publish your tool.

Note: published tools are launched from the GHub Dashboard's My Tools component.

### Update Your Tool:

1) Launch the Workspace 10 Tool from the GHub Dashboard's My Tools component and in a xterm terminal window enter:

	git clone https://github.com/GhubGateway/Ghub_Pegasus_WMS_MATLAB_Example ghubex3

	git clone https://theghub.org/tools/\<your tool alias name\>/git/\<your tool alias name\> \<your tool alias name\>

2) Copy ghubex3 template files to your tool's src, bin and remotebin directories as required.

3) Update / replace the files in your tool's src, bin and remotebin directories with files specific for your tool as required. See below for more information.

#### Compile the MATLAB Executables for Your Tool:

1) Replace the scripts in your tool's src directory with the scripts required for your tool.
2) Update the matlabBuild.sh script in your tool's remotebin directory with the script required your your tool.
3) Launch the Jupyter Notebooks (202210) tool from the GHub Dashboard's My Tools component tool and open the \<your tool alias name\>/matlabBuild.ipynb Jupyter Notebook.
4) Update the self_binfiles list in the matlabBuild.ipynb notebook with the MATLAB executables required for your tool.
5) Save the notebook update.
6) Click the Appmode button.
7) Click the Run Workflow button to compile the MATLAB executables. The MATLAB scripts in your tool's src directory are compiled on CCR and the returned MATLAB executables are moved your tools's bin directory.

#### Launch the MATLAB Executables for Your Tool:

1) Update the launchWrapper.py in your tool's bin directory and the matlabLaunch.sh script in your tool's remotebin directory with the scripts required your your tool.
2) Launch the Jupyter Notebooks (202210) tool from the GHub Dashboard's My Tools component tool and open the \<your tool alias name\>/\<your tool alias name\>.ipynb Jupyter Notebook.
3) Update \<your tool alias name\>/\<your tool alias name\>.ipynb with the user interface required for your tool.
4) Save the notebook updates.
5) Click the Appmode button.
6) Click the Run Workflow button to launch the MATLAB executables.

