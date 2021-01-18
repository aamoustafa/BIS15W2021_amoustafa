---
title: "RMarkdown Practice"
output: 
  html_document: 
    keep_md: yes
---



###### Title Test 1

# Title Test 2

### Title Test 3

_italics_

_This is an italics test. The result should be this text in italics. Abracadabra, you are now in italics._

**bold** 

**This is a bold test. The result should be this text in bold. Shaboom Shabam, you are now in bold**


```r
3+5+3+8+2
```

```
## [1] 21
```


```r
3-2-1-4-5-1-3-4-5-5-3-2
```

```
## [1] -32
```


```r
3*8*5
```

```
## [1] 120
```


```r
5/2.4847392849392711020
```

```
## [1] 2.012284
```


This should be a line break.

This is also a line break.

And the winner of America's Got Talent is...  
Alay Adeen Moustafa


```r
#install.packages("tidyverse")
library("tidyverse")
```


```r
ggplot(mtcars, aes(x = factor(cyl))) +
    geom_bar()
```

![](RMarkdown-Practice_files/figure-html/unnamed-chunk-6-1.png)<!-- -->


