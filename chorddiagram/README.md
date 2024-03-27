# Chord diagram

## Introduction
This is a script to visualize correlation analysis results through a chord diagram using the Circlize package on R.

## Data
The data used in this script is from NCBI’s Gene Expression Omnibus (GEO) with accession number [GSE116583] (https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE116583). It is the gene reads between two groups, Naïve (n=4) vs. Transplant (n=8).

## Additional info
The data used in this script did not have any negative correlations. Because of this, I changed one data (from positive to negative value) ONLY to visualize a negative correlation. This part of the script is not necessary and should be ignored. 

## References
  - [reference 1] (https://jokergoo.github.io/circlize_book/book/)
  - [reference 2] (https://r-charts.com/color-palette-generator/)
  - [reference 3] (https://www.ncbi.nlm.nih.gov/pmc/articles/PMC6096346/)
  - [reference 4] (https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE116583)
