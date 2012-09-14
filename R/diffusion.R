#Diffusion approximation (CLE) 
cle = function(initial, pars, maxtime, 
{
  N = 100000
  s = get_stoich()		
  N = maxtime/ddt + 1
  xmat = matrix(0, nrow=N, ncol=length(initial))
  x = initial
  xmat[1,] = x
  sdt = sqrt(ddt)
  for (i in 2:N){
    z = rnorm(length(pars), 0, sdt)
    x = x +
      s %*% get_haz(x, pars)*ddt +
        s %*% diag(sqrt(get_haz(x, pars))) %*% z
    if(x[1]<0){x[1] = xmat[i-1, 1]}
    if(x[2]<0){x[2] = xmat[i-1, 2]}
    xmat[i,] = x
  }
  times = seq(0, maxtime, by=ddt)
  xmat = cbind(times, xmat)
  colnames(xmat) = c("Time", rownames(s))
  return(xmat)
}


