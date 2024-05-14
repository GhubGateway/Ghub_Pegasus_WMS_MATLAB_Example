## Pegasus WMS Workflow MATLAB Example

This Jupyter Notebook tool provides a template for running a Ghub Science Gateway Pegasus Workflow Management System (WMS) workflow, comprising MATLAB executables, on the University at Buffalo (UB)'s Center For Computational Research (CCR)'s generally accessible high performance compute cluster, UB-HPC.

The Ghub tool name for this template is ghubex3. The files provided by this template are specific for the ghubex3 tool. You will need to update / replace the files with files specific for your tool as required.

- See https://theghub.org for more information on the Ghub Science Gateway.<br /> 
- See https://www.buffalo.edu/ccr.html for more information on the Center For Computational Research (CCR).<br />
- See https://pegasus.isi.edu/documentation/index.html for more information on the Pegasus WMS.<br /> 
- See https://www.mathworks.com/matlabcentral/fileexchange/10915-deg2utm?status=SUCCESS and https://www.mathworks.com/matlabcentral/fileexchange/10914-utm2deg?s_tid=FX_rc1_behavfor for more information on the MATLAB coordinate conversion scripts used for this template.

### Description of files and directories provided by this template:

#### ghubex3.ipynb

This Jupyter Notebook provides the user interface for the ghubex3 tool.

#### matlabBuild.ipynb

This Jupyter Notebook provides a mechanism to compile the MATLAB executables required by the ghubex3 tool on CCR and in compliance with the current CCR MATLAB license.

The MATLAB executables are compiled on CCR using the MATLAB mcc function.

For provenance tracking, the compiled MATLAB executables are retained in your tool's bin directory.

#### doc directory

This directory contains the PDF file, Ghub_Pegasus_WMS_Workflow_MATLAB_Example.pdf.

#### bin directory

This directory contains the submit wrapper script, buildWrapper.py, used to compile the MATLAB executables on CCR. The compiled MATLAB executables are moved to this directory. This directory also contains the submit wrapper script, launchWrapper.py, used to plan and run the Pegasus WMS workflow jobs on CCR. 

#### remoteBin directory

This directory contains the bash script, matlabBuild.sh, used to build the MATLAB executables. This directory also contains the bash script, matlabLaunch.sh, used by the Pegasus WMS to launch the MATLAB executables.

#### middleware directory

This directory contains the invoke script which enables the ghubex3.ipynb Jupyter Notebook to be launched on Ghub.

Note: the invoke script must have the executable file permission bits set. For example, use chmod 755 invoke to set the executable file permission bits.

### Create Your Tool on Ghub:

#### Host GIT repository on HUB

Follow the instructions on the https://theghub.org/tools/create web page.  Enter a name for your tool, for this template, ghubex3 was entered. Select the Repository Host, Host GIT repository on HUB. Select the Publishing Option, Jupyter Notebook. 

Note: when a new tool is created you will receive an email with a link to the tool's status page. The tool's status page will allow you to let the Ghub administrators know when you are ready to update, install, approve or publish your tool.

Note: published tools are launched from the Ghub Dashboard's My Tools component.

### Update Your Tool:

1) Launch the Workspace 10 Tool from the Ghub Dashboard's My Tools component and in a xterm terminal window enter:

	git clone https://github.com/GhubGateway/Ghub_Pegasus_WMS_MATLAB_Example ghubex3

	git clone https://theghub.org/tools/\<your tool name\>/git/\<your tool name\> \<your tool name\>

2) Copy ghubex3/matlabBuild.ipynb to \<your tool name\>/matlabBuild.ipynb.

3) Copy template files from the ghubex3 src, bin and remotebin directories to your tool's src, bin and remotebin directories.

4) Update / replace the scripts in your tool's src directory with the scripts required for your tool.

5) Update the matlabBuild.sh script in your tool's remotebin directory with the script required your your tool.

6) Update the launchWrapper.py script in your tool's bin directory with the script required your your tool.

7) Compare the invoke script in your tool's middleware directory with the invoke script in the ghubex3 middleware directory and update as required.

### Compile the MATLAB Executables for Your Tool:

1) Launch the Jupyter Notebooks (202210) tool from the Ghub Dashboard's My Tools component tool and open the \<your tool name\>/matlabBuild.ipynb Jupyter Notebook.

2) Update the self_binfiles list in the matlabBuild.ipynb notebook with the MATLAB executables required for your tool.

3) Save the notebook update.

4) Click the Appmode button.

5) Click the Run Workflow button to compile the MATLAB executables. The MATLAB scripts in your tool's src directory are compiled on CCR and the returned MATLAB executables are moved your tools's bin directory.

### Launch the MATLAB Executables for Your Tool:

1) Launch the Jupyter Notebooks (202210) tool from the Ghub Dashboard's My Tools component tool and open the \<your tool name\>/\<your tool name\>.ipynb Jupyter Notebook.

2) Update \<your tool name\>/\<your tool name\>.ipynb with the user interface required for your tool.

3) Save the notebook updates.

4) Click the Appmode button.

5) Click the Run Workflow button to launch the MATLAB executables.

### Commit Your Tool Updates:

1) Enter git add to add a new file or to update an existing file.

2) Enter git commit -m "commit message"  to describe your updates.

3) Enter git push origin master to push your updates to GIT repository on Ghub.

