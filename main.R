# Main - for sourcing the functions of the script
# setup 
library(pacman)
p_load(here, tidyverse, ggtree, ggnewscale, Cairo, treeio, patchwork, gplots, glue)

# preparing package - loading separaterly
functions_to_sources <- c("prepare_metadata.R", 
                          "join_metadata_assembly_names.R",
                          "recode_bootstrap.R",
                          "prepare_visualisation_tree.R",
                          "root_treedata.R",
                          "palettes.R",
                          "standard_treeplot_eve1.R",
                          "save_eve.R",
                          "subset_tree.R",
                          "import_distance.R",
                          "distance_density_plots.R",
                          "distance_tree_heatmap.R",
                          "distance_tree_heatmap2.R",
                          "reorder_distance_matrix.R", 
                          "extract_genome_coverage.R")

# sourcing all
for (i in seq_along(functions_to_sources)) {
    source(paste(path_package, "R", functions_to_sources[i] ,sep = "/"))
           }

