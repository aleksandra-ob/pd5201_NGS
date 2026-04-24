# =========================
# Ex_18 – biomaRt + DESeq2
# =========================

# =========================
# Instalacja pakietów (jeśli brak)
# =========================
if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")

if (!requireNamespace("biomaRt", quietly = TRUE))
  BiocManager::install("biomaRt")

if (!requireNamespace("DESeq2", quietly = TRUE))
  BiocManager::install("DESeq2")

# =========================
# Wczytanie pakietów
# =========================
library(biomaRt)
library(DESeq2)

# =========================
# (WARUNEK WSTĘPNY)
# W środowisku muszą być obiekty z Ex_17:
# counts  (macierz zliczeń)
# coldata (ramka z kolumną 'condition': WT/MT)
# =========================

# szybka kontrola (opcjonalnie)
stopifnot(!is.null(counts), !is.null(coldata))
stopifnot(nrow(counts) > 0, ncol(counts) == 4)
stopifnot(!is.null(rownames(counts)))

# =========================
# biomaRt – połączenie z Ensembl (useMart + host)
# =========================

library(biomaRt)

# połączenie
mart <- useEnsembl(
  biomart = "genes",
  dataset = "hsapiens_gene_ensembl"
)


# Pobieranie adnotacji dla genów
gene_annotations <- getBM(attributes = c("ensembl_gene_id", "hgnc_symbol",
                                         "chromosome_name", "start_position", "end_position",
                                         "gene_biotype", "description"),
                          filters = "ensembl_gene_id",
                          values = rownames(counts),
                          mart = mart)

# podgląd adnotacji
head(gene_annotations)

# =========================
# DESeq2 – analiza różnicowa
# =========================

# utworzenie obiektu DESeq2
dds <- DESeqDataSetFromMatrix(
  countData = counts,
  colData = coldata,
  design = ~ condition
)

# wykonanie analizy
dds2 <- DESeq(dds)

# pobranie wyników
deseq_results <- results(dds2)

# wyświetlenie wyników
head(deseq_results)

