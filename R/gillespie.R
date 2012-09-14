
##Gillespie's direct method
gill = function(initial, pars, maxtime)
{
  sim_time = 0; i = 1; x = initial
  N = 100000
  xmat = matrix(0, nrow=N, ncol=(length(x) + 1))
  xmat[i,] = c(sim_time, x)

  s = get_stoich()
  h = get_haz(x, pars)
  while(sim_time < maxtime && sum(h) > 0){
    sim_time = sim_time + rexp(1, sum(h))
    j = sample(length(pars), 1, prob=h)
    x = x + s[ ,j]
    i = i + 1
    xmat[i, ] = c(sim_time, x)
    h = get_haz(x, pars)
  }

  if(sim_time < maxtime) {
    xmat[i+1,] = xmat[i,]
    xmat[i+1,1] = maxtime
  } else {
    xmat[i,1] = maxtime
  }
    
  colnames(xmat) = c("Time", rownames(s))
  return(xmat[1:i,])
}	
  
