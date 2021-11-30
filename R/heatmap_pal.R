#' 
#'@param pairwise_dist
#'@param mid_value the cutoff value for SNP
#'@param sd_value the range of uncertainty - integer - uncertain zone
#'@param low_color the low color as certain for same cluster
#'@param mid_colors the vector 3 colors to be used in the middle range low, middle, high for the gradient
#'@param high_color the high color as excluded for same cluster
#' @example 
#' heatmap_pal(snp_dist, 
#' mid_value = 25, 
#' sd_value = 3, 
#' low_color = "blue", 
#' mid_colors = c("green", "yellow", "violet"), 
#' high_color = "red")

# inspiration https://stackoverflow.com/questions/13353213/gradient-of-n-colors-ranging-from-color-1-and-color-2

heatmap_pal <- function(pairwise_dist, mid_value, sd_value, low_color, mid_colors, high_color) {

  # need to ensure integers 
  
  # get the number of values to repeat
  nb_low_values <- mid_value - min(pairwise_dist) - sd_value 
  nb_mid_values <- 2*sd_value + 1 
  nb_high_values  <- max(pairwise_dist) - (mid_value + sd_value)
  
  # create the palette 
  low <- gplots::col2hex(c(low_color))
  mid_fun <- colorRampPalette(mid_colors)
  high <- gplots::col2hex(c(high_color))
  
  pal <- c(rep(low, nb_low_values), mid_fun(nb_mid_values), rep(high, nb_high_values))
  names(pal) <- as.character(seq(min(pairwise_dist), max(pairwise_dist), by = 1))
  return(pal)
}

# then we should be able to do breaks ...  how ? 
#https://stackoverflow.com/questions/15601609/how-do-you-create-vectors-with-specific-intervals-in-r
#https://stat.ethz.ch/pipermail/r-help/2003-July/035846.html

create_breaks <- function(pairwise_dist, mid_value, sd_value) {
  
  # getting the ranges of values (for croschecking)
  low_range <- c(min(pairwise_dist), mid_value - sd_value - 1)
  mid_range <- c(mid_value - sd_value, mid_value + sd_value)
  high_range <- c(mid_value + sd_value + 1 , max(pairwise_dist))
 
  # histogram cells are right-closed (left open) intervals of the form (a,b].
  c(low_range, mid_range[2], high_range [2]) 
  # will be something for the naming for the legend (look a the plot)
}

# making a guide for the legend
# https://aosmith.rbind.io/2020/07/09/ggplot2-override-aes/
# 
#   # name-guide pair   
#   
# color = guide_legend()
# 
# scale_color_manual(breaks = , labels = function(x) )

label_function <- function(breaks){
  a <- paste( "<=", as.character(breaks[2]), sep = "")
  b <- paste(as.character(breaks[2]+ 1), "-", as.character(breaks[3]), sep = "")
  c <- paste(">=", as.character(as.character(breaks[3])), sep = "")
  
  c(a, b, c)

} 
