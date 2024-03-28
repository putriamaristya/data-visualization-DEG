# Volcano Plot

## Introduction
This is a script to visualize differentially expressed genes (DEGs) from differential expression analysis of RNA sequencing data.

## Requirements
  - R version 4.3.2 (2023-10-31 ucrt)
  - readxl_1.4.3
  - BiocManager_1.30.22
  - EnhancedVolcano_1.20.0


## Data
The data used in this script is a publicly available dataset from [here](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC6691930/#SP14). It is the DEGs list in Systemic Lupus Erythematosus (SLE) vs Healthy Controls (HCs) saven in excel. There is a total of 6730 DEGs in this dataset. I renamed the excel file to "data_volcano' for convenience. 

## References
[reference](https://bioconductor.org/packages/devel/bioc/vignettes/EnhancedVolcano/inst/doc/EnhancedVolcano.html)
