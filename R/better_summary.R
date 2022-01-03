#' HELPER to get summary statistics with tidyverse/dplyr
#' 

better_summary <- function(data, var){
  data %>% 
    summarise(min = min({{var}}),
              q1 = quantile({{var}}, 0.25),
              median = median({{var}}),
              mean = mean({{var}}),
              q3 = quantile({{var}}, 0.75),
              max = max({{var}}),
              count = n())
}
