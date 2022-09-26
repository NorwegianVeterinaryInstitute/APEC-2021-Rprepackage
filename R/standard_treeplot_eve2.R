#' standard_treeplot_eve1 
#' Plots the treedata object with standard parameters 
#' Metadata that are used have been attached in 'prepare_visualisation_tree' function
#' 
#' 
#' @param  ... x = , y = position of the tree scale bar for adjustement
#' @param  bootstrap_limit The limit for interpretation bootstrap 
#' require ggnewscale
standard_treeplot_eve2 <- function (tree_data_obj, 
                                    tippoint_var,
                                    tiplab_var, 
                                    tiplegend_lab = "Source", 
                                    nodepoint_var, 
                                    legend_postion = c(0.95,0.3), 
                                    layout = "rectangular",
                                    ladderize = T,
                                    lwd = .2,
                                    size = 1,
                                    legend_position = "bottom",
                                    bootstrap_limit = 95, 
                                    ...) {
        ggtree(tree_data_obj, 
               layout = layout, 
               ladderize = ladderize, 
               lwd = lwd) +
                geom_tiplab(aes(label = {{ tiplab_var }} ),
                            size = (size*1.5)) +
                # the variable label correspond to the values of nodes: here Boostrap values
                geom_nodepoint(aes(color = as.numeric(label) < bootstrap_limit),
                   size = 1, na.rm = T, pch = 19) +
                # the expression phantom allow mathematical annotation for the text labels 
                scale_color_manual(values = setNames(c("red", "darkgreen"), c(T,F)),
                           labels = c(expression(phantom(x) < bootstrap_limit), expression(phantom(x) >=bootstrap_limit)),
                           na.translate = FALSE, name = "Bootstrap") + 
                ggnewscale::new_scale_color() +
                geom_tippoint(aes(color = factor({{ tippoint_var}})), 
                              size = 1) +
                labs(color = deparse(substitute(tippoint_var))) +
                geom_treescale(...) + 
                theme(legend.position = legend_position,
                      legend.title = element_text(size = 8),
                      legend.text = element_text(size = 6),
                      plot.title = element_text(hjust = 1))
        }





 