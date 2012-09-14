In-silico-Systems-Biology
=========================

The latex and R code used in book chapter in "In silico Systems Biology:  A systems-based approach to understanding biological processes" published by Humana Press. This book is part of the `Methods in Molecular Biology` series. The authors of this chapter are [Andrew Golightly](http://www.mas.ncl.ac.uk/~nag48/) and [Colin Gillespie](http://www.mas.ncl.ac.uk/~ncsg3/)

### Latex code

The latex code should compile using either *latex* or *pdflatex*. The figures are found in the graphics directory as both eps and pdf files.

### R code

The R code used in this chapter is found in the R directory. The code is not meant for *industrial style* stochastic simulation. Rather, it is used to illustrate algorithms described in the chapter. The **R** directory contains the following files:
 * gillespie.R, pleap.R, deterministic.R, diffusion.R, lna.R: These files contain the simulator algorithms. 
 *  LV.R: the model specification used in by the simulators
 *  examples.R: Example simulator function calls
 *  graphics1.R and graphics2.R: code used to construct the figures in the paper
 *  sim_summary.R: A function that can uses Rs parallel capabilities to simulate multiple instances.

