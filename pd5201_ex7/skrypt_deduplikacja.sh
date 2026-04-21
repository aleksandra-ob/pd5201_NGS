#!/bin/bash

mkdir -p deduplicated
mkdir -p deduplicated_final

for sample in SRR25629153 SRR25629154 SRR25629155
do
    samtools fixmate -m ${sample}.bam deduplicated/${sample}_fixmate.bam #naprawy sparowanych końców odczytów nieposortowanych

    samtools sort -o deduplicated/${sample}_fixmate_sorted.bam deduplicated/${sample}_fixmate.bam #sortowanie

    samtools index deduplicated/${sample}_fixmate_sorted.bam #indeksowanie

    samtools markdup -r deduplicated/${sample}_fixmate_sorted.bam deduplicated_final/${sample}_dedup.bam #usówanie duplikatów
done
