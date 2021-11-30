# R functions to keep for trees
recode_bootstrap <- function(bootstrap_variable) {
    
    recoded <-
        case_when(
            bootstrap_variable == "Root" ~ "Root",
            bootstrap_variable == "" ~ NA_character_,
            suppressWarnings(as.numeric(bootstrap_variable)) >= 95 ~ ">= 95",
            TRUE ~ "< 95"
        )
    
    return(recoded)
}