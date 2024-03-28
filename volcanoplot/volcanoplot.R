library("readxl")
library("BiocManager")
library("EnhancedVolcano")

#get data
exceldata = read_excel("data_volcano.xlsx")

selected_data <- exceldata[, c(2,3,5)]

typeof(selected_data$log2FoldChange)
selected_data$log2FoldChange <- as.double(selected_data$log2FoldChange)  
selected_data$padj <- as.double(selected_data$padj) 

#log2FC calculation
log2FC = data.frame()
for (i in 1:nrow(selected_data)){
  if (selected_data$FoldChange[i] < 0)
  {
    x = -log(abs(selected_data$FoldChange[i]),2)
    log2FC <- rbind(log2FC, x)
  }
  else{
    log2FC <- rbind(log2FC, log(selected_data$FoldChange[i],2))
  }
}
log2FC <- log2FC[ , unlist(lapply(log2FC, is.numeric))] #remove values that are not numbers


#create data frame containing data needed for volcano plot
data = data.frame()
data[nrow(selected_data),]=NA  # ad a temporary new row of NA values
data[,'new_column'] = NA # adding new column, called for example 'new_column'

data$Name <- selected_data$Name
data$padj <- selected_data$padj
data$log2FoldChange <-selected_data$log2FoldChange
data <- data[,-1]


#Volcano plot
keyvals <- 
  ifelse(data$log2FoldChange < -0.5849 & data$padj < 0.05, 'royalblue',
  ifelse(data$log2FoldChange > 0.5849  & data$padj < 0.05, 'red2',
         'grey30'))

keyvals[is.na(keyvals)] <- 'grey30'
names(keyvals)[keyvals == 'red2'] <- 'upregulated'
names(keyvals)[keyvals == 'grey30'] <- 'not significant'
names(keyvals)[keyvals == 'royalblue'] <- 'downregulated'

EnhancedVolcano(data,
                x = 'log2FoldChange',
                y = 'padj',
                lab = data$Name,
                
                title = 'SLE vs. HC',
                pCutoff = 0.05,
                FCcutoff = 0.5849625007,
                cutoffLineType = 'twodash',
                cutoffLineWidth = 0.8,
                pointSize = 2.0,
                labSize = 4.0,
                #xlim = c(-5, 5),
                #ylim = c(0, 14),
                colCustom = keyvals,
                #drawConnectors = TRUE,
                widthConnectors = 0.5)

