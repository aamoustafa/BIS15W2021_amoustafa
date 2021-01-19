---
title: "Lab 4 Homework"
author: "Alay Adeen Moustafa"
date: "2021-01-19"
output:
  html_document: 
    theme: spacelab
    keep_md: yes
---



## Instructions
Answer the following questions and complete the exercises in RMarkdown. Please embed all of your code and push your final work to your repository. Your final lab report should be organized, clean, and run free from errors. Remember, you must remove the `#` for the included code chunks to run. Be sure to add your name to the author header above.  

Make sure to use the formatting conventions of RMarkdown to make your report neat and clean!  

## Load the tidyverse

```r
library(tidyverse)
```

## Data
For the homework, we will use data about vertebrate home range sizes. The data are in the class folder, but the reference is below.  

**Database of vertebrate home range sizes.**  
Reference: Tamburello N, Cote IM, Dulvy NK (2015) Energy and the scaling of animal space use. The American Naturalist 186(2):196-211. http://dx.doi.org/10.1086/682070.  
Data: http://datadryad.org/resource/doi:10.5061/dryad.q5j65/1  

**1. Load the data into a new object called `homerange`.**


```r
homerange <- readr::read_csv("Tamburelloetal_HomeRangeDatabase.csv")
```

```
## 
## -- Column specification --------------------------------------------------------
## cols(
##   .default = col_character(),
##   mean.mass.g = col_double(),
##   log10.mass = col_double(),
##   mean.hra.m2 = col_double(),
##   log10.hra = col_double(),
##   preymass = col_double(),
##   log10.preymass = col_double(),
##   PPMR = col_double()
## )
## i Use `spec()` for the full column specifications.
```


**2. Explore the data. Show the dimensions, column names, classes for each variable, and a statistical summary. Keep these as separate code chunks.**  

```r
dim(homerange)
```

```
## [1] 569  24
```


```r
names(homerange)
```

```
##  [1] "taxon"                      "common.name"               
##  [3] "class"                      "order"                     
##  [5] "family"                     "genus"                     
##  [7] "species"                    "primarymethod"             
##  [9] "N"                          "mean.mass.g"               
## [11] "log10.mass"                 "alternative.mass.reference"
## [13] "mean.hra.m2"                "log10.hra"                 
## [15] "hra.reference"              "realm"                     
## [17] "thermoregulation"           "locomotion"                
## [19] "trophic.guild"              "dimension"                 
## [21] "preymass"                   "log10.preymass"            
## [23] "PPMR"                       "prey.size.reference"
```


```r
str(homerange)
```

```
## tibble [569 x 24] (S3: spec_tbl_df/tbl_df/tbl/data.frame)
##  $ taxon                     : chr [1:569] "lake fishes" "river fishes" "river fishes" "river fishes" ...
##  $ common.name               : chr [1:569] "american eel" "blacktail redhorse" "central stoneroller" "rosyside dace" ...
##  $ class                     : chr [1:569] "actinopterygii" "actinopterygii" "actinopterygii" "actinopterygii" ...
##  $ order                     : chr [1:569] "anguilliformes" "cypriniformes" "cypriniformes" "cypriniformes" ...
##  $ family                    : chr [1:569] "anguillidae" "catostomidae" "cyprinidae" "cyprinidae" ...
##  $ genus                     : chr [1:569] "anguilla" "moxostoma" "campostoma" "clinostomus" ...
##  $ species                   : chr [1:569] "rostrata" "poecilura" "anomalum" "funduloides" ...
##  $ primarymethod             : chr [1:569] "telemetry" "mark-recapture" "mark-recapture" "mark-recapture" ...
##  $ N                         : chr [1:569] "16" NA "20" "26" ...
##  $ mean.mass.g               : num [1:569] 887 562 34 4 4 ...
##  $ log10.mass                : num [1:569] 2.948 2.75 1.531 0.602 0.602 ...
##  $ alternative.mass.reference: chr [1:569] NA NA NA NA ...
##  $ mean.hra.m2               : num [1:569] 282750 282.1 116.1 125.5 87.1 ...
##  $ log10.hra                 : num [1:569] 5.45 2.45 2.06 2.1 1.94 ...
##  $ hra.reference             : chr [1:569] "Minns, C. K. 1995. Allometry of home range size in lake and river fishes. Canadian Journal of Fisheries and Aqu"| __truncated__ "Minns, C. K. 1995. Allometry of home range size in lake and river fishes. Canadian Journal of Fisheries and Aqu"| __truncated__ "Minns, C. K. 1995. Allometry of home range size in lake and river fishes. Canadian Journal of Fisheries and Aqu"| __truncated__ "Minns, C. K. 1995. Allometry of home range size in lake and river fishes. Canadian Journal of Fisheries and Aqu"| __truncated__ ...
##  $ realm                     : chr [1:569] "aquatic" "aquatic" "aquatic" "aquatic" ...
##  $ thermoregulation          : chr [1:569] "ectotherm" "ectotherm" "ectotherm" "ectotherm" ...
##  $ locomotion                : chr [1:569] "swimming" "swimming" "swimming" "swimming" ...
##  $ trophic.guild             : chr [1:569] "carnivore" "carnivore" "carnivore" "carnivore" ...
##  $ dimension                 : chr [1:569] "3D" "2D" "2D" "2D" ...
##  $ preymass                  : num [1:569] NA NA NA NA NA NA 1.39 NA NA NA ...
##  $ log10.preymass            : num [1:569] NA NA NA NA NA ...
##  $ PPMR                      : num [1:569] NA NA NA NA NA NA 530 NA NA NA ...
##  $ prey.size.reference       : chr [1:569] NA NA NA NA ...
##  - attr(*, "spec")=
##   .. cols(
##   ..   taxon = col_character(),
##   ..   common.name = col_character(),
##   ..   class = col_character(),
##   ..   order = col_character(),
##   ..   family = col_character(),
##   ..   genus = col_character(),
##   ..   species = col_character(),
##   ..   primarymethod = col_character(),
##   ..   N = col_character(),
##   ..   mean.mass.g = col_double(),
##   ..   log10.mass = col_double(),
##   ..   alternative.mass.reference = col_character(),
##   ..   mean.hra.m2 = col_double(),
##   ..   log10.hra = col_double(),
##   ..   hra.reference = col_character(),
##   ..   realm = col_character(),
##   ..   thermoregulation = col_character(),
##   ..   locomotion = col_character(),
##   ..   trophic.guild = col_character(),
##   ..   dimension = col_character(),
##   ..   preymass = col_double(),
##   ..   log10.preymass = col_double(),
##   ..   PPMR = col_double(),
##   ..   prey.size.reference = col_character()
##   .. )
```


```r
summary(homerange)
```

```
##     taxon           common.name           class              order          
##  Length:569         Length:569         Length:569         Length:569        
##  Class :character   Class :character   Class :character   Class :character  
##  Mode  :character   Mode  :character   Mode  :character   Mode  :character  
##                                                                             
##                                                                             
##                                                                             
##                                                                             
##     family             genus             species          primarymethod     
##  Length:569         Length:569         Length:569         Length:569        
##  Class :character   Class :character   Class :character   Class :character  
##  Mode  :character   Mode  :character   Mode  :character   Mode  :character  
##                                                                             
##                                                                             
##                                                                             
##                                                                             
##       N              mean.mass.g        log10.mass     
##  Length:569         Min.   :      0   Min.   :-0.6576  
##  Class :character   1st Qu.:     50   1st Qu.: 1.6990  
##  Mode  :character   Median :    330   Median : 2.5185  
##                     Mean   :  34602   Mean   : 2.5947  
##                     3rd Qu.:   2150   3rd Qu.: 3.3324  
##                     Max.   :4000000   Max.   : 6.6021  
##                                                        
##  alternative.mass.reference  mean.hra.m2          log10.hra     
##  Length:569                 Min.   :0.000e+00   Min.   :-1.523  
##  Class :character           1st Qu.:4.500e+03   1st Qu.: 3.653  
##  Mode  :character           Median :3.934e+04   Median : 4.595  
##                             Mean   :2.146e+07   Mean   : 4.709  
##                             3rd Qu.:1.038e+06   3rd Qu.: 6.016  
##                             Max.   :3.551e+09   Max.   : 9.550  
##                                                                 
##  hra.reference         realm           thermoregulation    locomotion       
##  Length:569         Length:569         Length:569         Length:569        
##  Class :character   Class :character   Class :character   Class :character  
##  Mode  :character   Mode  :character   Mode  :character   Mode  :character  
##                                                                             
##                                                                             
##                                                                             
##                                                                             
##  trophic.guild       dimension            preymass         log10.preymass   
##  Length:569         Length:569         Min.   :     0.67   Min.   :-0.1739  
##  Class :character   Class :character   1st Qu.:    20.02   1st Qu.: 1.3014  
##  Mode  :character   Mode  :character   Median :    53.75   Median : 1.7304  
##                                        Mean   :  3989.88   Mean   : 2.0188  
##                                        3rd Qu.:   363.35   3rd Qu.: 2.5603  
##                                        Max.   :130233.20   Max.   : 5.1147  
##                                        NA's   :502         NA's   :502      
##       PPMR         prey.size.reference
##  Min.   :  0.380   Length:569         
##  1st Qu.:  3.315   Class :character   
##  Median :  7.190   Mode  :character   
##  Mean   : 31.752                      
##  3rd Qu.: 15.966                      
##  Max.   :530.000                      
##  NA's   :502
```


**3. Change the class of the variables `taxon` and `order` to factors and display their levels.**  


```r
class(homerange$taxon)
```

```
## [1] "character"
```

```r
class(homerange$order)
```

```
## [1] "character"
```


```r
homerange$taxon <- as.factor(homerange$taxon)
homerange$order <- as.factor(homerange$order)
```


```r
class(homerange$taxon)
```

```
## [1] "factor"
```

```r
class(homerange$order)
```

```
## [1] "factor"
```


**4. What taxa are represented in the `homerange` data frame? Make a new data frame `taxa` that is restricted to taxon, common name, class, order, family, genus, species.** 


```r
table(homerange$taxon)
```

```
## 
##         birds   lake fishes       lizards       mammals marine fishes 
##           140             9            11           238            90 
##  river fishes        snakes     tortoises       turtles 
##            14            41            12            14
```


```r
taxa <- select(homerange, family, taxon, common.name, class, order, genus, species)
taxa
```

```
## # A tibble: 569 x 7
##    family    taxon     common.name       class      order     genus    species  
##    <chr>     <fct>     <chr>             <chr>      <fct>     <chr>    <chr>    
##  1 anguilli~ lake fis~ american eel      actinopte~ anguilli~ anguilla rostrata 
##  2 catostom~ river fi~ blacktail redhor~ actinopte~ cyprinif~ moxosto~ poecilura
##  3 cyprinid~ river fi~ central stonerol~ actinopte~ cyprinif~ campost~ anomalum 
##  4 cyprinid~ river fi~ rosyside dace     actinopte~ cyprinif~ clinost~ funduloi~
##  5 cyprinid~ river fi~ longnose dace     actinopte~ cyprinif~ rhinich~ cataract~
##  6 esocidae  river fi~ muskellunge       actinopte~ esocifor~ esox     masquino~
##  7 gadidae   marine f~ pollack           actinopte~ gadiform~ pollach~ pollachi~
##  8 gadidae   marine f~ saithe            actinopte~ gadiform~ pollach~ virens   
##  9 acanthur~ marine f~ lined surgeonfish actinopte~ percifor~ acanthu~ lineatus 
## 10 acanthur~ marine f~ orangespine unic~ actinopte~ percifor~ naso     lituratus
## # ... with 559 more rows
```


**5. The variable `taxon` identifies the large, common name groups of the species represented in `homerange`. Make a table the shows the counts for each of these `taxon`.**  


```r
table(taxa$taxon)
```

```
## 
##         birds   lake fishes       lizards       mammals marine fishes 
##           140             9            11           238            90 
##  river fishes        snakes     tortoises       turtles 
##            14            41            12            14
```


**6. The species in `homerange` are also classified into trophic guilds. How many species are represented in each trophic guild.**  


```r
table(homerange$trophic.guild)
```

```
## 
## carnivore herbivore 
##       342       227
```
There are 342 species that are carnivores and 227 species that are herbivores.

**7. Make two new data frames, one which is restricted to carnivores and another that is restricted to herbivores.**  


```r
meateaters <- filter(homerange, trophic.guild == "carnivore")
meateaters
```

```
## # A tibble: 342 x 24
##    taxon common.name class order family genus species primarymethod N    
##    <fct> <chr>       <chr> <fct> <chr>  <chr> <chr>   <chr>         <chr>
##  1 lake~ american e~ acti~ angu~ angui~ angu~ rostra~ telemetry     16   
##  2 rive~ blacktail ~ acti~ cypr~ catos~ moxo~ poecil~ mark-recaptu~ <NA> 
##  3 rive~ central st~ acti~ cypr~ cypri~ camp~ anomal~ mark-recaptu~ 20   
##  4 rive~ rosyside d~ acti~ cypr~ cypri~ clin~ fundul~ mark-recaptu~ 26   
##  5 rive~ longnose d~ acti~ cypr~ cypri~ rhin~ catara~ mark-recaptu~ 17   
##  6 rive~ muskellunge acti~ esoc~ esoci~ esox  masqui~ telemetry     5    
##  7 mari~ pollack     acti~ gadi~ gadid~ poll~ pollac~ telemetry     2    
##  8 mari~ saithe      acti~ gadi~ gadid~ poll~ virens  telemetry     2    
##  9 mari~ giant trev~ acti~ perc~ caran~ cara~ ignobi~ telemetry     4    
## 10 lake~ rock bass   acti~ perc~ centr~ ambl~ rupest~ mark-recaptu~ 16   
## # ... with 332 more rows, and 15 more variables: mean.mass.g <dbl>,
## #   log10.mass <dbl>, alternative.mass.reference <chr>, mean.hra.m2 <dbl>,
## #   log10.hra <dbl>, hra.reference <chr>, realm <chr>, thermoregulation <chr>,
## #   locomotion <chr>, trophic.guild <chr>, dimension <chr>, preymass <dbl>,
## #   log10.preymass <dbl>, PPMR <dbl>, prey.size.reference <chr>
```

```r
planteaters <- filter(homerange, trophic.guild == "herbivore")
planteaters
```

```
## # A tibble: 227 x 24
##    taxon common.name class order family genus species primarymethod N    
##    <fct> <chr>       <chr> <fct> <chr>  <chr> <chr>   <chr>         <chr>
##  1 mari~ lined surg~ acti~ perc~ acant~ acan~ lineat~ direct obser~ <NA> 
##  2 mari~ orangespin~ acti~ perc~ acant~ naso  litura~ telemetry     8    
##  3 mari~ bluespine ~ acti~ perc~ acant~ naso  unicor~ telemetry     7    
##  4 mari~ redlip ble~ acti~ perc~ blenn~ ophi~ atlant~ direct obser~ 20   
##  5 mari~ bermuda ch~ acti~ perc~ kypho~ kyph~ sectat~ telemetry     11   
##  6 mari~ cherubfish  acti~ perc~ pomac~ cent~ argi    direct obser~ <NA> 
##  7 mari~ damselfish  acti~ perc~ pomac~ chro~ chromis direct obser~ <NA> 
##  8 mari~ twinspot d~ acti~ perc~ pomac~ chry~ biocel~ direct obser~ 18   
##  9 mari~ wards dams~ acti~ perc~ pomac~ poma~ wardi   direct obser~ <NA> 
## 10 mari~ australian~ acti~ perc~ pomac~ steg~ apical~ direct obser~ <NA> 
## # ... with 217 more rows, and 15 more variables: mean.mass.g <dbl>,
## #   log10.mass <dbl>, alternative.mass.reference <chr>, mean.hra.m2 <dbl>,
## #   log10.hra <dbl>, hra.reference <chr>, realm <chr>, thermoregulation <chr>,
## #   locomotion <chr>, trophic.guild <chr>, dimension <chr>, preymass <dbl>,
## #   log10.preymass <dbl>, PPMR <dbl>, prey.size.reference <chr>
```


**8. Do herbivores or carnivores have, on average, a larger `mean.hra.m2`? Remove any NAs from the data.**  

```r
herbivoresmean <- planteaters$mean.hra.m2
mean(herbivoresmean, na.rm=T)
```

```
## [1] 34137012
```

```r
carnivoresmean <- meateaters$mean.hra.m2
mean(carnivoresmean, na.rm=T)
```

```
## [1] 13039918
```

Herbivores on average have a larger 'mean.hra.m2'. While herbivores have a mean of 34137012, carnovires have a mean of 13039918. 


**9. Make a new dataframe `deer` that is limited to the mean mass, log10 mass, family, genus, and species of deer in the database. The family for deer is cervidae. Arrange the data in descending order by log10 mass. Which is the largest deer? What is its common name?**  


```r
homerange <- rename(homerange, mean_mass_g = mean.mass.g, log10_mass=log10.mass)
deerpart1 <- select(homerange, mean_mass_g, log10_mass, family, genus, species)
deerpart2 <- filter(deerpart1, family == "cervidae")
deerpart2
```

```
## # A tibble: 12 x 5
##    mean_mass_g log10_mass family   genus      species    
##          <dbl>      <dbl> <chr>    <chr>      <chr>      
##  1     307227.       5.49 cervidae alces      alces      
##  2      62823.       4.80 cervidae axis       axis       
##  3      24050.       4.38 cervidae capreolus  capreolus  
##  4     234758.       5.37 cervidae cervus     elaphus    
##  5      29450.       4.47 cervidae cervus     nippon     
##  6      71450.       4.85 cervidae dama       dama       
##  7      13500.       4.13 cervidae muntiacus  reevesi    
##  8      53864.       4.73 cervidae odocoileus hemionus   
##  9      87884.       4.94 cervidae odocoileus virginianus
## 10      35000.       4.54 cervidae ozotoceros bezoarticus
## 11       7500.       3.88 cervidae pudu       puda       
## 12     102059.       5.01 cervidae rangifer   tarandus
```

```r
deer <- arrange(deerpart2, desc(log10_mass))
deer
```

```
## # A tibble: 12 x 5
##    mean_mass_g log10_mass family   genus      species    
##          <dbl>      <dbl> <chr>    <chr>      <chr>      
##  1     307227.       5.49 cervidae alces      alces      
##  2     234758.       5.37 cervidae cervus     elaphus    
##  3     102059.       5.01 cervidae rangifer   tarandus   
##  4      87884.       4.94 cervidae odocoileus virginianus
##  5      71450.       4.85 cervidae dama       dama       
##  6      62823.       4.80 cervidae axis       axis       
##  7      53864.       4.73 cervidae odocoileus hemionus   
##  8      35000.       4.54 cervidae ozotoceros bezoarticus
##  9      29450.       4.47 cervidae cervus     nippon     
## 10      24050.       4.38 cervidae capreolus  capreolus  
## 11      13500.       4.13 cervidae muntiacus  reevesi    
## 12       7500.       3.88 cervidae pudu       puda
```

```r
filter(homerange, species == "capreolus")
```

```
## # A tibble: 1 x 24
##   taxon common.name class order family genus species primarymethod N    
##   <fct> <chr>       <chr> <fct> <chr>  <chr> <chr>   <chr>         <chr>
## 1 mamm~ roe deer    mamm~ arti~ cervi~ capr~ capreo~ telemetry*    <NA> 
## # ... with 15 more variables: mean_mass_g <dbl>, log10_mass <dbl>,
## #   alternative.mass.reference <chr>, mean.hra.m2 <dbl>, log10.hra <dbl>,
## #   hra.reference <chr>, realm <chr>, thermoregulation <chr>, locomotion <chr>,
## #   trophic.guild <chr>, dimension <chr>, preymass <dbl>, log10.preymass <dbl>,
## #   PPMR <dbl>, prey.size.reference <chr>
```
The largest deer is capreolus, and it's common name is Roe Deer.

**10. As measured by the data, which snake species has the smallest homerange? Show all of your work, please. Look this species up online and tell me about it!** **Snake is found in taxon column** 

```r
snake <- filter(homerange, taxon == "snakes")
snake
```

```
## # A tibble: 41 x 24
##    taxon common.name class order family genus species primarymethod N    
##    <fct> <chr>       <chr> <fct> <chr>  <chr> <chr>   <chr>         <chr>
##  1 snak~ western wo~ rept~ squa~ colub~ carp~ vermis  radiotag      1    
##  2 snak~ eastern wo~ rept~ squa~ colub~ carp~ viridis radiotag      10   
##  3 snak~ racer       rept~ squa~ colub~ colu~ constr~ telemetry     15   
##  4 snak~ yellow bel~ rept~ squa~ colub~ colu~ constr~ telemetry     12   
##  5 snak~ ringneck s~ rept~ squa~ colub~ diad~ puncta~ mark-recaptu~ <NA> 
##  6 snak~ eastern in~ rept~ squa~ colub~ drym~ couperi telemetry     1    
##  7 snak~ great plai~ rept~ squa~ colub~ elap~ guttat~ telemetry     12   
##  8 snak~ western ra~ rept~ squa~ colub~ elap~ obsole~ telemetry     18   
##  9 snak~ hognose sn~ rept~ squa~ colub~ hete~ platir~ telemetry     8    
## 10 snak~ European w~ rept~ squa~ colub~ hier~ viridi~ telemetry     32   
## # ... with 31 more rows, and 15 more variables: mean_mass_g <dbl>,
## #   log10_mass <dbl>, alternative.mass.reference <chr>, mean.hra.m2 <dbl>,
## #   log10.hra <dbl>, hra.reference <chr>, realm <chr>, thermoregulation <chr>,
## #   locomotion <chr>, trophic.guild <chr>, dimension <chr>, preymass <dbl>,
## #   log10.preymass <dbl>, PPMR <dbl>, prey.size.reference <chr>
```

```r
summary(snake)
```

```
##            taxon    common.name           class                       order   
##  snakes       :41   Length:41          Length:41          squamata       :41  
##  birds        : 0   Class :character   Class :character   accipitriformes: 0  
##  lake fishes  : 0   Mode  :character   Mode  :character   afrosoricida   : 0  
##  lizards      : 0                                         anguilliformes : 0  
##  mammals      : 0                                         anseriformes   : 0  
##  marine fishes: 0                                         apterygiformes : 0  
##  (Other)      : 0                                         (Other)        : 0  
##     family             genus             species          primarymethod     
##  Length:41          Length:41          Length:41          Length:41         
##  Class :character   Class :character   Class :character   Class :character  
##  Mode  :character   Mode  :character   Mode  :character   Mode  :character  
##                                                                             
##                                                                             
##                                                                             
##                                                                             
##       N              mean_mass_g        log10_mass    
##  Length:41          Min.   :   3.46   Min.   :0.5391  
##  Class :character   1st Qu.: 106.70   1st Qu.:2.0282  
##  Mode  :character   Median : 234.10   Median :2.3694  
##                     Mean   : 303.62   Mean   :2.2261  
##                     3rd Qu.: 375.00   3rd Qu.:2.5740  
##                     Max.   :1226.85   Max.   :3.0888  
##                                                       
##  alternative.mass.reference  mean.hra.m2        log10.hra    
##  Length:41                  Min.   :    200   Min.   :2.301  
##  Class :character           1st Qu.:  22900   1st Qu.:4.360  
##  Mode  :character           Median :  77400   Median :4.889  
##                             Mean   : 258416   Mean   :4.715  
##                             3rd Qu.: 240400   3rd Qu.:5.381  
##                             Max.   :2579600   Max.   :6.412  
##                                                              
##  hra.reference         realm           thermoregulation    locomotion       
##  Length:41          Length:41          Length:41          Length:41         
##  Class :character   Class :character   Class :character   Class :character  
##  Mode  :character   Mode  :character   Mode  :character   Mode  :character  
##                                                                             
##                                                                             
##                                                                             
##                                                                             
##  trophic.guild       dimension            preymass       log10.preymass  
##  Length:41          Length:41          Min.   :   8.97   Min.   :0.9528  
##  Class :character   Class :character   1st Qu.:  27.39   1st Qu.:1.3783  
##  Mode  :character   Mode  :character   Median :  51.93   Median :1.7154  
##                                        Mean   : 272.72   Mean   :1.8180  
##                                        3rd Qu.: 129.14   3rd Qu.:2.0978  
##                                        Max.   :2684.21   Max.   :3.4288  
##                                        NA's   :26        NA's   :26      
##       PPMR        prey.size.reference
##  Min.   : 0.380   Length:41          
##  1st Qu.: 3.155   Class :character   
##  Median : 5.740   Mode  :character   
##  Mean   : 8.283                      
##  3rd Qu.:12.460                      
##  Max.   :25.000                      
##  NA's   :26
```

```r
smallestsnake <- filter(snake, mean.hra.m2 == 200.00)
smallestsnake
```

```
## # A tibble: 1 x 24
##   taxon common.name class order family genus species primarymethod N    
##   <fct> <chr>       <chr> <fct> <chr>  <chr> <chr>   <chr>         <chr>
## 1 snak~ namaqua dw~ rept~ squa~ viper~ bitis schnei~ telemetry     11   
## # ... with 15 more variables: mean_mass_g <dbl>, log10_mass <dbl>,
## #   alternative.mass.reference <chr>, mean.hra.m2 <dbl>, log10.hra <dbl>,
## #   hra.reference <chr>, realm <chr>, thermoregulation <chr>, locomotion <chr>,
## #   trophic.guild <chr>, dimension <chr>, preymass <dbl>, log10.preymass <dbl>,
## #   PPMR <dbl>, prey.size.reference <chr>
```

The smallest snake is the schneideri and it's common name is Namaqua Dwarf Adder. It is a venomous snake that lives in the coastal dunes between Namibia and South Africa. Due to it's incredibly small size, this species suffers from high mortality rates. 

## Push your final code to GitHub!
Please be sure that you check the `keep md` file in the knit preferences.   
