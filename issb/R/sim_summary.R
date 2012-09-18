simulate = function(model, maxtime,
  tstep, no_sims, simulator,  ...) {

  ##Quick check for number of columns
  sim = discretise(simulator(model, maxtime, ...), tstep)
  nc = ncol(sim)-1
  nr = nrow(sim)
  simulations = matrix(0, ncol=nc, nrow=nr*no_sims)
  simulations[1:nr,] = sim[,2:nc]
  if(no_sims == 1) return(simulations)
  
  for(i in 2:no_sims) {
     sim = discretise(simulator(model, maxtime, ...), tstep)[,2:nc]
     rows = ((i-1)*nr+1):(i*nr)
     simulations[rows,] = sim
   }
  return(simulations)
}

#' @title Multiple stochastic simulates
#' @inheritParams deterministic
#' @param no_sims the number of stochastic simulations to perform
#' @param no_cores the number of CPU cores to utilise.
#' @param simulator the stochastic simulator that will be run
#' @param ... additional parameters that will be passed to the simulator
#' @author Colin Gillespie
#' @return  A matix. The first column contains the simulation time, the other columns contain the species 
#' levels
#' @keywords character
#' @export
#' @examples demo(lv)
#' multiple_sims(model, 5, 1, 4, 2, pleap, ddt=0.5)

multiple_sims = function(model, maxtime,
  tstep, no_sims, no_cores, simulator, ...) {

  s_per_core = ceiling(no_sims/no_cores)
  no_sims = s_per_core*no_cores
  message("Running ", no_sims, " simulations\n")
  ##methods=FALSE - don't load the methods package
  cl = makeCluster(no_cores, methods = FALSE)

  ##Not nice - export everything!
  clusterExport(cl,ls(envir = .GlobalEnv),.GlobalEnv)
  clusterExport(cl,ls(), environment())

  l = clusterCall(cl, simulate,
    model, maxtime,
    tstep, s_per_core, simulator, ...)
  stopCluster(cl)
  l = Reduce("rbind", l)
  times = seq(0, maxtime, by=tstep)
  m_sim = cbind(rep(1:no_sims, each=length(times)), times, l)
  colnames(m_sim) = c("sim_no", "Time", rownames(model$get_stoic()))
  return(m_sim)
}

