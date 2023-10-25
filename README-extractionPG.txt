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

That's it! You are now ready to use this Bash script to extract sequences from a FASTA file.
