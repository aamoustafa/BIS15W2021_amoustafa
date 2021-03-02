---
title: "Lab 13 Homework"
author: "Please Add Your Name Here"
date: "2021-03-01"
output:
  html_document: 
    theme: spacelab
    keep_md: yes
---



## Instructions
Answer the following questions and complete the exercises in RMarkdown. Please embed all of your code and push your final work to your repository. Your final lab report should be organized, clean, and run free from errors. Remember, you must remove the `#` for the included code chunks to run. Be sure to add your name to the author header above. For any included plots, make sure they are clearly labeled. You are free to use any plot type that you feel best communicates the results of your analysis.  

Make sure to use the formatting conventions of RMarkdown to make your report neat and clean!  

## Libraries

```r
if (!require("tidyverse")) install.packages('tidyverse')
```

```
## Loading required package: tidyverse
```

```
## -- Attaching packages --------------------------------------- tidyverse 1.3.0 --
```

```
## v ggplot2 3.3.3     v purrr   0.3.4
## v tibble  3.0.6     v dplyr   1.0.4
## v tidyr   1.1.2     v stringr 1.4.0
## v readr   1.4.0     v forcats 0.5.1
```

```
## -- Conflicts ------------------------------------------ tidyverse_conflicts() --
## x dplyr::filter() masks stats::filter()
## x dplyr::lag()    masks stats::lag()
```


```r
library(tidyverse)
library(shiny)
library(shinydashboard)
library(janitor)
library(naniar)
```

## Data
The data for this assignment come from the [University of California Information Center](https://www.universityofcalifornia.edu/infocenter). Admissions data were collected for the years 2010-2019 for each UC campus. Admissions are broken down into three categories: applications, admits, and enrollees. The number of individuals in each category are presented by demographic.  

```r
uc_admit <- readr::read_csv("data/UC_admit.csv")
```

```
## 
## -- Column specification --------------------------------------------------------
## cols(
##   Campus = col_character(),
##   Academic_Yr = col_double(),
##   Category = col_character(),
##   Ethnicity = col_character(),
##   `Perc FR` = col_character(),
##   FilteredCountFR = col_double()
## )
```

**1. Use the function(s) of your choice to get an idea of the overall structure of the data frame, including its dimensions, column names, variable classes, etc. As part of this, determine if there are NA's and how they are treated.**  


```r
head(uc_admit)
```

```
## # A tibble: 6 x 6
##   Campus Academic_Yr Category   Ethnicity       `Perc FR` FilteredCountFR
##   <chr>        <dbl> <chr>      <chr>           <chr>               <dbl>
## 1 Davis         2019 Applicants International   21.16%              16522
## 2 Davis         2019 Applicants Unknown         2.51%                1959
## 3 Davis         2019 Applicants White           18.39%              14360
## 4 Davis         2019 Applicants Asian           30.76%              24024
## 5 Davis         2019 Applicants Chicano/Latino  22.44%              17526
## 6 Davis         2019 Applicants American Indian 0.35%                 277
```


```r
uc_admit <- clean_names(uc_admit)
```


```r
uc_admit %>%
  miss_var_summary()
```

```
## # A tibble: 6 x 3
##   variable          n_miss pct_miss
##   <chr>              <int>    <dbl>
## 1 perc_fr                1   0.0463
## 2 filtered_count_fr      1   0.0463
## 3 campus                 0   0     
## 4 academic_yr            0   0     
## 5 category               0   0     
## 6 ethnicity              0   0
```


```r
names(uc_admit)
```

```
## [1] "campus"            "academic_yr"       "category"         
## [4] "ethnicity"         "perc_fr"           "filtered_count_fr"
```


```r
glimpse(uc_admit)
```

```
## Rows: 2,160
## Columns: 6
## $ campus            <chr> "Davis", "Davis", "Davis", "Davis", "Davis", "Davis"~
## $ academic_yr       <dbl> 2019, 2019, 2019, 2019, 2019, 2019, 2019, 2019, 2018~
## $ category          <chr> "Applicants", "Applicants", "Applicants", "Applicant~
## $ ethnicity         <chr> "International", "Unknown", "White", "Asian", "Chica~
## $ perc_fr           <chr> "21.16%", "2.51%", "18.39%", "30.76%", "22.44%", "0.~
## $ filtered_count_fr <dbl> 16522, 1959, 14360, 24024, 17526, 277, 3425, 78093, ~
```


```r
summary(uc_admit)
```

```
##     campus           academic_yr     category          ethnicity        
##  Length:2160        Min.   :2010   Length:2160        Length:2160       
##  Class :character   1st Qu.:2012   Class :character   Class :character  
##  Mode  :character   Median :2014   Mode  :character   Mode  :character  
##                     Mean   :2014                                        
##                     3rd Qu.:2017                                        
##                     Max.   :2019                                        
##                                                                         
##    perc_fr          filtered_count_fr 
##  Length:2160        Min.   :     1.0  
##  Class :character   1st Qu.:   447.5  
##  Mode  :character   Median :  1837.0  
##                     Mean   :  7142.6  
##                     3rd Qu.:  6899.5  
##                     Max.   :113755.0  
##                     NA's   :1
```


```r
options(scipen=999)
```


**2. The president of UC has asked you to build a shiny app that shows admissions by ethnicity across all UC campuses. Your app should allow users to explore year, campus, and admit category as interactive variables. Use shiny dashboard and try to incorporate the aesthetics you have learned in ggplot to make the app neat and clean.**


```r
ui <- dashboardPage(
  dashboardHeader(title = "UC Admissions By Ethnicity"),
  dashboardSidebar(disable=T),
  dashboardBody(
  fluidRow(
  box(title = "Plot Options", width = 3,
  selectInput("x", "Select Variable", choices=c("campus", "academic_yr", "category"), 
              selected="campus"),
      hr(),
      helpText("Reference: University of California Information Center @https://www.universityofcalifornia.edu/infocenter")
  ),
  box(title = "Ethnicity", width=6,
  plotOutput("plot", width="600px", height="500px")
  ) 
  )
  ) 
) 
server <- function(input, output, session) { 
  
  output$plot <- renderPlot({
  uc_admit %>% 
  ggplot(aes_string(x=input$x, y="filtered_count_fr", fill="ethnicity")) +
  geom_col()+
  theme_light(base_size=18)+
  labs(x="Ethnicity", y="Admissions") +
  theme(axis.text.x=element_text(angle=60, hjust=1))
  })
  
  session$onSessionEnded(stopApp)
  }
shinyApp(ui, server)
```

`<div style="width: 100% ; height: 400px ; text-align: center; box-sizing: border-box; -moz-box-sizing: border-box; -webkit-box-sizing: border-box;" class="muted well">Shiny applications not supported in static R Markdown documents</div>`{=html}

**3. Make alternate version of your app above by tracking enrollment at a campus over all of the represented years while allowing users to interact with campus, category, and ethnicity.**


```r
ui <- dashboardPage(
  dashboardHeader(title="UC Enrollment"),
  dashboardSidebar(disable=T),
  dashboardBody(
  fluidRow(
  box(title="Plot Options", width = 3,
  selectInput("x", "Select Fill Variable", choices=c("category", "ethnicity", "campus"), 
              selected="category"),
      hr(),
      helpText("Reference: University of California Information Center @https://www.universityofcalifornia.edu/infocenter")
  ),
  box(title="UC Enrollment", width=6,
  plotOutput("plot", width="600px", height="500px")
  ) 
  )
  ) 
) 
server <- function(input, output, session) { 
  
  output$plot <- renderPlot({
  uc_admit %>%
  ggplot(aes_string(x="academic_yr", y="filtered_count_fr", fill=input$x)) +
      geom_col() + 
      theme_light(base_size=18) +
      labs(x="Year", y="Admissions") +
      theme(axis.text.x=element_text(angle=60, hjust=1))
  })
  
  session$onSessionEnded(stopApp)
  }
shinyApp(ui, server)
```

`<div style="width: 100% ; height: 400px ; text-align: center; box-sizing: border-box; -moz-box-sizing: border-box; -webkit-box-sizing: border-box;" class="muted well">Shiny applications not supported in static R Markdown documents</div>`{=html}


## Push your final code to GitHub!
Please be sure that you check the `keep md` file in the knit preferences. 
