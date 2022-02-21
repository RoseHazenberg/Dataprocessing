#A fake workspace with FASTQ files

This directory contains fake data for demonstration purposes. The fake data is needed to run the pipeline script.  
This is project is a part of the course data processing of the study Bioinformatics at Hanze University of Applied Science year 3.

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
Set the path to `{path}/DataProcessing/tutorial_01` in the activated virtualenv.

```
# Run the snakefile
snakemake --snakefile workflow/rules/main.smk --cores 1
```

```
# The output should look like this
Building DAG of jobs...
Using shell: /usr/bin/bash
Provided cores: 1 (use --cores to define parallelism)
Rules claiming more threads will be scaled down.
Job counts:
        count   jobs
        1       all
        3       quantify_genes
        4

[Mon Feb 21 15:07:27 2022]
rule quantify_genes:
    input: data/genome.fa, data/Sample1.R1.fastq.gz, data/Sample1.R2.fastq.gz
    output: results/Sample1.txt
    jobid: 1
    wildcards: sample=Sample1

[Mon Feb 21 15:07:27 2022]
Finished job 1.
1 of 4 steps (25%) done

[Mon Feb 21 15:07:27 2022]
rule quantify_genes:
    input: data/genome.fa, data/Sample2.R1.fastq.gz, data/Sample2.R2.fastq.gz
    output: results/Sample2.txt
    jobid: 2
    wildcards: sample=Sample2

[Mon Feb 21 15:07:27 2022]
Finished job 2.
2 of 4 steps (50%) done

[Mon Feb 21 15:07:27 2022]
rule quantify_genes:
    input: data/genome.fa, data/Sample3.R1.fastq.gz, data/Sample3.R2.fastq.gz
    output: results/Sample3.txt
    jobid: 3
    wildcards: sample=Sample3

[Mon Feb 21 15:07:27 2022]
Finished job 3.
3 of 4 steps (75%) done

[Mon Feb 21 15:07:27 2022]
localrule all:
    input: results/Sample1.txt, results/Sample2.txt, results/Sample3.txt
    jobid: 0

[Mon Feb 21 15:07:27 2022]
Finished job 0.
4 of 4 steps (100%) done
```

To clean the output of the results use:

```
# To deleted the files
snakemake --snakefile workflow/rules/main.smk clean --cores 1

# Which should give
Building DAG of jobs...
Using shell: /usr/bin/bash
Provided cores: 8
Rules claiming more threads will be scaled down.
Job counts:
        count   jobs
        1       clean
        1

[Mon Feb 21 15:09:40 2022]
rule clean:
    jobid: 0

[Mon Feb 21 15:09:40 2022]
Finished job 0.
1 of 1 steps (100%) done
```

## Results

The files of the results from the workflow contains the following information

```
data/genome.fa data/Sample1.R1.fastq.gz data/Sample1.R2.fastq.gz
data/genome.fa data/Sample2.R1.fastq.gz data/Sample2.R2.fastq.gz
data/genome.fa data/Sample3.R1.fastq.gz data/Sample3.R2.fastq.gz
```

## Author and support
For any information of questions please contact the author.  
Rose Hazenberg c.r.hazenberg@st.hanze.nl
