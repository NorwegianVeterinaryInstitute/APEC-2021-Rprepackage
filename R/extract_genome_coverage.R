# function that extract cpverage for the genomes for parnsp 


extract_genome_coverage <- function(file) {
    parsnp <-readLines(file)
    parsnp <- parsnp[str_detect(parsnp, "(Cluster coverage in sequence)|(Total coverage among all sequences)")]
    df <- as.data.frame(cbind (parsnp))
    
    df <- df %>% 
        dplyr::rename(text = "parsnp") %>%
        tidyr::separate(text, into = c("garbage", "text"), sep = ":") %>%
        dplyr::select(-garbage) 
        
    
    mytext <- str_squish(df$text) 
    mytext <- str_remove(mytext, '%')
    mytotal <- as.numeric(mytext[length(mytext)])
    mytext <- as.numeric(mytext[1: (length(mytext) -1)])
    
    print(c("range: ", range(mytext)))
    print(c("total: " , mytotal))
         
}
