mymid_value <- 25 
mysd_value <- 3

snp_dist <- seq(2, 35, by = 1)
snp_dist
max(snp_dist)

trial_pal <- heatmap_pal(snp_dist, 
            mid_value = 25, 
            sd_value = 3, 
            low_color = "blue", 
            mid_colors = c("green", "yellow", "violet"), 
            high_color = "red")

trial_pal
cut(trial_pal)

plot(snp_dist,col=trial_pal, pch=19,cex=2)
scales::breaks_extended(n = 3)
# mymid_three_colors <- (c("red", "yellow", "green"))
# 
# 
# 
# mylow_range <- c(min(snp_dist), mymid_value - mysd_value - 1)
# mylow_range
# nb_low_values <- mymid_value - min(snp_dist) - mysd_value 
# nb_low_values
# 
# myhigh_range <- c(mymid_value + mysd_value + 1 , max(snp_dist))
# myhigh_range
# nb_high_values <- max(snp_dist) - (mymid_value + mysd_value)
# nb_high_values
# 
# nb_mid_values <- 2*mysd_value + 1 
# nb_mid_values
# 
# low_fun <- colorRampPalette(low_color)
mid_fun <- colorRampPalette(mymid_three_colors)
# high_fun <- colorRampPalette(high_color)
# 
# col2hex(c("blue"))
# mid_fun(nb_mid_values)
mid_fun(10)

mybreaks <- create_breaks(snp_dist, 
                         mid_value = 25, 
                         sd_value = 3)
mybreaks
label_function(mybreaks)

# https://stackoverflow.com/questions/13353213/gradient-of-n-colors-ranging-from-color-1-and-color-2

length(pal)
plot(rep(1,9),col = pal,pch=19,cex=3)
