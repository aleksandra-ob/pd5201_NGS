#!/bin/bash

for sample in SRR25629153 SRR25629154 

do 

bwa mem /mnt/c/Users/ASUS/bioinfo_NGS/genome_index/GCF_000005845.2_ASM584v2_genomic.fna \
${sample}_1_trimmed.fastq.gz ${sample}_2_trimmed.fastq.gz > ${sample}.sam

samtools view -bS ${sample}.sam > ${sample}.bam 

samtools sort -o ${sample}_sorted.bam ${sample}.bam

samtools index ${sample}_sorted.bam

done
