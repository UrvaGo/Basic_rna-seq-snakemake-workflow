# Basic Bulk RNA-seq Workflow (Snakemake-based)

This pipeline performs differential expression analysis for bulk RNA-seq data using a Snakemake workflow. It processes raw FASTQ files through trimming, alignment, gene quantification, and DESeq2-based analysis.

## Workflow Overview

The workflow includes the following steps:
1. **Quality Control**: FastQC
2. **Trimming**: Trimmomatic
3. **Alignment**: HISAT2
4. **Conversion & Sorting**: SAM to BAM via Samtools
5. **Quantification**: featureCounts
6. **Differential Expression**: DESeq2

## Installation

Make sure the following tools are installed (preferably via [conda](https://docs.conda.io/en/latest/)):

- [FastQC](https://www.bioinformatics.babraham.ac.uk/projects/fastqc/) – quality check
- [Trimmomatic](http://www.usadellab.org/cms/?page=trimmomatic) – adapter trimming
- [HISAT2](https://daehwankimlab.github.io/hisat2/) – RNA-seq alignment
- [Samtools](http://www.htslib.org/) – for working with SAM/BAM files
- [featureCounts](http://bioinf.wehi.edu.au/featureCounts/) – read summarization
- [R](https://www.r-project.org/) – statistical computing
- [DESeq2](https://bioconductor.org/packages/release/bioc/html/DESeq2.html) – differential expression analysis
- [Snakemake](https://snakemake.readthedocs.io/en/stable/) – workflow management system

You can create a ready-to-use conda environment via:
```bash
conda env create -f envs/rna_seq_env.yaml
conda activate rna_seq_env
📁 Directory Structure
arduino
Copy
Edit
rna_seq_pipeline/
├── config/
│   └── config.yaml
├── data/
│   └── sample1_R1.fastq.gz ...
├── envs/
│   └── rna_seq_env.yaml
├── results/
│   ├── fastqc/
│   ├── trimmed/
│   ├── aligned/
│   ├── counts/
│   └── deseq2/
├── scripts/
│   └── deseq2_analysis.R
├── samples.tsv
└── Snakefile

##Configuration
config/config.yaml:

samples: "samples.tsv"
genome_index: "reference/hisat2/genome"
gtf: "reference/genes.gtf"
threads: 8

##samples.tsv:

sample	condition
sample1	control
sample2	control
sample3	treated
sample4	treated

##Running the Workflow
Create conda environment:

conda env create -f envs/rna_seq_env.yaml
conda activate rna_seq_env

##Run the workflow:

snakemake --cores 8

##Clean up intermediate files:

snakemake clean

##Output

Quality reports (results/fastqc)

Trimmed reads (results/trimmed)

BAM alignment files (results/aligned)

Gene counts (results/counts/gene_counts.txt)

Differential expression results (results/deseq2/deseq2_results.csv)

##Citation
If you use this pipeline, please cite the tools used (FastQC, Trimmomatic, HISAT2, featureCounts, DESeq2, Snakemake).

##Contact
Developed by Urvashi Goswami
Postdoctoral Researcher, Whitney Lab, University of Florida
📧 goswamiurvashi12@gmail.com
🔗 GitHub: UrvaGo
