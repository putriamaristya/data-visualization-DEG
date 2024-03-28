library("dplyr")
library("readxl")
library("Hmisc")
library("circlize")

#get data
dat <- read.delim("GSE116583.txt")

dat <- dat %>%
  select(-Symbol)


#pearson correlation
result <- (rcorr(as.matrix(dat), type = c("pearson")))


#prepare data
result_new <- result$r[-c(1:4), -c(5:12)]

df = data.frame(from = rep(rownames(result_new), times = ncol(result_new)),
                to = rep(colnames(result_new), each = nrow(result_new)),
                value = as.vector(result_new),
                stringsAsFactors = FALSE)


#circular plot
circos.clear()
par(cex = 1) #label size


# 1 Chord diagram - simple and default
circos.clear()
chordDiagram(df)


# 2 Chord diagram - corrected lables and title
circos.clear()
chordDiagram(df, 
             annotationTrack = "grid",
             preAllocateTracks = list(track.height = max(strwidth(unlist(dimnames(df))))))
circos.track(track.index = 1, panel.fun = function(x, y) {
  circos.text(CELL_META$xcenter, CELL_META$ylim[1], CELL_META$sector.index, 
              facing = "clockwise", niceFacing = TRUE, adj = c(0, 0.5))
}, bg.border = NA)

title(main = "Naive vs. Transplant")


# 3 Chord diagram - visualize correlation strength based on color opacity
circos.clear()
col_fun = colorRamp2(range(0:1), c("#FFEEEE", "#FF0000"), transparency = 0.5)

chordDiagram(df, 
             col = col_fun,
             annotationTrack = "grid",
             preAllocateTracks = list(track.height = max(strwidth(unlist(dimnames(df))))))
circos.track(track.index = 1, panel.fun = function(x, y) {
  circos.text(CELL_META$xcenter, CELL_META$ylim[1], CELL_META$sector.index, 
              facing = "clockwise", niceFacing = TRUE, adj = c(0, 0.5))
}, bg.border = NA)

title(main = "Naive vs. Transplant")


# 4 Chord diagram - positive and negative correlations
circos.clear()

#changing one value only to show negative correlation (data does not contain negative correlation) -- ignore
result_new[result_new == "0.968874116352948"] <- "-0.968874116352948"

df = data.frame(from = rep(rownames(result_new), times = ncol(result_new)),
                to = rep(colnames(result_new), each = nrow(result_new)),
                value = as.vector(result_new),
                stringsAsFactors = FALSE)

#color
col_mat <- ifelse(df$value > 0, 'red2',
                  ifelse(df$value < 0, 'blue', 
                         'grey30'))

#chord diagram
chordDiagram(df, 
             col = col_mat,
             annotationTrack = "grid",
             preAllocateTracks = list(track.height = max(strwidth(unlist(dimnames(df))))))
circos.track(track.index = 1, panel.fun = function(x, y) {
  circos.text(CELL_META$xcenter, CELL_META$ylim[1], CELL_META$sector.index, 
              facing = "clockwise", niceFacing = TRUE, adj = c(0, 0.5))
}, bg.border = NA)


# 5 Chord diagram - two chord diagrams (positive and negative correlations) + correlation strength
circos.clear()
set.seed(1)

#color
col_fun_pos = colorRamp2(range(0:1), c("#FFEEEE", "#FF0000"), transparency = 0.5)
col_fun_neg = colorRamp2(range(-1:0), c("#f0feff", "#0017d1"), transparency = 0.5)

#chord diagram
par(mfrow = c(1, 2))

#pos cor
chordDiagram(df, col = col_fun_pos, grid.col = 1:12, link.visible = df$value > 0,annotationTrack = "grid", preAllocateTracks = list(track.height = max(strwidth(unlist(dimnames(df))))))
circos.track(track.index = 1, panel.fun = function(x, y) {
  circos.text(CELL_META$xcenter, CELL_META$ylim[1], CELL_META$sector.index, 
              facing = "clockwise", niceFacing = TRUE, adj = c(0, 0.5))
}, bg.border = NA) # here set bg.border to NA is important
title("Positive links")

#neg cor
chordDiagram(df, col = col_fun_neg, grid.col = 1:12, link.visible = df$value < 0,annotationTrack = "grid", preAllocateTracks = list(track.height = max(strwidth(unlist(dimnames(df))))))
circos.track(track.index = 1, panel.fun = function(x, y) {
  circos.text(CELL_META$xcenter, CELL_META$ylim[1], CELL_META$sector.index, 
              facing = "clockwise", niceFacing = TRUE, adj = c(0, 0.5))
}, bg.border = NA) # here set bg.border to NA is important
title("Negative links")