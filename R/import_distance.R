#' import distance and arrange it for statistics
#' provide basic statistics to choose the cutoff 
#' example 
#' @param pattern pattern to remove from file names

import_distance <- function(file_path){
    
    distance_file <- readr::read_delim(file_path)
    names(distance_file)[1] <- "file"
    
    distance.long <- reshape2::melt(distance_file, id = "file") 
    names(distance.long) <- c("ID1", "ID2", "distance")
    distance.long %>% 
        mutate_at(.vars = c("ID1", "ID2"),
                                as.character) 
    # ! Do not remove the duplicates, because used in the tree
    # ! Do not clean the names because we need the names to connect in the tree
    # Use after clean_distance_long.R if you need to have cleaned distances

}
