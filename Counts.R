# 1. Wczytanie macierzy zliczeń
raw_counts <- read.table("pd5201_ex16.tabular",
                         sep = "\t",
                         header = TRUE,
                         row.names = 1,
                         stringsAsFactors = FALSE,
                         check.names = FALSE)

# 2. Modyfikacja nazw kolumn (usunięcie .bam, .fastq itd.)
colnames(raw_counts) <- gsub("\\.bam$|\\.fastq$|\\.fastq\\.gz$", "", colnames(raw_counts))

# 3. Określenie próbek WT i MT na podstawie nazw
WT <- grep("^WT", colnames(raw_counts))
MT <- grep("^MT", colnames(raw_counts))

# 4. Uporządkowanie danych – najpierw WT, potem MT
counts <- cbind(raw_counts[, WT], raw_counts[, MT])

# 5. Nadanie nazw kolumn zgodnie z wymaganiem
colnames(counts) <- c("WT_rep1", "WT_rep2", "MT_rep1", "MT_rep2")

# 6. Określenie warunków eksperymentalnych
condition <- factor(c(rep("WT", 2), rep("MT", 2)))

# 7. Utworzenie ramki danych coldata
coldata <- data.frame(row.names = colnames(counts),
                      condition = condition)

# 8. Usunięcie wersji Ensembl (np. ENSG000001.5 → ENSG000001)
ensembl_ids <- rownames(counts)
no_ensembl_ids <- gsub("\\..*$", "", ensembl_ids)
rownames(counts) <- no_ensembl_ids

# 9. Kontrola poprawności
head(counts)
coldata

