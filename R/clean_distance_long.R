#' Deduplicate the distances (so that same ID not conted twice and that 
#' ID1 - ID2 or ID2 - ID1 not counted twice) - due to format output systemetric,  
#' 
#' @param distance_long_object distance format ID1, ID2, distance 
#' @returns  distance_long_object - no duplicates - cleaned fasta and ref names

clean_distance_long <- function(distance_long_object){
  
  distance_long_object %>%
    mutate(ID1 = str_remove_all(ID1,"(.fasta.ref)|(.fasta)")) %>%
    mutate(ID2 = str_remove_all(ID2,"(.fasta.ref)|(.fasta)")) %>%  
    filter(ID1 != ID2) %>%
    rowwise() %>%
    mutate(key = paste(sort(c(ID1,ID2)), collapse = "")) %>%
    distinct(key, .keep_all = T) %>%
    select(-key)

}


