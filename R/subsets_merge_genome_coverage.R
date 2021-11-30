# merging genome goverage in one table
# script to clean 

source("scripts/extract_genome_coverage.R")

library(gtools)

get_genome_coverage <- function(path_dir, filename = "PARSNP_results.txt") {
  genome_coverage <- capture.output(extract_genome_coverage(paste(path_dir, filename, sep = "/")))
  CC_name <- str_remove(str_remove(path_dir, "/output/results"), "/.*/") 
  coverage <- unlist(str_extract_all(genome_coverage, "\\d+.\\d+"))
  myrow <- c(coverage, CC_name)
  df <- t(as_tibble(myrow))
  colnames(df) <- c("min", "max", "total", "CC")
  return(df)
}

list_df <- lapply(mypaths, get_genome_coverage)
list_df
df <- as.data.frame(do.call(rbind, list_df))
df <- df %>% 
  select(CC, everything()) %>%
  remove_rownames()
write_csv(df, here::here("results", "genome_coverage.csv"))    