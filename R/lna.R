require(deSolve)

##LNA 
rmvn = function(mean, var, n) #Samples from a multivariate Normal distn.
{
  eps = matrix(rnorm(n*dim(var)[1]), ncol=n)
  mean + (t(chol(var)) %*% eps)
}

get_f = function(z,pars)
{
  fmat = matrix(0,nrow=3,ncol=2)
  fmat[1,1] = pars[1]
  fmat[2,1] = pars[2]*z[2]
  fmat[2,2] = pars[2]*z[1]
  fmat[3,2] = pars[3]
  return(fmat)
}

lnafun = function(t,state,pars)
{
  s = get_stoich()
  u = dim(s)[1]
  z0 = state[1:u]
  m0 = state[(u+1):(2*u)]
  V0 = matrix(state[(2*u+1):length(state)],ncol=u)
  Ft = get_f(z0,pars)
  h = get_haz(z0,pars)
  z = s %*% h
  m = s %*% Ft %*% m0
  V = V0%*%t(Ft)%*%t(s)+s%*%diag(h)%*%t(s)+s%*%Ft%*%V0
  return(list(c(z,m,as.vector(V))))
}

lnastep = function(z,m=c(0,0),V=diag(c(0,0)),pars,gridt=c(0,1)) 
{
  u = length(z)
  state = c(z,m,as.vector(V))	
  sol = ode(y=state,func=lnafun,times=gridt,parms=pars)
  l =  dim(sol)[1]
  z = sol[l,2:(u+1)]
  m = sol[l,(u+2):(2*u+1)]
  V = matrix(sol[l,(2*u+2):(dim(sol)[2])],ncol=2)
  list(z,m,V)
}

##LNA method 1
lnasol = function(initial,pars, maxtime, m,V,ddt) 
{
  z = initial
  N = maxtime/ddt + 1	
  xmat = matrix(0,nrow=N,ncol=length(z))
  xmat[1,] = z
  for (i in 2:N){
    lsol = lnastep(z,m,V,pars,c(1,1+ddt))
    z = lsol[[1]]
    m = lsol[[2]]
    V = lsol[[3]]
    x = rmvn(z+m,V,1)
    if(x[1]<0){x[1] = xmat[i-1,1]}
    if(x[2]<0){x[2] = xmat[i-1,2]}
    xmat[i,] = x
    m = x-z #set m
    V = diag(rep(0,length(z))) # reset variance
  }
  xmat = cbind(seq(0, maxtime, ddt), xmat)
  colnames(xmat) = c("Time", rownames(get_stoich()))
  return(xmat)
}

##LNA method 2 -- zt restarted at xt. Inefficient as dmt/dt is integrated.
lnasol2 = function(initial, pars, maxtime, m,V,ddt) 
{
  z = initial
  N = maxtime/ddt + 1	
  xmat = matrix(0,nrow=N,ncol=length(z))
  xmat[1,] = z
  for (i in 2:N){
    lsol = lnastep(z,m,V,pars,c(1,1+ddt))
    z = lsol[[1]]
    m = lsol[[2]]
    V = lsol[[3]]
    x = rmvn(z+m,V,1)
    if(x[1]<0){x[1] = xmat[i-1,1]}
    if(x[2]<0){x[2] = xmat[i-1,2]}
    xmat[i,] = x
    z = x #restart z at x
    m = rep(0,length(z)) #reset m
    V = diag(rep(0,length(z))) # reset variance
  }
  xmat = cbind(seq(0, maxtime, ddt), xmat)
  colnames(xmat) = c("Time", rownames(get_stoich()))
  return(xmat)
}
