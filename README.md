# off-target-RNA-editing-analyses
This is part of the work published by Elena Lesch 2023. 

README for extractionPG.sh script, developed by Philipp Gerke

### Description
This Bash script is designed to extract sequences surrounding nucleotide positions of interest.
Sequences are extracted from an input FASTA file based on positions and forward/reverse indicators provided in a CSV file.

### Requirements

Bash Shell: Ensure you have access to a Bash shell to run the script.

Input Files:

CSV File: Provide the path to the input CSV file. The CSV file should not contain a header row and should use TAB as the delimiter. The first column should contain the nucleotide positions of interest and the second column should contain the reverse indicator (0=fwd,1=rev)

FASTA File: Provide the path to the input FASTA file. The FASTA file should be in a single-line format.

Calculation Parameters:
b_edit: The number of nucleotides to extract before the position of interest.
a_edit: The number of nucleotides to extract after the position of interest.

Output File Name: Set the desired output file name by modifying the out_n variable. The output file must end with ".csv".

### Usage
Modify the script's configuration variables as needed to match your data and analysis requirements.

Open a terminal and navigate to the directory containing the script.

Make the script executable by executing "chmod +x SCRIPT.sh"

Run the script by executing "SCRIPT.sh".

### Script description

The script will execute and perform the following steps:
Gather information from the CSV file.
Calculate extraction positions based on the editing position and reverse indicators.
Extract sequences from the FASTA file.
Generate a new CSV file with the extracted sequences added as columns.
Provide a final tab-delimited CSV file for easy data analysis.

### Important Notes

Ensure that your input files are correctly formatted and that you've provided the correct paths in the script configuration:
The script is designed to work with CSV files without header rows and FASTA files with sequences in a single-line format.
The script is designed to work with single FASTAs, not on multi-FASTA (containing multiple FASTA sequences).

Readme for R Script "JCSC", developed by Simon Maria Zumkeller

### Description

This R script is designed to process a CSV file containing SNVs derived from JACUSA variant calls, aggregate the data per genomic positon of individual SNVs, and then generate an output CSV file with the processed information.

### Requirements

To run this script, you need to have R installed on your system. Additionally, you need to have the following R packages installed:
dplyr
data.table
tidyverse
You can install these packages using the install.packages() function, as shown in the script's header section.

JACUSA/JACUSA2 should be executed using the call-2 option (inputs: two sorted BAM files - WT DNA/RNA and actual sample RNA).
The JACUSA output files of all samples to be analyzed should be combined into one file. In the combined file, all SNVs should be sorted by their position in the genome.
Further, the file has to be saved as a tab delimited .csv file with following columns:
POSITION  #SNV position in the reference genome
DATASET   #name of sample
REF       #nucleotide in genome
ALT       #alternative nucleotide/s showing in sample/s
FILTER    #JACUSA filter
DNA       #total reads in sample 1 (WT DNA/RNA)
A_DNA     #reads with A in sample 1
C_DNA     #reads with C in sample 1
G_DNA     #reads with G in sample 1
T_DNA     #reads with T in sample 1
RNA       #total reads in sample 2 (RNA of actual sample)
A_RNA     #reads with A in sample 2
C_RNA     #reads with C in sample 2
G_RNA     #reads with G in sample 2
T_RNA     #reads with T in sample 2

### Script modification and execution

Set the working directory to the location where your CSV file is located.

Define the filename of the input CSV file by modifying the Filename variable in the script.

Modify line 109 ff. to customize the "common_df_all" dataframe generation and labeling of columns to your dataset.

You can change the output file name (FILENAME_JCSC.csv) by modifying the write.csv() function in the very end of the script.

Run the script in your R environment.

### Script Overview

Data Loading and Preprocessing: The script reads the input CSV file, performs data manipulations, and creates two data frames, y and z.

Aggregation: The script aggregates DNA and RNA reads by summing them up for different categories (e.g., A_DNA, C_RNA) based on the 'POS' column.

Merging Data Frames: The script merges the aggregated data frames to create Read_merge.

Data Splitting: It splits the y data frame based on the 'frame' column.

Data Merging: The script merges data frames with sample names.

Output Generation: The final processed data is written to a CSV file with the name FILENAME_JCSC.csv.

### Important Notes

If your reference for mapping/calling is a FASTA file containing multiple sub-FASTAs, make sure to keep them apart by using a combined POSITION column in your input file (e.g. "accession_position").
Ensure that the input CSV file (FILENAME.csv) is correctly formatted and contains the necessary columns.
Modify the script as needed to adapt it to your specific data and samplenames.
Make sure you have the necessary permissions to read from and write to the specified working directory.
That's it! You are now ready to use this R script.


That's it! You are now ready to use this Bash script to extract sequences from a FASTA file.
