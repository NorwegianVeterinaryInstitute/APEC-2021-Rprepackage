#' eve_ggsave fast with automatic parameters
#' 
#' 
save_eve <- function(plot, png_name ){
    ggsave(filename = here::here("results", png_name), 
    plot = plot,
    units = "cm", 
    dpi = 600, 
    width = 25, 
    height = 25, 
    type = "cairo")
}
