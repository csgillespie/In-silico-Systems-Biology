In-silico-Systems-Biology
=========================

This repository contains the latex source, graphics and R code used in book chapter in "In silico Systems Biology:  A systems-based approach to understanding biological processes" published by Humana Press. This book is part of the `Methods in Molecular Biology` series. The authors of this chapter are [Andrew Golightly](http://www.mas.ncl.ac.uk/~nag48/) and [Colin Gillespie](http://www.mas.ncl.ac.uk/~ncsg3/). 

You can download a [pdf](https://github.com/csgillespie/In-silico-Systems-Biology/blob/master/latex/sskm.pdf) of the book chapter, or the latex source code.

Latex code
----------

The latex code should compile using either *latex* or *pdflatex*. The two figures needed for compilation are found in the graphics directory. The graphics directory contains both *eps* and *pdf* graphic files. The graphics directory also contains specific R code for generating the figures.


R code
----------

The R code used for the simulations in this chapter is found in the *issb* directory. The code is not meant for *industrial style* stochastic simulation. Rather, it is used to illustrate algorithms described in the chapter. The code has been placed into a simple R package, *issb*.

To install the associated R code, use the *install.packages* command:

```{r}
install.packages("issb", contriburl = "http://www.mas.ncl.ac.uk/~ncsg3/R")
```

This should download and install *issb*. The package can be loaded using the library command:
```{r}
library(issb)
```

### The skm model object

The simulation methods available within the *issb* package, take a *skm* model as input. A *skm* object requires a hazards function, an initial state vector, a parameter vector, a stoichiometry matrix and (an optional) Jacobian function.

#### The Lotka-Volterra system

This system has three reactions and two species. The associated hazards are:
```{r}
h = function(x, pars) {
   hazs = numeric(length(pars))
   hazs[1] = pars[1]*x[1]
   hazs[2] = pars[2]*x[1]*x[2]
   hazs[3] = pars[3]*x[2]
   return(hazs)
}
```
and stoichiometry matrix

```{r}
smat = matrix(0,nrow=2,ncol=3)
smat[1,1] = 1; smat[1,2] = -1
smat[2,2] = 1; smat[2,3] = -1
rownames(smat) = c("Prey", "Predator")
```
For initial conditions, the predator and prey will each have a population of 100 individuals
```{r}
initial = c(100, 100)
```
The parameter values are
```{r}
pars = c(0.5,0.0025,0.3)
```
We can now create a *skm* model object:

```{r}
model = create_model(smat, h, initial, pars)
```
#### Linear noise approximation

If we run the linear noise approximation, then we need specify the Jacobian:

```{r}
f = get_f = function(x, pars)
{
   fmat = matrix(0, nrow=3, ncol=2)
   fmat[1,1] = pars[1]
   fmat[2,1] = pars[2]*x[2]
   fmat[2,2] = pars[2]*x[1]
   fmat[3,2] = pars[3]
   return(fmat)
}
model = create_model(smat, h, initial, pars, f)
```

### The simulators

The *issb* package has the following available simulators:
 * **deterministic**: the ODE solutions;
 * **gillespie**: standard SSA;
 * **pleap**: a simple tau-leap method;
 * **lna**: linear noise approximation;
 * **lna** with restart: the linear noise approximation that restarts at each delta t.

Example functions calls:
```{r}
g = gillespie(model, maxtime=50)
d = deterministic(model, maxtime=50)
pl = pleap(model, maxtime=50, ddt=0.1)
l1 = lna(model, maxtime=50, ddt=0.1)
l2 = lna(model, maxtime=50, ddt=0.1, TRUE)
```
Each of the simulators returns a matrix, where the first column is time:
```{r}
#Plot the prey
plot(g[,1], g[,2], type="l")
```

The figure below shows a single stochastic realisation of the Lotka-Volterra system using Gillespie's direct method and the deterministic solution.
![A single stochastic realisation of the Lotka-Volterra system using     Gillespie's direct method and the deterministic solution.](https://raw.github.com/csgillespie/In-silico-Systems-Biology/master/latex/graphics/stoc.png)


#### Parallel simulations

The *issb* package also contains the a function that allows multiple stochastic simulations to be run in parallel. The following piece of code, runs the gillespie simulator using two CPU cores. The *tstep* specifies the output time step used.

```{r}
multiple_sims(model, maxtime=5, tstep=1, 
    no_sims=4, no_cores=2, gillespie)
```

The figure below compares the Gillespie simulation with the diffusion and linear noise approximations for the Lotka-Volterra model. The R code can be found in the *latex/graphics/* directory.

![Comparsion of the Gillespie simulation with the diffusion and linear noise approximations.](https://raw.github.com/csgillespie/In-silico-Systems-Biology/master/latex/graphics/comparison.png)
