Need to be modified 
- not to have to recode boostrap and not to have to use palette
- in conjuectuib with standard_treeplot_eve2

#' prepare_visualisation_tree - tree dataobject (but do not keep associated metadata)
#' Recodes bootstrap
#' Fixes the label for the reference as ref (its duplicate anyway)
#' associate with metadata - do not need to be linked after
#' NB: IF the tree must be rooted, this must be done before hand and maybechange
#' the recoding for boostrap
#' Return tree dataobject 
#' Works for both rooted and unrooted trees 
#' To work without recoding the boostrap with 

prepare_visualisation_tree2 <- function(tree_data_obj, metadata_df, pattern = ".fasta|.ref") {
    
    # extracting phylo for rooting
    phylo_tree <- as.phylo(tree_data_obj)
    
    # droping the ref if included as double 
    ref_label <-  str_subset(phylo_tree$tip.label, ".ref")
    # the ref is added at the end - use to test if isolate in double
    ref_isolate <- str_remove(ref_label, ".ref")
    nb_detected <- sum(str_detect(phylo_tree$tip.label, ref_isolate))
    if (nb_detected > 1) {
        phylo_tree <- treeio::drop.tip(phylo_tree, ref_label)
    }
    
    #transforming to tibble 
    df_tree_dat <- phylo_tree %>% 
        as_tibble() 
    # select nodes with boostrap values and recode
    # df_recoded_bootstrap <- df_tree_dat %>% 
    #     filter(! stringi::stri_isempty(label)) %>%
    #     filter(! stringr::str_ends(label, pattern = pattern)) %>%
    #     mutate(bootstrap = recode_bootstrap(label)) 
    # joining tree data - still at tibble 
    # df_tree_dat <- df_tree_dat %>% 
    #     full_join(df_recoded_bootstrap) 

    tree_dat <- df_tree_dat %>%
        dplyr::left_join(metadata_df, by = c("label" = "file")) %>%
        dplyr::mutate(ID = ifelse(!is.na(ID), ID, "ref")) %>%
        tidytree::as.treedata()
    
    # the ref need to be dropped from the tree as it is in double
    
    tree_ok <- treeio::drop.tip(tree_dat, "2021-22-522-103.ref")
        # That need to be corrected
    drop_tip <- tree$tip.label[stringr::str_detect(tree$tip.label, ".fasta.ref")]
            

    # return 
    return(tree_dat)
}
    