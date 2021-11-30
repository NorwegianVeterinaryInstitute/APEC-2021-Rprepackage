#' plot a heatmap of pairwise distances eg. SNP distances with phylogeographic tree
#' 
#' 
#' 
#' 
#' @param distance.long distance object file previously imported
#' @pattern to clean the names before reexporting distance matrix ordered 

distance_tree_heatmap <- function(distance.long, 
                                  tree_data_obj, 
                                  distance_cutoff, 
                                  pattern = "_pilon_spades.fasta|.ref",
                                  save_dir = here::here("results")){
    
    tree_phylo_plot <- 
        ggtree(tree_data_obj, 
               layout = "rectangular",
               ladderize = T,
               lwd = .2) +
        geom_tippoint(size = .2)
    
    rotated_tree <- tree_phylo_plot + scale_x_reverse() + coord_flip()
    
    # need to inverse the levels for the plotting    
    taxa_names <- rev(get_taxa_name(tree_phylo_plot))
    
    ordered_distance_df <- 
        distance.long %>%
        mutate_at(vars(ID1, ID2),factor, levels = taxa_names)
    
    
    heatmap_plot <- ggplot(ordered_distance_df) +
        geom_tile(aes(x = ID1, y = ID2, fill = distance), color = "white", na.rm = T) +
        #scale_fill_gradient2(low = "red", mid = "white", high = "blue",
        #                      midpoint = distance_cutoff, breaks = 10) +
        metR::scale_fill_divergent(
            low = rev(scales::muted("blue")),
            mid = "white" ,
            high = rev(scales::muted("red")),
            midpoint = distance_cutoff,
            breaks = scales::breaks_extended(10),
            space = "Lab",
            na.value = "transparent",
            guide = "colourbar") +
        theme(axis.title = element_blank(), 
              axis.ticks = element_blank(), 
              axis.text = element_blank())
    heatmap_plot
    
    combined_plot <- 
        heatmap_plot %>%
        aplot::insert_left(tree_phylo_plot, width = 0.3) %>%
        aplot::insert_top(rotated_tree, height = 0.3)
    combined_plot
}
