#' prepare_visualisation_tree
#' Recodes bootstrap
#' Fixes the label for the reference as ref (its duplicate anyway)
#' associate with metadata - do not need to be linked after
#' NB: IF the tree must be rooted, this must be done before hand and maybechange
#' the recoding for boostrap
#' Return tree dataobject 
#' 
#' 
#' 
#' 
#' 
prepare_visualisation_tree <- function(tree_data_obj, metadata_df, pattern = ".fasta|.ref") {
    
    
    if (treeio::is.rooted(tree_data_obj)){
        # stop this function is not ready
        stop("This part of the function is still not working correctly")
        # Message error 
        #transforming to tible 
        df_tree_dat <- tree_data_obj %>% 
            as_tibble() 
        # select nodes with boostrap values and recode
        df_recoded_bootstrap <- df_tree_dat %>% 
            filter(! stringi::stri_isempty(label)) %>%
            filter(! stringr::str_ends(label, pattern = pattern)) %>%
            mutate(bootstrap = recode_bootstrap(label)) 
        # joining tree data - still at tible 
        df_tree_dat <- df_tree_dat %>% 
            full_join(df_recoded_bootstrap) 

    }
    else{
        # That could be actually done as above - alteady tree_data object
        tree_dat <- tree_data_obj
        tree_dat@data$bootstrap <- recode_bootstrap(tree_data_obj@data$UFboot)
        # Transforming to tibble
        df_tree_dat <- tree_dat %>% 
            as_tibble()
    }
    
    tree_dat <- df_tree_dat %>%
        dplyr::left_join(metadata_df, by = c("label" = "file")) %>%
        dplyr::mutate(ID = ifelse(!is.na(ID), ID, "ref")) %>%
        tidytree::as.treedata()
    
    # the ref need to be dropped from the tree as it is in double         
            

    # return 
    return(tree_dat)
}
    