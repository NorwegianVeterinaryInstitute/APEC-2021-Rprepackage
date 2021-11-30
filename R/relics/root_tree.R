# functions for making trees better
root_tree <- function(treedata_object, outgroup) {
    #' root tree - while fixing the boostrap for fdisplay
    #' extracts the phylo object and annotate
    #' @param outgroup a single or vector of taxa ie "WTCHG_299178_248103_R1.fastq.gz"
    #' @return rooted tree with bootstrap annotations to the correct values
    
    out <- enquo(outgroup)
    # Function
    unrooted <- ape::as.phylo(treedata_object)
    rooted <- ape::root(unrooted, outgroup, resolve.root = T)
    return(rooted)
}