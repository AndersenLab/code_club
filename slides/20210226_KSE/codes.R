library(tidyverse)
data(starwars)
library(magrittr)

# "old" complicating way with ifelse()
df2 <- starwars %>%
    dplyr::select(name:species) %>%
    dplyr::mutate(eye_color_new = ifelse(eye_color %in% c("blue", "blue-gray"), "cool",
                                         ifelse(eye_color %in% c("yellow", "red", "orange", "pink", "gold"), "warm", 
                                                ifelse(eye_color %in% c("black", "brown", "hazel", "dark"), "dark", 
                                                       "other"))))
                      
# newer case_when
new_starwars <- starwars %>%
    dplyr::select(name:species) %>%
    dplyr::mutate(eye_color_new = dplyr::case_when(eye_color %in% c("blue", "blue-gray") ~ "cool",
                                                   eye_color %in% c("yellow", "red", "orange", "pink", "gold") ~ "warm",
                                                   eye_color %in% c("black", "brown", "hazel", "dark") ~ "dark",
                                                   TRUE ~ "other"))



DT::datatable(new_starwars, filter = "top")


library(tidyverse)
library(magrittr)

# with magrittr
new_starwars %<>% dplyr::filter(eye_color_new == "cool")

# with normal tidyverse convention
new_starwars <- new_starwars %>%
    dplyr::filter(eye_color_new == "cool")

# create new dataframe
new_starwars <- starwars

# assign warm, cool, dark, or other to eye, hair and skin color now
for(col in c("eye_color", "hair_color", "skin_color")) {
    
    # create new column name
    new_col <- glue::glue("{col}_new")
    
    # add new column to dataframe
    new_starwars %<>% dplyr::mutate(!!new_col := dplyr::case_when(col %in% c("blue", "blue-gray") ~ "cool",
                                                                  col %in% c("yellow", "red", "orange", "pink", "gold") ~ "warm",
                                                                  col %in% c("black", "brown", "hazel", "dark") ~ "dark",
                                                                               TRUE ~ "other"))
    

    
}



new_starwars %>% dplyr::mutate(test = "test")




library(tidyverse)
data(starwars)

# separate each film to new line
new_starwars <- starwars %>%
    dplyr::select(name, films) %>%
    tidyr::separate_rows(films, sep = ",")





library(tidyverse)

# with paste
new_starwars <- starwars %>%
    dplyr::mutate(character = paste(name, ", (", homeworld, ")", sep = ""))

# with paste0
new_starwars <- starwars %>%
    dplyr::mutate(character = paste0(name, ", (", homeworld, ")"))

# with glue
new_starwars <- starwars %>%
    dplyr::mutate(character = glue::glue("{name}, ({mass})"))




library(tidyverse)
library(plotly)

# make normal ggplot
plot <- starwars %>%
    ggplot2::ggplot(.) +
    ggplot2::aes(x = height, y = mass, color = gender) +
    ggplot2::geom_point() +
    ggplot2::theme_bw(14) +
    ggplot2::labs(x = "Height (cm)", y = "Weight (kg)")

# make plotly
plotly::ggplotly(plot)



# add custom text with pointer
plot <- starwars %>%
    ggplot2::ggplot(.) +
    ggplot2::aes(x = height, y = mass, color = gender, 
        text = glue::glue("Name: {name}")) +
    ggplot2::geom_point() +
    ggplot2::theme_bw(14) +
    ggplot2::labs(x = "Height (cm)", y = "Weight (kg)")

plotly::ggplotly(plot, tooltip = "text")


# spotlight

source("~/Dropbox/AndersenLab/LabFolders/Katie/scripts_kse/NIL_narrowing.R")

# plot primers
plot_primers(c("oECA799-oECA800",
               "oECA745-oECA746"), NIL = "ECA232", chr = "V")


# gif
# abamectin QTL mapping gif - RIAILs
library(tidyverse)
library(linkagemapping)
library(gganimate)

# load data
load("~/Dropbox/AndersenLab/LabFolders/Katie/projects/abamectin/manuscript/data/FileS5_riailmap.Rda")
load("~/Dropbox/AndersenLab/LabFolders/Katie/projects/abamectin/manuscript/data/FileS4_riailpheno.Rda")
linkagemapping::load_cross_obj("N2xCB4856cross_full")

# filter by trait and condense iterations
traitmap <- riailmap %>%
    dplyr::filter(trait == "abamectin_mean.EXT") %>%
    dplyr::group_by(marker, chr, pos) %>%
    dplyr::summarize(maxlod = max(lod)) %>%
    dplyr::arrange(chr, pos) %>%
    dplyr::ungroup()

setwd("~/Dropbox/AndersenLab/LabFolders/Katie/projects/abamectin/figures/gif/")

# create plot with animation
myplot <- traitmap %>%
    dplyr::mutate(rownum = as.numeric(row.names(.))) %>%
    ggplot2::ggplot(.) +
    ggplot2::aes(x = pos/1e6, y = maxlod) +
    ggplot2::geom_line() +
    ggplot2::theme_bw(12) +
    ggplot2::labs(x = "Genomic position", y = "LOD") +
    ggplot2::facet_grid(~chr, scales = "free_x", space = "free_x") +
    ggplot2::theme(panel.grid = ggplot2::element_blank(),
                   legend.position = "none") +
    # transition_reveal used to draw lines over "time" aka rownum
    gganimate::transition_reveal(rownum)

# animate with specific dimensions
gganimate::animate(myplot, height = 3, width = 8, units = "in", res = 150)

# save
gganimate::anim_save("lodplot_animate.gif")
