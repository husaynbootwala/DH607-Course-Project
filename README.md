# DH607-Course-Project
Unveiling Key Regulatory Genes and Pathways in Epilepsy Progression: A Bioinformatics Approach

Project Overview:
Epilepsy is a neurological disorder characterized by recurrent, unprovoked seizures. These seizures result from abnormal electrical activity in the brain, which disrupts normal communication between neurons. The condition affects about 50 million people worldwide, making it one of the most common neurological disorders. Seizures in epilepsy can vary widely in terms of symptoms, ranging from brief lapses in awareness or consciousness to violent convulsions. The type of seizure depends on which part of the brain is affected. 
Our primary aim would be to investigate the molecular mechanisms of epilepsy through bioinformatics analysis of transcriptomic data from both animal models and human patients. The central focus is identifying key regulatory genes that drive epileptogenesis. Is there a way to correlate epilepsy with other similar chronic diseases and can we detect epilepsy early?
By identifying gene and transcriptomic shifts, this project will contribute to a deeper understanding of Epilepsy physiology, potentially highlighting new therapeutic targets.

Research Question and Objectives:
The research question of this project is: "Which genes and pathways are consistently dysregulated across different stages of epilepsy (acute, latent and chronic), and how do these contribute to the progression of the disease?"
Objectives:
To identify genes and pathways with significant expression changes that correlate with TLE stages
To identify differentially expressed genes (DEGs) in the acute, latent, and chronic stages of TLE by integrating transcriptomic data from rodent models and human patients. This will involve the use of bioinformatics tools to compare gene expression profiles across various stages of epileptogenesis.
To perform functional annotation and protein-protein interaction (PPI) analysis on the identified DEGs to uncover key biological processes and signaling pathways that drive TLE progression. 
To validate the role of the identified hub genes and pathways in human TLE by analyzing RNA-sequencing datasets from patients, complemented by quantitative reverse transcription PCR (qRT-PCR) in animal models. This will help confirm the relevance of these findings to human epilepsy.


Methodology and Approach 
The project will employ the following methods:
Data Acquisition: Publicly available microarray and RNA-sequencing datasets will be obtained from the Gene Expression Omnibus (GEO) database. These datasets will include transcriptomic profiles from rodent TLE models induced by pilocarpine or kainic acid, as well as human samples from patients with TLE. The use of both rodent and human datasets ensures that the findings are robust and relevant across species, which is essential for translating preclinical discoveries into clinical applications.
Differential Gene Expression Analysis: To identify differentially expressed genes (DEGs) between control and epileptic samples across the acute, latent, and chronic stages of TLE, the "limma" package in R software will be employed. DEGs will be selected based on stringent criteria, with an adjusted p-value < 0.05 and a log2 fold change > 1. This approach ensures that only statistically significant and biologically meaningful gene expression changes are included in the analysis.
Robust Rank Aggregation (RRA): Since individual experiments can contain noise and variability, RRA will be applied to integrate DEGs across multiple datasets. This technique ranks genes by their consistency across different datasets, generating a robust list of consistently dysregulated genes. By minimizing experimental biases, RRA will ensure that the findings are reliable.
Functional Enrichment and PPI Analysis: Identified DEGs will undergo pathway and process enrichment analysis using the Metascape platform to understand the biological processes involved in TLE. Additionally, protein-protein interaction (PPI) networks will be visualized using Cytoscape to identify hub genes, which play key roles in the disease process.
Validation: To confirm the relevance of the findings, qRT-PCR will be performed in a pilocarpine-induced status epilepticus rat model. Key genes such as Tlr2, Stat3, and Lgals3 will be validated, as they are known to be correlated with seizure frequency. 


Expected Outcomes and Significance 
The expected outcomes include the identification of key genes and pathways involved in the progression of Epilepsy. The results will provide insights into the role of inflammation, microglial activation, and synaptic remodeling in epileptogenesis. This study will highlight potential therapeutic targets, such as Tlr2 and Stat3, which could be modulated to prevent epilepsy onset or reduce seizure frequency. These findings will enhance the understanding of TLE at the molecular level, offering new insights into how neural circuits are disrupted during seizures. The project's potential to uncover new biomarkers motivates, as it could lead to better diagnostics and therapies for Epileptic patients at a broader level.

References
Pfisterer, U., Petukhov, V., Demharter, S., Meichsner, J., Thompson, J. J., Batiuk, M. Y., Asenjo-Martinez, A., Vasistha, N. A., Thakur, A., Mikkelsen, J., Adorjan, I., Pinborg, L. H., Pers, T. H., von Engelhardt, J., Kharchenko, P. V., & Khodosevich, K. (2020). Identification of epilepsy-associated neuronal subtypes and gene expression underlying epileptogenesis. Nature Communications, 11, 5038. https://doi.org/10.1038/s41467-020-18752-7
Chen, Q. L., Xia, L., Zhong, S. P., Wang, Q., Ding, J., & Wang, X. (2020). Bioinformatic analysis identifies key transcriptome signatures in temporal lobe epilepsy. CNS Neuroscience & Therapeutics, 26(12), 1266–1277. https://doi.org/10.1111/cns.13470

