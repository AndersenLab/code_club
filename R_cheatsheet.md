# R Cheatsheet

What are some of your favorite R functions/packages/commands? Maybe someone else can learn from you too!

## Tidyverse

* [Cheatsheets](https://www.rstudio.com/resources/cheatsheets/)
* `glue` instead of `paste`

```
species <- "c_elegans"
glue::glue("The species is {species}")
> The species is c_elegans
```
* `tidyr::separate_rows()` to split one cell into several rows
* `dplyr::case_when()` instead of `ifelse`

```
# use this
new_starwars %<>% dplyr::filter(eye_color_new == "cool")

# instead of this
new_starwars <- new_starwars %>% dplyr::filter(eye_color_new == "cool")
```
* Introduction to [dplyr](https://cran.r-project.org/web/packages/dplyr/vignettes/dplyr.html)
* Introduction to [tidyr](https://cran.r-project.org/web/packages/tidyr/vignettes/tidy-data.html)
* Introduction to [readr](https://cran.r-project.org/web/packages/readr/vignettes/readr.html)
* `lubridate` for dates!

## Ploting
* `plotly::ggplotly()` to create interactive ggplot graphs
* `gganimate` to create animation plots
* [Package to help with silly ggplot things](https://brandmaier.github.io/ggx/)

## Misc.

* set working directory as the location of the active file

```
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
```
* `DT:datatable()` to create interactive tables
* `%<>%` allows you to make changes to a current data frame and save over that dataframe
* `data.table::fread()` faster and easier way to read in `.tsv` and `.csv` (or lots of types of files). For more, check out Dan Cook's [blog post](https://www.danielecook.com/speeding-up-reading-and-writing-in-r/)
