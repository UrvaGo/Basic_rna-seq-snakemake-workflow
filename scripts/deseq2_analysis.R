library(DESeq2)

counts <- read.delim(snakemake@input[['counts']], comment.char="#", row.names=1)
counts <- counts[,6:ncol(counts)]
colnames(counts) <- gsub(".bam", "", colnames(counts))

metadata <- read.csv(snakemake@input[['metadata']], sep="\t", row.names=1)

dds <- DESeqDataSetFromMatrix(countData=counts, colData=metadata, design=~condition)
dds <- DESeq(dds)
res <- results(dds)

write.csv(as.data.frame(res), file=snakemake@output[[1]])
