##Deterministic solution (MRE)
require(deSolve)
source("LV.R")

mrefun = function(t, z, cvec)
{
  s = get_stoich()
  return(list(as.vector(s %*% get_haz(z, cvec))))
}

detsol = function(x, cvec, maxtime, dt=0.01)
{
  grid = seq(0, maxtime, dt)	
  sol = ode(x, func=mrefun, times=grid, parms=cvec)
  colnames(sol) = c("Time", rownames(get_stoich()))
  return(sol)
}

