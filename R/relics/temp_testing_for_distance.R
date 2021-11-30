# temp testing for distance
mydist <- readr::read_delim(here::here("data/2021-08-07_ST23_all/results/SNPDIST_results.txt"),
                            trim_ws = T,
                            quote="\"")
head(mydist)
names(mydist)[1] <- "file"
mydist.lon <- reshape2::melt(mydist, id = "file")
View(head(mydist.lon))
names(mydist.lon) <- c("ID1", "ID2", "distance")

# trying to sort out the duplicates
# https://stackoverflow.com/questions/29170099/remove-duplicate-column-pairs-sort-rows-based-on-2-columns/41049336
temp_dedup <- mydist.lon %>%
    rowwise() %>%
    mutate(key = paste(sort(c(ID1,ID2)), collapse = "")) %>%
    distinct(key, .keep_all = T) %>%
    select(-key) %>%
    filter(ID1 != ID2)
    

temp_dedup %>% head(.)
'19-MIK281817_S4_pilon_spades.fasta' %in% temp_dedup$ID2

mydist.lon <- import_distance(here::here("data/2021-08-07_ST23_all/results/SNPDIST_results.txt"))
import_distance
str(mydist.lon)
n_breaks = 40
a <- ggplot(mydist.lon, aes(distance))  +
    geom_density() +
    labs(x = "Pairwise distance") +
    scale_x_continuous(breaks = scales::breaks_extended(n = n_breaks))
a
b <- ggplot(mydist.lon, aes(distance))  +
    ggplot2::stat_ecdf() +
    labs(x = "Pairwise distance",
         y = "cumulative density") +
    scale_x_continuous(breaks = scales::breaks_extended(n = n_breaks))

b

a / b
distance_density_plots(mydist.lon, n_breaks = 40)
###############################################################################
unrooted_plot %>% ggedit::remove_geom('geom_point', 1)
unrooted_plot
#+ theme(legend.position = "none") 

# Alternative solution from distance file - tree_data_obj - for heatmap - works also whith sorted matrix
# distance_file <- readr::read_delim(distance_file_path)
# names(distance_file)[1] <- "file"
# 
# distance.long <- reshape2::melt(distance_file, id = "file")
# names(distance.long) <- c("ID1", "ID2", "distance")


# remove duplicates to get statistics - alternative way, same result ..
temp_distance.long <-
    distance.long %>%
    rowwise() %>%
    mutate(key = paste(sort(c(ID1,ID2)), collapse = "")) %>%
    distinct(key, .keep_all = T) %>%
    select(-key) %>%
    filter(ID1 != ID2)
dim(temp_distance.long)
