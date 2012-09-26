In-silico-Systems-Biology
=========================

This repository contains the latex source, graphics and R code used in book chapter in "In silico Systems Biology:  A systems-based approach to understanding biological processes" published by Humana Press. This book is part of the `Methods in Molecular Biology` series. The authors of this chapter are [Andrew Golightly](http://www.mas.ncl.ac.uk/~nag48/) and [Colin Gillespie](http://www.mas.ncl.ac.uk/~ncsg3/). 

### Latex code

The latex code should compile using either *latex* or *pdflatex*. The two figures needed for compilation are found in the graphics directory. The graphics directory contains both *eps* and *pdf* graphic files. The graphics directory also contains specific R code for generating the figures.

### R code

The R code used for the simulations in this chapter is found in the *issb* directory. The code is not meant for *industrial style* stochastic simulation. Rather, it is used to illustrate algorithms described in the chapter. The code has been placed into a simple R package, *issb*.

To install the associated R code, first we need to install the package

```{r}
install.packages("issb", contriburl = "http://www.mas.ncl.ac.uk/~ncsg3/R")
```

This should download and install *issb*. To simulate the Lokta-Volterra model using the Gillespie SSA, use the following commands:

```{r}
library(issb)
#Create a model object  
demo(lv)
g = gillespie(model, maxtime=50)
#Plot the prey
plot(g[,1], g[,2], type="l")
```

The belows is a comparsion of the Gillespie simulation with the approximate diffusion and linear noise approximations for the Lotka-Volterra model. The R code can be found in the *latex/graphics/* directory.

![Comparsion of the Gillespie simulation with the approximate diffusion and linear noise approximations.](https://raw.github.com/csgillespie/In-silico-Systems-Biology/master/latex/graphics/comparison.png)

