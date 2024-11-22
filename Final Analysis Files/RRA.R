# Load required libraries
library(GEOquery)
library(limma)
library(dplyr)

# Step 1: Load data from GEO (example: GSE14763)
gset <- getGEO("GSE14763", GSEMatrix = TRUE, AnnotGPL = TRUE)
if (length(gset) > 1) {
  idx <- grep("GPL2896", attr(gset, "names"))
} else {
  idx <- 1
}
gset <- gset[[idx]]

# Step 2: Extract expression data and make column names valid
exprs_data <- exprs(gset)
fvarLabels(gset) <- make.names(fvarLabels(gset))  # Clean up feature names

# Step 3: Define the group membership (adjust based on your data)
gsms <- "000002222233333111"  # Example sample groupings (adjust this as needed)
sml <- strsplit(gsms, split = "")[[1]]
gs <- factor(sml)
groups <- c("acute", "control", "latent", "chronic")
levels(gs) <- groups
gset$group <- gs

# Step 4: Create a design matrix for the groups
design <- model.matrix(~group + 0, gset)
colnames(design) <- groups

# Step 5: Fit the linear model and compute statistics
fit <- lmFit(gset, design)

# Step 6: Set up contrasts and fit them
cts <- c("acute-control", "control-latent", "control-chronic")  # Example contrasts
cont.matrix <- makeContrasts(contrasts = cts, levels = design)
fit2 <- contrasts.fit(fit, cont.matrix)
fit2 <- eBayes(fit2)

# Step 7: Get the top table of differentially expressed genes
tT <- topTable(fit2, adjust = "fdr", sort.by = "B", number = 250)
# Check the structure of the tT data frame
str(tT)

# Calculate logFC between two conditions (adjust column names accordingly)
tT$logFC <- log2(tT$acute.control / tT$AveExpr)

# Handle missing values (remove NA rows, if any)
tT <- tT[!is.na(tT$logFC), ]

# Rank by absolute logFC
tT$rank_by_logFC <- rank(-abs(tT$logFC))

# View the first few rows to ensure calculation is correct
head(tT)

# Step 8: Rank genes by fold change (this can be considered as the rank-based analysis)
tT$rank_by_logFC <- rank(-abs(tT$logFC))  # Rank by absolute logFC

# Step 9: Visualize the ranked data (e.g., volcano plot)
volcanoplot(fit2, coef = 1, main = "Volcano Plot: Acute vs Control", pch = 20)

# Optional: Save results to a file
write.table(tT, file = "differential_expression_results.txt", sep = "\t", row.names = FALSE)

# Step 10: Perform additional analysis or visualizations as needed
