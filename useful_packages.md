# Useful packages
*Note:* A list of all `R` CRAN packages grouped according to their functionality can be found on the [CRAN task view page](https://cran.r-project.org/web/views/).
## Machine Learning
### 1. Modelling with `Caret`
*Install and run*    
`install.packages("caret", dependencies = c("Depends", "Suggests"))`  
`library('caret')`

*Documentation*  
Find tutorials [here](https://www.analyticsvidhya.com/blog/2016/12/practical-guide-to-implement-machine-learning-with-caret-package-in-r-with-practice-problem/), [here](http://topepo.github.io/caret/index.html), and [here](https://cran.r-project.org/web/packages/caret/vignettes/caret.html).


### 2. Text mining with `Quanteda`
*Install and run*  
`install.packages('quanteda')`  
`library('quanteda')`

*Documentation*   
Find a tutorial [here](https://quanteda.io/articles/pkgdown/quickstart.html)

## Mapping
### 1. Leaflet
*Install and run*  
`install.packages('leaflet')`  
`library('leaflet')`

*Documentation*  
`help(package = 'leaflet')` 


## LaTeX in R
### 1. latex2exp
`library(latex2exp)` 

*Documentation*  
help(package = 'latex2exp')  
latex2exp_examples()  
*Note:* Currently, the only function is `TeX('latex expression in math environment and two backslashes\\')` 

