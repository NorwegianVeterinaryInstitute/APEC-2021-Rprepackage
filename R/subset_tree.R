#' subset a tree so we can look more into detail at some specific clades
#' Works for both rooted and unrooted trees 
#' @return supseted tree
#' @param tree_data_obj tree data object - after import - no transformation
#' @param  clade_tips vector giving tip.labels from which to find MRCA node - keeping this clade
#' @example clade_tips <- c("ESC_LB0632AA_AS.result.fasta", "ESC_QA3841AA_AS.scaffold.fasta")
subset_tree <- function(tree_data_obj, clade_tips) {
    
    phylo_tree <- as.phylo(tree_data_obj)
    mrca_node <- ape::getMRCA(phylo_tree, clade_tips)
    ape::extract.clade(phylo_tree, mrca_node)
}
