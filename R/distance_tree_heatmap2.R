#' plot a heatmap of pairwise distances eg. SNP distances with phylogeographic tree
#' 
#' 
#' 
#' 
#' @param distance.long distance object file previously imported
#' @pattern to clean the names before reexporting distance matrix ordered 

distance_tree_heatmap2 <- function(distance.long, 
                                  tree_data_obj, 
                                  pattern = "_pilon_spades.fasta|.ref",
                                  save_dir = here::here("results"),
                                  mid_value = 30, 
                                  sd_value = 5,
                                  low_color = "darkgreen",
                                  mid_colors =c("blue", "yellow", "red"),
                                  high_color= "grey25"){
    
    # getting part for tree plotting
    tree_phylo_plot <- 
        ggtree(tree_data_obj, 
               layout = "rectangular",
               ladderize = T,
               lwd = .2) +
        geom_tippoint(size = .2)
    
    rotated_tree <- tree_phylo_plot + scale_x_reverse() + coord_flip()
    
    # need to inverse the levels for the plotting    
    taxa_names <- rev(get_taxa_name(tree_phylo_plot))
    
    # Reading distances
    # translate colors for the palette 
    low <- gplots::col2hex(low_color)
    mid_fun <- colorRampPalette(mid_colors, space = "Lab")
    high <- gplots::col2hex(high_color)
    
    # need to be reodered
    ordered_distance_df <- 
        distance.long %>% mutate_at(vars(ID1, ID2),factor, levels = taxa_names) %>%
        mutate(bined_snp = case_when(
            distance < {{ mid_value }} - {{ sd_value }} ~ glue('< { mid_value - sd_value}' ),
            distance > {{ mid_value }} + {{ sd_value }} ~ glue('> { mid_value + sd_value}' ),
            TRUE ~ as.character(distance)
        )) %>%
        mutate_at(.vars = "bined_snp", factor) 
        
    #        arrange(distance) %>%
        
    bined_levels <- levels(ordered_distance_df$bined_snp)
    # need to control behavior
    print("printed levels must be > xx , > xx, and then the values ordered increasing\n")
    print(bined_levels)
    
    nb_middle_values <- length(bined_levels) - 2
    mid_fun <- colorRampPalette(mid_colors)
    pal <- c(low, mid_fun(nb_middle_values), high)
    char_levels <- as.character(bined_levels)
    names(pal) <- c(char_levels[1],
                    char_levels[3:length(char_levels)],
                    char_levels[2])
    # check order 
    print(names(pal))
    
    heatmap_plot <- ggplot(ordered_distance_df) +
        geom_tile(aes(x = ID1, y = ID2, fill = bined_snp), color = "white", na.rm = T) +
        scale_fill_manual(values = pal) +
        theme(axis.title = element_blank(), 
              axis.ticks = element_blank(), 
              axis.text = element_blank())
    
    combined_plot <- 
        heatmap_plot %>%
        aplot::insert_left(tree_phylo_plot, width = 0.3) %>%
        aplot::insert_top(rotated_tree, height = 0.3)
    combined_plot
}
