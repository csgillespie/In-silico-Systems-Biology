source("LV.R")

#Poisson leap method for Lotka Volterra

pleap <- function(x,cvec,t,ddt)  
{
 s <- getS()		    
 N <- t/ddt + 1
 v <- length(cvec)
 h <- numeric(v)
 r <- numeric(v)
 xmat <- matrix(0,nrow=N,ncol=length(x))
 xmat[1,] <- x
 for (i in 2:N){
  h <- haz(x,cvec)
  for(j in 1:v){
   r[j] <- rpois(1,h[j]*ddt)
  }
  x <- x+s%*%r
  xmat[i,] <- x
  }
 return(xmat)
}


#Examples of use
sim2 <- pleap(c(100,100),c(0.5,0.0025,0.3),50,0.01)
plot(ts(sim2,start=0,deltat=0.01))
