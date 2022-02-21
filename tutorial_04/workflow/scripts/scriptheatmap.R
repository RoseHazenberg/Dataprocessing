args = commandArgs(trailingOnly=TRUE)
data <- as.matrix(read.csv(args[1], header=FALSE, sep=",")[-1,-1])
rownames(data) <- read.csv(args[1], header=FALSE, sep=",")[-1,1]
colnames(data) <- read.csv(args[1], header=FALSE, sep=",")[1,-1]
jpeg(args[2])
heatmap(data, Colv = NA, Rowv = NA, scale="row",
        main="Heatmap of the gene expressions of a yeast")
dev.off()