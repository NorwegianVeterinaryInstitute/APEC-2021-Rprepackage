#' import distance and arrange it for statistics
#' provide basic statistics to choose the cutoff 
#' Remove duplicates to make the plots
#' example 
#' @param distance_long_object distance 
#' @param n_breaks to ajust the x axis breaks of density plots 
#' @param title1 tile for density plot
#' @param title2 title for cumulative density plot 

#' depends patchwork
distance_density_plots <- function(distance_long_object, n_breaks, 
                                   title1 = "Density - Pairwise distance", 
                                   title2 = "Cumulative density - Pairwise distance"){
    
    print("removing duplicated pairs and common ids to compute statistics")
    
    # remove duplicates to get statistics (old version - write a function for reuse)
    # distance.long <-  distance_long_object %>%
    #     filter(ID1 != ID2) %>%
    #     rowwise() %>%
    #     mutate(key = paste(sort(c(ID1,ID2)), collapse = "")) %>%
    #     distinct(key, .keep_all = T) %>%
    #     select(-key)
    
    # remove duplicates to get statistics - with clean distance long (to retest)
    distance.long <- clean_distance_long(distance_long_object)
    
    
    print("summary distances statistics: ")
    print(summary(distance.long$distance))
    
    density_plot <- ggplot(distance.long, aes(distance))  +
    geom_density() +
    labs(x = "Pairwise distance", title = title1) +
    scale_x_continuous(breaks = scales::breaks_extended(n = n_breaks))
    
    cumulative_density_plot <- ggplot(distance.long, aes(distance))  +
    ggplot2::stat_ecdf() +
    labs(x = "Pairwise distance",
         y = "cumulative density",
         title = title2) +
    scale_x_continuous(breaks = scales::breaks_extended(n = n_breaks))
    
    patchwork_plots <- density_plot / cumulative_density_plot
    
    return(patchwork_plots)
    }
    
    