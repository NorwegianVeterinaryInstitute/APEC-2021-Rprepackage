phylo_tree <- as.phylo(rooted_tree)

tree_dat <- phylo_tree %>% 
    as_tibble() 
# select nodes with boostrap values and recode
mypattern <- ".fasta|.ref"
recoded_bootstrap <- tree_dat %>% 
    filter(! stringi::stri_isempty(label)) %>%
    filter(! stringr::str_ends(label, pattern = mypattern)) %>%
    mutate(bootstrap = recode_bootstrap(label)) 
# joining tree data - still at tible 
#maybe_tree_dat <- 
tree_dat %>% 
    full_join(recoded_bootstrap) %>% View(.)
# Joining, by = c("parent", "node", "branch.length", "label")

# testing
test_prepare <- prepare_visualisation_tree(rooted_tree, metadata)
# modified version
test_prepare <- prepare_visualisation_tree(rooted_tree, metadata)
View(test_prepare)
standard_treeplot_eve1(test_prepare, 
                       tippoint_var = Source,
                       tiplab_var = header)

# testing if function now works both for rooted and unrooted tree 
test_prepare_unrooted <- prepare_visualisation_tree(tree, metadata)
standard_treeplot_eve1(test_prepare_unrooted, 
                       tippoint_var = Source,
                       tiplab_var = header)
# testing to drop the ref label
test_tree <- as.phylo(tree)
ref_label <-  str_subset(test_tree$tip.label, ".ref")
ref_isolate <- str_remove(ref_label, ".ref")
nb_detected <- sum(str_detect(test_tree$tip.label, ref_isolate))
if (nb_detected >1) {
    test_tree <- treeio::drop.tip(test_tree, ref_label)
}


# testing subsetting tree # must do from the rooted tree no metadata
test_tree <- as.phylo(rooted_tree)
clade_tips <-c("210521_M06578.2021-01-1648-3-l-1_S9_pilon_spades.fasta", 
               "210325_M06578.2021-01-1070-1-l-1_S38_pilon_spades.fasta")
mrca_node <- ape::getMRCA(phylo_tree, clade_tips)
subseted_tree <- ape::extract.clade(test_tree, mrca_node)
