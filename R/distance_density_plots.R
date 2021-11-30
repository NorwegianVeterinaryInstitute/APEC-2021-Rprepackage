#' import distance and arrange it for statistics
#' provide basic statistics to choose the cutoff 
#' Remove duplicates to make the plots
#' example 
#' @param distance_long_object distance 
#' @param n_breaks to ajust the x axis breaks of density plots 

#' depends patchwork
distance_density_plots <- function(distance_long_object, n_breaks){
    
    print("removing duplicated pairs and common ids to compute statistics")
    
    # remove duplicates to get statistics
    distance.long <-  distance_long_object %>%
        filter(ID1 != ID2) %>%
        rowwise() %>%
        mutate(key = paste(sort(c(ID1,ID2)), collapse = "")) %>%
        distinct(key, .keep_all = T) %>%
        select(-key)
    
    print("summary distances statistics: ")
    print(summary(distance.long$distance))
    
    density_plot <- ggplot(distance.long, aes(distance))  +
    geom_density() +
    labs(x = "Pairwise distance") +
    scale_x_continuous(breaks = scales::breaks_extended(n = n_breaks))
    
    cumulative_density_plot <- ggplot(distance.long, aes(distance))  +
    ggplot2::stat_ecdf() +
    labs(x = "Pairwise distance",
         y = "cumulative density") +
    scale_x_continuous(breaks = scales::breaks_extended(n = n_breaks))
    
    patchwork_plots <- density_plot / cumulative_density_plot
    
    return(patchwork_plots)
    }
    
    