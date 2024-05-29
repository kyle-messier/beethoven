#!/bin/bash

#SBATCH --job-name=pipeline_bench
#SBATCH --output=/ddn/gs1/home/songi2/projects/beethoven/pipeline_out.out
#SBATCH --error=/ddn/gs1/home/songi2/projects/beethoven/pipeline_err.err
#SBATCH --mail-type=END,FAIL
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=100
#SBATCH --mem-per-cpu=8g
#SBATCH --partition=geo
#SBATCH --mail-user=songi2@nih.gov

# source /ddn/gs1/home/songi2/.profile
export PROJECT_HOME=/ddn/gs1/home/songi2/projects/beethoven
# nohup nice -4 Rscript /ddn/gs1/home/songi2/projects/beethoven/inst/targets/targets_start.R
nohup nice -4 apptainer exec --writable-tmpfs --env R_PROFILE_USER=/dev/null --bind $PROJECT_HOME:/pipeline --pwd /pipeline $PROJECT_HOME/r-image-05292024.sif Rscript inst/targets/targets_start.R