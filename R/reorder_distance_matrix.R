#' Function to reorder the distance matrix for easier reading
#' 
#' 
#' 
reorder_distance <- function(file_path, 
                             tree_data_obj, 
                             save_file=here::here("results", "ordered_SNP_matrix.csv")){
    
    distance_file <- readr::read_delim(file_path)
    names(distance_file)[1] <- "file"
    
    tree_phylo_plot <- 
        ggtree(tree_data_obj, 
               layout = "rectangular",
               ladderize = T,
               lwd = .2) 
    taxa_names <- rev(get_taxa_name(tree_phylo_plot))
    
    # reorder the distance datafile 
    ordered_distance_df <- 
        distance_file %>%
        select(all_of(c("file", taxa_names))) %>%
        mutate_at(vars(file), factor, levels = taxa_names) %>%
        arrange(file) %>%
        mutate_at(vars(file), as.character)
    
    # remove the pilon_spades.fasta
    
    write_excel_csv(ordered_distance_df,
                    paste0(save_file))
    
    return(ordered_distance_df)
}    

    