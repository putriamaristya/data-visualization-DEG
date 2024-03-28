# Heatmap

## Introduction
This is a script to visualize gene expression data from several samples to have an overall view on the differences of over- or under-expressed genes between two (or more) groups.

## Requirements
  - R version 4.3.2 (2023-10-31 ucrt)
  - BiocManager_1.30.22
  - ggplot2_3.5.0
  - ComplexHeatmap_2.18.0
  - org.Hs.eg.db_3.18.0


## Data
The data used in this script is from NCBI’s Gene Expression Omnibus (GEO) with accession number [GSE116583](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE116583). It is the gene reads between two groups, Naïve (n=4) vs. Transplant (n=8). The data is in txt format. 

## References
[reference 1](https://bioconductor.org/packages/release/bioc/html/ComplexHeatmap.html)
[reference 2](https://github.com/jokergoo/ComplexHeatmap) 
