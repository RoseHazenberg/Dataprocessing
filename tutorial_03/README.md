# About Data Exercises

This directory contains the pipeline and the results of tutorial 3.
This is project is a part of the course data processing of the study Bioinformatics at Hanze University of Applied Science year 3.

![](images/dag.svg)

## Installation

Create a python3 virtual environment and install snakemake
```
python3 -m venv {path/to/new/virtual/environment}  #create a virtualenv
source {path/to/new/virtual/environment}/bin/activate #activate the virtualenv (linux/macOS)
{path/to/new/virtual/environment}/Scripts/activate #activate the virtualenv (windows)

pip3 install snakemake {name} 

deactivate #to deactivate the virtualenv
```

## Usage

To run the pipeline activate the virtualenv as described in `installation`.  
Set the path to `{path}/DataProcessing/tutorial_03` in the activated virtualenv.  
There are different files which can be run with the following commands.

```
# Run the snakefile
snakemake --snakefile workflow/rules/HTTP.smk --cores 2
snakemake --snakefile workflow/rules/NCBI.smk --cores 2
snakemake --snakefile workflow/rules/configuration.smk --cores 2
snakemake --snakefile workflow/rules/main.smk --cores 2
```

## Results

The results of the `workflow/rules/HTTP.smk` can be found in the file `results/test.txt`. The results of the workflow `workflow/rules/NCBI.smk` can be found in `results/test.fasta`.
And the report of the workflow of the file `workflow/rules/configuration.smk` can be found in the directory `data/[ABCDEFGHIJ].bam`.
The image above shows the workflow of the file `workflow/rules/main.smk` which contains all the .smk files.


## Author and support
For any information of questions please contact the author.  
Rose Hazenberg c.r.hazenberg@st.hanze.nl
