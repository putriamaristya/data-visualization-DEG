library("BiocManager")
library("ggplot2")
library("ComplexHeatmap")
library("org.Hs.eg.db")

#get normcount reads
NormCounts = read.delim("GSE198963_cd4_Hs_normalized_cpm.txt")

#ensembl -> gene name
NormCounts$GeneName <- mapIds(org.Hs.eg.db, keys = rownames(NormCounts), keytype = "ENSEMBL", column = "SYMBOL")

#delete column that are not numbers (GeneName)
NormCounts_new <- NormCounts[ , unlist(lapply(NormCounts, is.numeric))]

#get z score
NormCounts_new.z <- t(apply(NormCounts_new, 1, scale))


#rename row and columns of z-score table
rownames(NormCounts_new.z) <- NormCounts$GeneName
colnames(NormCounts_new.z) <- colnames(NormCounts_new)

#omit rows with NaN value
NormCounts_new.z <- na.omit(NormCounts_new.z)

#Select rows 1-300
NormCounts_new.z <- NormCounts_new.z[1:30,]


#generate heatmap
Heatmap(NormCounts_new.z, cluster_rows = T, cluster_columns = T, column_labels = colnames(NormCounts_new.z), 
        name = "Z-score", show_row_names = TRUE, show_column_names = TRUE)

