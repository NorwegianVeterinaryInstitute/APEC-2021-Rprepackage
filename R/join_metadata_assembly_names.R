#' Join metadata and fasta_file names that are extracted from a directory
#' Cleans names before joining
#' Removes isolates that were not used in current analysis because file not present
#'
#' Function 
#'
#' @param metadata_obj metadata object file 
#' @param assembly_dir directory containing all assembly files ex: .fasta
#' @param assembly_extension regex pattern for assemblies in assembly_dir
#' @param cleaning_pattern regex pattern for cleaning to join with metadata headers 
#' @return metadata 
#' @example 
#' join_metadata_assembly_names(metadata_obj = metadata, 
#' assembly_dir = "./data/2021-08-07_ST23_all/input",
#' pattern = ".fa|.fasta")
#' 
#' @author Eve Zeyl Fiskebeck, \email{evezeyl@@gmail.com}
#'
#' @export
#' @import tidyverse stringr
#'

join_metadata_assembly_names <- function(metadata_obj, 
                                         assembly_dir, 
                                         assembly_extension = ".fasta",
                                         clean_pattern = "_pilon_spades.fasta") {
    
    assembly_files <- list.files(path = assembly_dir, pattern = assembly_extension) 
    if (rlang::is_empty(assembly_files)) {
        stop("files not detected. Check assembly_dir, extension and pattern")
    }

    assembly_df <- tibble::as_tibble_col(assembly_files, column_name = "file") %>%
        dplyr::mutate(header = stringr::str_remove(file, clean_pattern)) 
    
    df <- left_join(metadata, assembly_df, by = "header") %>% 
        mutate (file = ifelse(!is.na(file.y), file.y, file.x)) %>%
        select(-file.x, -file.y) %>%
        select(file, everything()) %>%
        filter(!is.na(file))
    
    
    return(df)
}

