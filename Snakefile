import pandas as pd

configfile: "config/config.yaml"

samples = pd.read_csv(config["samples"], sep="\t")["sample"].tolist()

rule all:
    input:
        expand("results/fastqc/{sample}_fastqc.html", sample=samples),
        expand("results/trimmed/{sample}_R1_trimmed.fastq.gz", sample=samples),
        expand("results/aligned/{sample}.bam", sample=samples),
        "results/counts/gene_counts.txt",
        "results/deseq2/deseq2_results.csv"

rule fastqc:
    input:
        "data/{sample}_R1.fastq.gz"
    output:
        "results/fastqc/{sample}_fastqc.html"
    shell:
        "fastqc {input} -o results/fastqc/"

rule trim:
    input:
        "data/{sample}_R1.fastq.gz"
    output:
        "results/trimmed/{sample}_R1_trimmed.fastq.gz"
    shell:
        "trimmomatic SE -threads {config[threads]} {input} {output} SLIDINGWINDOW:4:20 MINLEN:36"

rule align:
    input:
        "results/trimmed/{sample}_R1_trimmed.fastq.gz"
    output:
        temp("results/aligned/{sample}.sam")
    shell:
        "hisat2 -p {config[threads]} -x {config[genome_index]} -U {input} -S {output}"

rule sam_to_bam:
    input:
        "results/aligned/{sample}.sam"
    output:
        "results/aligned/{sample}.bam"
    shell:
        "samtools sort -@ {config[threads]} -o {output} {input}"

rule count:
    input:
        bam=expand("results/aligned/{sample}.bam", sample=samples),
        gtf=config["gtf"]
    output:
        "results/counts/gene_counts.txt"
    shell:
        "featureCounts -T {config[threads]} -a {input.gtf} -o {output} {input.bam}"

rule deseq2:
    input:
        counts="results/counts/gene_counts.txt",
        metadata="samples.tsv"
    output:
        "results/deseq2/deseq2_results.csv"
    script:
        "scripts/deseq2_analysis.R"
