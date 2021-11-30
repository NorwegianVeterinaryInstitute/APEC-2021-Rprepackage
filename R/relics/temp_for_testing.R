# temp relics for testing
# rooting tree
tree@phylo$tip.label[stringr::str_starts(tree@phylo$tip.label, pattern = "ESC")]

mytible <- as_tibble(tree)
myphylo <- ape::as.phylo(mytible)
str(myphylo)
str(mytible)
View(mytible)
mynode <- ape::getMRCA(myphylo, c("ESC_LB0632AA_AS.result.fasta", "ESC_QA3841AA_AS.scaffold.fasta"))
myrooted <- ape::root(myphylo, node = mynode, 
                      resolve.root = T)
myrooted$boot <- myrooted$node.label 

rooted_tible <- myrooted %>% 
    as_tibble()
df_recoded_bootstrap <- rooted_tible %>% 
    filter(! stringi::stri_isempty(label)) %>%
    filter(! stringr::str_ends(label, ".fasta|.ref")) %>%
    mutate(newbootstrap = recode_bootstrap(label)) 

View(rooted_tible)
View(df_recoded_bootstrap)
temp <- rooted_tible %>% full_join(df_recoded_bootstrap) 

treeio::as.treedata(temp) %>% str(.)

### preparing tree 
temp_tibble_root <- rooted_tree %>% 
    as_tibble() 
# select nodes with boostrap values and recode
temp_df_recoded_bootstrap <- temp_tibble_root %>% 
    filter(! stringi::stri_isempty(label)) %>%
    filter(! stringr::str_ends(label, pattern = ".fasta")) %>%
    mutate(bootstrap = recode_bootstrap(label)) 
# joining tree data - still at tible 
temp_df_dat <- temp_tibble_root %>% 
    full_join(temp_df_recoded_bootstrap) 
View(temp_df_dat)
temp <- temp_df_dat %>% dplyr::left_join(metadata, by = c("label" = "file")) %>%
    dplyr::mutate(ID = ifelse(!is.na(ID), ID, "ref")) %>%
    tidytree::as.treedata() 
str(temp)
