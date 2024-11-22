# Step 1: Load the GEO dataset (GSE14763)
library(GEOquery)
library(limma)
library(ggplot2)

gset <- getGEO("GSE14763", GSEMatrix = TRUE, AnnotGPL = TRUE)

# Step 2: Choose the correct platform
if (length(gset) > 1) {
  idx <- grep("GPL2896", attr(gset, "names"))
} else {
  idx <- 1
}
gset <- gset[[idx]]
pData(gset)
# Step 3: Extract expression data
expr_data <- exprs(gset)

# Step 4: Log2 transformation (if necessary)
expr_data_log <- log2(expr_data + 1)  # Add 1 to avoid log(0)

# Step 5: Remove genes with zero variance (features with constant expression across samples)
non_zero_var_genes <- apply(expr_data_log, 1, var) > 0  # Find genes (rows) with non-zero variance
expr_data_log_filtered <- expr_data_log[non_zero_var_genes, ]  # Keep only genes with non-zero variance
str(expr_data_log_filtered)  # Ensure there are non-zero rows and columns
summary(expr_data_log_filtered)
# Step 7: Remove any rows or columns with NA values
expr_data_log_filtered_noNA <- expr_data_log_filtered[complete.cases(expr_data_log_filtered), ]  # Remove rows with NA
# Step 7: Check the structure of your filtered data to ensure no empty rows/columns remain
str(expr_data_log_filtered_noNA)  # Ensure there are non-zero rows and columns
summary(expr_data_log_filtered_noNA)  # Check summary statistics

# Step 7: Perform PCA
pca_result <- prcomp(t(expr_data_log_filtered_noNA), center = TRUE, scale. = TRUE)

# Step 8: Summary of PCA results
summary(pca_result)

# Step 9: Visualize the PCA (using the first two principal components)
pca_data <- data.frame(pca_result$x)  # Get PCA components
pca_data$source_name_ch1 <- factor(gset$source_name_ch1)  # Assuming 'group' column exists for sample labels

# Step 10: Plot PCA with ggplot2
ggplot(pca_data, aes(PC1, PC2, color = source_name_ch1)) +
  geom_point(size = 3) +
  labs(title = "PCA of GSE14763", x = "Principal Component 1", y = "Principal Component 2") +
  theme_minimal() +
  scale_color_manual(values = c("red", "blue", "green", "purple","yellow","cyan"))  # Adjust colors as needed

# Save the plot
ggsave("pca_plot.png")  # Saves it in the current working directory
