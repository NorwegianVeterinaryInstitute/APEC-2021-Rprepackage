#' rooting treedata object the correct way
#' needs to be done BEFORE recoding bootstrap osv 
#' extracts the phylo object and associated data
#' find the MRCA for the taxaon1 taxon1 
#' root at the MRCA node 
#' reassociate phylotree and data
#' @param outgroup a single or vector of 2 taxa c("taxa1.fasta, "taxa2.fasta") from tip$label
#' @param treedata_object a s4 tree object (see ggtree manual)
#' @return treedata object but UFBOOT is remorooted tree with bootstrap annotations to the correct values
#'  require: ggtree ape E  
#'  
#
root_treedata <- function(treedata_object, outgroup){
    # Rooting the tree
    unrooted <- ape::as.phylo(treedata_object)
    mrca_node <- ape::getMRCA(unrooted, outgroup)
    rooted <- ape::root(unrooted, node = mrca_node, resolve.root = T)
    # duplicating bootstrap for recoding
    rooted$bootstrap <- rooted$node.label
    rooted_tree_data <- treeio::as.treedata(rooted)
    # reassociating additional data must be done after 
    return(rooted_tree_data)
    }

