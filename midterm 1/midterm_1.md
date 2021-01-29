---
title: "Midterm 1"
author: "Alay Adeen Moustafa"
date: "2021-01-29"
output:
  html_document: 
    theme: spacelab
    keep_md: yes
---



## Instructions
Answer the following questions and complete the exercises in RMarkdown. Please embed all of your code and push your final work to your repository. Your code should be organized, clean, and run free from errors. Be sure to **add your name** to the author header above. You may use any resources to answer these questions (including each other), but you may not post questions to Open Stacks or external help sites. There are 12 total questions.  

Make sure to use the formatting conventions of RMarkdown to make your report neat and clean!  

This exam is due by **12:00p on Thursday, January 28**.  

## Load the tidyverse
If you plan to use any other libraries to complete this assignment then you should load them here.

```r
library(tidyverse)
library(janitor)
library(skimr)
```

## Questions
**1. (2 points) Briefly explain how R, RStudio, and GitHub work together to make work flows in data science transparent and repeatable. What is the advantage of using RMarkdown in this context?**  
RStudio is a GUI used to interact with R, the programming language, making it easier to use. GitHub is a file storage and management website that can be used by programmers to upload their code from RStudio for public access. As a result, Github makes it easier for programmers to share their code and previous work for others to use and repeat.  RMarkdown allows the programmer to present their code in a clean and organized manner to others. As a file type, RMarkdown allows GitHub users to access others' codes, allowing for easy interaction and public access. 


**2. (2 points) What are the three types of `data structures` that we have discussed? Why are we using data frames for BIS 15L?**

The three types of data structures are vectors, data matrices, and data frames. Data frames have the ability to store different classes, and through the use of tidyverse we are able to manipulate the data frame in several ways. Data tables in general are neat and organized compared to other data structures.

In the midterm 1 folder there is a second folder called `data`. Inside the `data` folder, there is a .csv file called `ElephantsMF`. These data are from Phyllis Lee, Stirling University, and are related to Lee, P., et al. (2013), "Enduring consequences of early experiences: 40-year effects on survival and success among African elephants (Loxodonta africana)," Biology Letters, 9: 20130011. [kaggle](https://www.kaggle.com/mostafaelseidy/elephantsmf).  

**3. (2 points) Please load these data as a new object called `elephants`. Use the function(s) of your choice to get an idea of the structure of the data. Be sure to show the class of each variable.**


```r
elephants <- readr::read_csv("data/ElephantsMF.csv")
```

```
## 
## -- Column specification --------------------------------------------------------
## cols(
##   Age = col_double(),
##   Height = col_double(),
##   Sex = col_character()
## )
```


```r
glimpse(elephants)
```

```
## Rows: 288
## Columns: 3
## $ Age    <dbl> 1.40, 17.50, 12.75, 11.17, 12.67, 12.67, 12.25, 12.17, 28.17...
## $ Height <dbl> 120.00, 227.00, 235.00, 210.00, 220.00, 189.00, 225.00, 204....
## $ Sex    <chr> "M", "M", "M", "M", "M", "M", "M", "M", "M", "M", "M", "M", ...
```

```r
head(elephants)
```

```
## # A tibble: 6 x 3
##     Age Height Sex  
##   <dbl>  <dbl> <chr>
## 1   1.4    120 M    
## 2  17.5    227 M    
## 3  12.8    235 M    
## 4  11.2    210 M    
## 5  12.7    220 M    
## 6  12.7    189 M
```

```r
summary(elephants)
```

```
##       Age            Height           Sex           
##  Min.   : 0.01   Min.   : 75.46   Length:288        
##  1st Qu.: 4.58   1st Qu.:160.75   Class :character  
##  Median : 9.46   Median :200.00   Mode  :character  
##  Mean   :10.97   Mean   :187.68                     
##  3rd Qu.:16.50   3rd Qu.:221.09                     
##  Max.   :32.17   Max.   :304.06
```


**4. (2 points) Change the names of the variables to lower case and change the class of the variable `sex` to a factor.**


```r
elephants <- janitor::clean_names(elephants)
elephants
```

```
## # A tibble: 288 x 3
##      age height sex  
##    <dbl>  <dbl> <chr>
##  1   1.4   120  M    
##  2  17.5   227  M    
##  3  12.8   235  M    
##  4  11.2   210  M    
##  5  12.7   220  M    
##  6  12.7   189  M    
##  7  12.2   225  M    
##  8  12.2   204  M    
##  9  28.2   266. M    
## 10  11.7   233  M    
## # ... with 278 more rows
```


```r
elephants$sex <- as.factor(elephants$sex)
```


**5. (2 points) How many male and female elephants are represented in the data?**


```r
elephants %>%
  count(sex)
```

```
## # A tibble: 2 x 2
##   sex       n
## * <fct> <int>
## 1 F       150
## 2 M       138
```
There are 150 female elephants and 138 male elephants.

**6. (2 points) What is the average age all elephants in the data?**


```r
elephants %>%
  select(age) %>%
  summarize(mean_age = mean(age))
```

```
## # A tibble: 1 x 1
##   mean_age
##      <dbl>
## 1     11.0
```


**7. (2 points) How does the average age and height of elephants compare by sex?**


```r
elephants %>%
  group_by(sex) %>%
  summarize(mean_height = mean(height),
            mean_age= mean(age))
```

```
## # A tibble: 2 x 3
##   sex   mean_height mean_age
## * <fct>       <dbl>    <dbl>
## 1 F            190.    12.8 
## 2 M            185.     8.95
```


**8. (2 points) How does the average height of elephants compare by sex for individuals over 25 years old. Include the min and max height as well as the number of individuals in the sample as part of your analysis.**


```r
elephants %>%
  filter(age > 25) %>%
  group_by(sex) %>%
  summarize(mean_height = mean(height),
            min_height = min(height),
            max_height = max(height))
```

```
## # A tibble: 2 x 4
##   sex   mean_height min_height max_height
## * <fct>       <dbl>      <dbl>      <dbl>
## 1 F            233.       206.       278.
## 2 M            273.       237.       304.
```


For the next series of questions, we will use data from a study on vertebrate community composition and impacts from defaunation in [Gabon, Africa](https://en.wikipedia.org/wiki/Gabon). One thing to notice is that the data include 24 separate transects. Each transect represents a path through different forest management areas.  

Reference: Koerner SE, Poulsen JR, Blanchard EJ, Okouyi J, Clark CJ. Vertebrate community composition and diversity declines along a defaunation gradient radiating from rural villages in Gabon. _Journal of Applied Ecology_. 2016. This paper, along with a description of the variables is included inside the midterm 1 folder.  

**9. (2 points) Load `IvindoData_DryadVersion.csv` and use the function(s) of your choice to get an idea of the overall structure. Change the variables `HuntCat` and `LandUse` to factors.**


```r
ivindodata<- readr::read_csv("data/IvindoData_DryadVersion.csv")
```

```
## 
## -- Column specification --------------------------------------------------------
## cols(
##   .default = col_double(),
##   HuntCat = col_character(),
##   LandUse = col_character()
## )
## i Use `spec()` for the full column specifications.
```

```r
ivindodata <- janitor::clean_names(ivindodata)
```


```r
head(ivindodata)
```

```
## # A tibble: 6 x 26
##   transect_id distance hunt_cat num_households land_use veg_rich veg_stems
##         <dbl>    <dbl> <chr>             <dbl> <chr>       <dbl>     <dbl>
## 1           1     7.14 Moderate             54 Park         16.7      31.2
## 2           2    17.3  None                 54 Park         15.8      37.4
## 3           2    18.3  None                 29 Park         16.9      32.3
## 4           3    20.8  None                 29 Logging      12.4      29.4
## 5           4    16.0  None                 29 Park         17.1      36  
## 6           5    17.5  None                 29 Park         16.5      29.2
## # ... with 19 more variables: veg_liana <dbl>, veg_dbh <dbl>, veg_canopy <dbl>,
## #   veg_understory <dbl>, ra_apes <dbl>, ra_birds <dbl>, ra_elephant <dbl>,
## #   ra_monkeys <dbl>, ra_rodent <dbl>, ra_ungulate <dbl>,
## #   rich_all_species <dbl>, evenness_all_species <dbl>,
## #   diversity_all_species <dbl>, rich_bird_species <dbl>,
## #   evenness_bird_species <dbl>, diversity_bird_species <dbl>,
## #   rich_mammal_species <dbl>, evenness_mammal_species <dbl>,
## #   diversity_mammal_species <dbl>
```

```r
names(ivindodata)
```

```
##  [1] "transect_id"              "distance"                
##  [3] "hunt_cat"                 "num_households"          
##  [5] "land_use"                 "veg_rich"                
##  [7] "veg_stems"                "veg_liana"               
##  [9] "veg_dbh"                  "veg_canopy"              
## [11] "veg_understory"           "ra_apes"                 
## [13] "ra_birds"                 "ra_elephant"             
## [15] "ra_monkeys"               "ra_rodent"               
## [17] "ra_ungulate"              "rich_all_species"        
## [19] "evenness_all_species"     "diversity_all_species"   
## [21] "rich_bird_species"        "evenness_bird_species"   
## [23] "diversity_bird_species"   "rich_mammal_species"     
## [25] "evenness_mammal_species"  "diversity_mammal_species"
```



```r
ivindodata$hunt_cat <- as.factor(ivindodata$hunt_cat)
ivindodata$land_use <- as.factor(ivindodata$land_use)
```


**10. (4 points) For the transects with high and moderate hunting intensity, how does the average diversity of birds and mammals compare?**


```r
ivindodata %>%
  filter(hunt_cat != "None") %>% 
  group_by(hunt_cat) %>% 
  summarise(mean_bird = mean(diversity_bird_species),
            mean_mammal = mean(diversity_mammal_species))
```

```
## # A tibble: 2 x 3
##   hunt_cat mean_bird mean_mammal
## * <fct>        <dbl>       <dbl>
## 1 High          1.66        1.74
## 2 Moderate      1.62        1.68
```


**11. (4 points) One of the conclusions in the study is that the relative abundance of animals drops off the closer you get to a village. Let's try to reconstruct this (without the statistics). How does the relative abundance (RA) of apes, birds, elephants, monkeys, rodents, and ungulates compare between sites that are less than 5km from a village to sites that are greater than 20km from a village? The variable `Distance` measures the distance of the transect from the nearest village. Hint: try using the `across` operator.**  


```r
dlessthan_five <- ivindodata %>%
  filter(distance > 20) %>%
  summarize(across(contains("ra_"), mean))
dlessthan_five
```

```
## # A tibble: 1 x 6
##   ra_apes ra_birds ra_elephant ra_monkeys ra_rodent ra_ungulate
##     <dbl>    <dbl>       <dbl>      <dbl>     <dbl>       <dbl>
## 1    7.21     44.5       0.557       40.1      2.68        4.98
```

```r
dgreaterthan_twenty <- ivindodata %>%
  filter(distance < 5) %>%
  summarize(across(contains("ra_"), mean))
dgreaterthan_twenty
```

```
## # A tibble: 1 x 6
##   ra_apes ra_birds ra_elephant ra_monkeys ra_rodent ra_ungulate
##     <dbl>    <dbl>       <dbl>      <dbl>     <dbl>       <dbl>
## 1    0.08     70.4      0.0967       24.1      3.66        1.59
```


**12. (4 points) Based on your interest, do one exploratory analysis on the `gabon` data of your choice. This analysis needs to include a minimum of two functions in `dplyr.`**

What type of land has the greatest overall species diversity? 


```r
ivindodata %>%
  group_by(land_use) %>%
  summarize(mean_diversity = mean(diversity_all_species)) %>%
  arrange(desc(mean_diversity))
```

```
## # A tibble: 3 x 2
##   land_use mean_diversity
##   <fct>             <dbl>
## 1 Park               2.43
## 2 Neither            2.36
## 3 Logging            2.23
```

Parks have the greatest species diversity and can be used as a sightseeing, tourist attraction. 
