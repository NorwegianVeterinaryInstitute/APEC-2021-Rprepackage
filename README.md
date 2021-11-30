# APEC-2021-Rprepackage
Prepackage for APEC-2021 analyses

## Documentation
### Tree visualization
packages ggtree

function: prepare_metadata 
function: join_metadata_assembly_names

function import: treeio::read.iqtree read.iqtree

function prepare_visualisation_tree
function standard_treeplot_eve1
function save_eve
function import: ggtree::get_taxa_name
function root_tree_data
function import is.rooted - treio or ape
function import ggplot2::xlim
function subset_tree
... start here
function import ape::getMRCA
function import ape::root

Note that rooting the tree (either midpoint or rooting according to an outgroup has to be done before linking the tree and metadata)


### Distances and statistics
function import distance
function distance_density_plots (make also the stats, correcting for duplicates)
function  distance_tree_heatmap gradient 3 colors (ok if not too many data)
function distance_tree_heatmap2 (binned version < value > value and gradient in middle )
reorder_distance_matrix.R to be able to follow ordering from the plot
(.packages())
