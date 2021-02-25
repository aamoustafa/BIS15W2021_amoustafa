---
title: "Lab 12 Homework"
author: "Please Add Your Name Here"
date: "2021-02-25"
output:
  html_document: 
    theme: spacelab
    keep_md: yes
---



## Instructions
Answer the following questions and complete the exercises in RMarkdown. Please embed all of your code and push your final work to your repository. Your final lab report should be organized, clean, and run free from errors. Remember, you must remove the `#` for the included code chunks to run. Be sure to add your name to the author header above. For any included plots, make sure they are clearly labeled. You are free to use any plot type that you feel best communicates the results of your analysis.  

Make sure to use the formatting conventions of RMarkdown to make your report neat and clean!  

## Load the libraries

```r
library(tidyverse)
library(janitor)
library(here)
library(ggmap)
library(albersusa)
```

## Load the Data
We will use two separate data sets for this homework.  

1. The first [data set](https://rcweb.dartmouth.edu/~f002d69/workshops/index_rspatial.html) represent sightings of grizzly bears (Ursos arctos) in Alaska.  
2. The second data set is from Brandell, Ellen E (2021), Serological dataset and R code for: Patterns and processes of pathogen exposure in gray wolves across North America, Dryad, [Dataset](https://doi.org/10.5061/dryad.5hqbzkh51).  

1. Load the `grizzly` data and evaluate its structure. As part of this step, produce a summary that provides the range of latitude and longitude so you can build an appropriate bounding box.

```r
grizzly <- read_csv(here("lab12", "data", "bear-sightings.csv")) %>% 
  clean_names()
```

```
## 
## -- Column specification --------------------------------------------------------
## cols(
##   bear.id = col_double(),
##   longitude = col_double(),
##   latitude = col_double()
## )
```


```r
head(grizzly)
```

```
## # A tibble: 6 x 3
##   bear_id longitude latitude
##     <dbl>     <dbl>    <dbl>
## 1       7     -149.     62.7
## 2      57     -153.     58.4
## 3      69     -145.     62.4
## 4      75     -153.     59.9
## 5     104     -143.     61.1
## 6     108     -150.     62.9
```


```r
grizzly %>% 
  select(latitude, longitude) %>% 
  summary()
```

```
##     latitude       longitude     
##  Min.   :55.02   Min.   :-166.2  
##  1st Qu.:58.13   1st Qu.:-154.2  
##  Median :60.97   Median :-151.0  
##  Mean   :61.41   Mean   :-149.1  
##  3rd Qu.:64.13   3rd Qu.:-145.6  
##  Max.   :70.37   Max.   :-131.3
```

2. Use the range of the latitude and longitude to build an appropriate bounding box for your map.

```r
lat <- c(55.02, 70.37)
long <- c(-166.2, -131.3)
bbox <- make_bbox(long, lat, f = 0.05)
```

3. Load a map from `stamen` in a terrain style projection and display the map.

```r
bear_map <- get_map(bbox, maptype = "terrain", source = "stamen")
```

```
## Map tiles by Stamen Design, under CC BY 3.0. Data by OpenStreetMap, under ODbL.
```


```r
ggmap(bear_map)
```

![](lab12_hw_files/figure-html/unnamed-chunk-7-1.png)<!-- -->

4. Build a final map that overlays the recorded observations of grizzly bears in Alaska.

```r
ggmap(bear_map) + 
  geom_point(data = grizzly, aes(longitude, latitude)) +
  labs(title = "Grizzly Bear Locations",
       x = "Longitude", 
       y = "Latitude")
```

![](lab12_hw_files/figure-html/unnamed-chunk-8-1.png)<!-- -->

5. Let's switch to the wolves data. Load the data and evaluate its structure.

```r
wolves <- readr::read_csv("data/wolves_data/wolves_dataset.csv") %>%
  clean_names()
```

```
## 
## -- Column specification --------------------------------------------------------
## cols(
##   .default = col_double(),
##   pop = col_character(),
##   age.cat = col_character(),
##   sex = col_character(),
##   color = col_character()
## )
## i Use `spec()` for the full column specifications.
```


```r
head(wolves)
```

```
## # A tibble: 6 x 23
##   pop    year age_cat sex   color   lat  long habitat human pop_density
##   <chr> <dbl> <chr>   <chr> <chr> <dbl> <dbl>   <dbl> <dbl>       <dbl>
## 1 AK.P~  2006 S       F     G      57.0 -158.    254.  10.4           8
## 2 AK.P~  2006 S       M     G      57.0 -158.    254.  10.4           8
## 3 AK.P~  2006 A       F     G      57.0 -158.    254.  10.4           8
## 4 AK.P~  2006 S       M     B      57.0 -158.    254.  10.4           8
## 5 AK.P~  2006 A       M     B      57.0 -158.    254.  10.4           8
## 6 AK.P~  2006 A       M     G      57.0 -158.    254.  10.4           8
## # ... with 13 more variables: pack_size <dbl>, standard_habitat <dbl>,
## #   standard_human <dbl>, standard_pop <dbl>, standard_packsize <dbl>,
## #   standard_latitude <dbl>, standard_longitude <dbl>, cav_binary <dbl>,
## #   cdv_binary <dbl>, cpv_binary <dbl>, chv_binary <dbl>, neo_binary <dbl>,
## #   toxo_binary <dbl>
```


```r
wolves %>% 
  select(lat, long) %>% 
  summary()
```

```
##       lat             long        
##  Min.   :33.89   Min.   :-157.84  
##  1st Qu.:44.60   1st Qu.:-123.73  
##  Median :46.83   Median :-110.99  
##  Mean   :50.43   Mean   :-116.86  
##  3rd Qu.:57.89   3rd Qu.:-110.55  
##  Max.   :80.50   Max.   : -82.42
```

6. How many distinct wolf populations are included in this study? Mae a new object that restricts the data to the wolf populations in the lower 48 US states.

```r
wolves %>% 
  summarize(n_pops = n_distinct(pop))
```

```
## # A tibble: 1 x 1
##   n_pops
##    <int>
## 1     17
```


```r
lower_wolves <- wolves %>%
  filter(lat<=48)
```

7. Use the `albersusa` package to make a base map of the lower 48 US states.

```r
us_comp <- usa_sf()
```


```r
ggplot() +
  geom_sf(data=us_comp, size=0.125) +
  theme_linedraw() +
  labs(title="USA State Boundaries", 
       x="Longitude", 
       y="Latitude" )
```

![](lab12_hw_files/figure-html/unnamed-chunk-15-1.png)<!-- -->

8. Use the relimited data to plot the distribution of wolf populations in the lower 48 US states.

```r
ggplot()+
  geom_sf(data=us_comp, size=0.125)+
  geom_point(data=lower_wolves, aes(long, lat))+
  theme_minimal()+
  labs(title="Location of Wolf Populations in the Lower 48 US States",
       x="Longitude",
       y="Latitude")
```

![](lab12_hw_files/figure-html/unnamed-chunk-16-1.png)<!-- -->

9. What is the average pack size for the wolves in this study by region?

```r
wolves %>% #If the questions asks for all wolves, not just in the lower 48 states
  group_by(pop) %>%
  summarize(mean_pack_size = mean(pack_size))
```

```
## # A tibble: 17 x 2
##    pop     mean_pack_size
##  * <chr>            <dbl>
##  1 AK.PEN            8.78
##  2 BAN.JAS           9.56
##  3 BC                5.88
##  4 DENALI            6.45
##  5 ELLES             9.19
##  6 GTNP              8.1 
##  7 INT.AK            6.24
##  8 MEXICAN           4.04
##  9 MI                7.12
## 10 MT                5.62
## 11 N.NWT             4   
## 12 ONT               4.37
## 13 SE.AK             5   
## 14 SNF               4.81
## 15 SS.NWT            3.55
## 16 YNP               8.25
## 17 YUCH              6.37
```

10. Make a new map that shows the distribution of wolves in the lower 48 US states but which has the size of location markers adjusted by pack size.

```r
ggplot()+
  geom_sf(data = us_comp, size = .0125) +
  geom_point(data=lower_wolves, aes(long, lat, size= pack_size))+
  theme_minimal()+
  labs(title= "Wolves Distribution in the Lower 48 US States",
       x="Longitude", 
       y="Latitude")
```

![](lab12_hw_files/figure-html/unnamed-chunk-18-1.png)<!-- -->

## Push your final code to GitHub!
Please be sure that you check the `keep md` file in the knit preferences. 
