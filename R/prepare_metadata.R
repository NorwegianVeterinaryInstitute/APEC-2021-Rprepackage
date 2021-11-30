# improve the dots ! 

#' Prepare metadata for plotting, merge with external data if exist
#'
#' Function that imports Camillas metadata and formats it for analysis
#' Requires txt file, ... parameters passed to readr::read_delim() 
#' ... parameters must be identical for metadata and external data if exsit
#'
#' @param path_metadata Path of the metadatafile
#' @param treescale_y The y position of the treescale
#' @return metadata 
#' @example 
#' prepare_metadata("./data/mymetadata.txt", "./data/myexternal.txt", delim = ';' )
#' @author Eve Zeyl Fiskebeck, \email{evezeyl@@gmail.com}
#'
#' @export
#' @import tidyverse
#'
#'
prepare_metadata <- function(path_metadata, path_external_data=NULL,
                             trim_ws = T, delim = "@") {
    
    df <- 
        readr::read_delim(path_metadata,
                            delim = delim,
                            trim_ws = T) %>%
        dplyr::rename(ID = `PJS-nummer`) %>%
        dplyr::select(ID, Kategori, Source, Location, ST, header) %>%
        tibble::add_column(Country = "No")

    #if external data associated
    if (!is.null(path_external_data)) {

        ext_df<- read_delim(path_external_data,
                            delim = delim,
                            trim_ws = T)

        ext_df <- ext_df %>%
            dplyr::select(Uberstrain, Name, `Source Niche`, `Collection Year`, Country, `Sample ID`, `O Antigen`, `H Antigen`, Enterobase_file) %>%
            dplyr::rename(file = Enterobase_file, ID = "Uberstrain", Source = "Source Niche", Year = "Collection Year") %>%
            tibble::add_column(ST = "23", Kategori = "E. coli")

        df <- dplyr::full_join(df, ext_df)
    }
    #return metadata
    return(df)
}
