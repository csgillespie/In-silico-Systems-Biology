mrefun = function(t, z,  model)
{
    s = model$get_stoic()
    haz = model$get_haz
  return(list(as.vector(s %*% haz(z))))
}

#' @title Calculates the deterministic solution of a skm
#' @param model a skm object, created using the create_model function
#' @param maxtime the maximum simulation time
#' @param dt the output grid size. Note this doesn't (really) affect the underlying ODE solver
#' @author Colin Gillespie
#' @return A matix. The first column contains the simulation time, the other columns contain the species 
#' levels
#' @seealso create_model
#' @keywords character
#' @export
#' @example ../examples/lv.R
#' @example ../examples/deterministic.R
deterministic = function(model, maxtime, dt=0.01)
{
  grid = seq(0, maxtime, dt)	
  sol = ode(model$get_initial(), func=mrefun, times=grid, model)
  colnames(sol) = c("Time", rownames(model$get_stoic()))
  return(sol)
}

