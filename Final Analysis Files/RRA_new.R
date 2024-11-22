# Install and load necessary libraries
if (!requireNamespace("RobustRankAggreg", quietly = TRUE)) {
  install.packages("RobustRankAggreg")
}
library(RobustRankAggreg)
library(GEOquery)

# Load the GEO dataset
gset <- getGEO("GSE49030", GSEMatrix = TRUE, AnnotGPL = TRUE)
if (length(gset) > 1) {
  idx <- grep("GPL2896", attr(gset, "names"))
} else {
  idx <- 1
}
gset <- gset[[idx]]

# Prepare the data
expr_data <- exprs(gset)
control_expr <- expr_data[, 1:9]  # Adjust according to your dataset
treatment_expr <- expr_data[, 10:18]  # Adjust accordingly

# Calculate log fold change
logFC <- apply(treatment_expr, 1, mean) - apply(control_expr, 1, mean)

# Rank by absolute log fold change
ranked_genes <- rank(-abs(logFC))
str(ranked_genes)
# Create a list of ranked vectors for RRA
ranked_lists <- list(ranked_genes)
str(ranked_lists)
rra_results <- aggregateRanks(gset, rmat = rankMatrix(ranked_lists), method = "RRA")
str(rra_results)
robust_DEGs <- rra_results[rra_results$Score < 0.05, ]
tail(robust_DEGs)
library(pheatmap)
str(robust_DEGs$Score)
pheatmap(as.matrix(robust_DEGs$Score), cluster_rows = TRUE, cluster_cols = FALSE,
         color = colorRampPalette(c("blue", "white", "red"))(50),
         main = "Heatmap of Robust DEGs")
# Save robust DEGs to a CSV file
write.csv(robust_DEGs, file = "robust_DEGs.csv", row.names = FALSE)

