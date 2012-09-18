#' @title A simple poisson leap method
#' @inheritParams deterministic
#' @param ddt the timestep.
#' @author Colin Gillespie
#' @return  A matix. The first column contains the simulation time, the other columns contain the species 
#' levels
#' @keywords character
#' @export
#' @examples demo(lv)
#' pleap(m, 10)

pleap = function(model, maxtime, ddt)  
{
    s = model$get_stoic()		    
    pars = model$get_pars()
    
    N = maxtime/ddt + 1
    v = length(pars)
    xmat = matrix(0, nrow=N, ncol=length(x))
    x = model$get_initial()
    xmat[1,] = x
    for (i in 2:N){
        h = model$get_haz(x)
        x = x + s %*% rpois(v, h*ddt)
        xmat[i, ] = x
    }
    
    times = seq(0, maxtime, by=ddt)
    xmat = cbind(times, xmat)
    colnames(xmat) = c("Time", rownames(s))
    return(xmat)
}

