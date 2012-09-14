source("discretise.R")
library(parallel)

simulate = function(initial, pars, maxtime,
  tstep, no_sims, simulator,  ...) {

  ##Quick check for number of columns
  sim = discretise(simulator(initial, pars, maxtime, ...), tstep)
  nc = ncol(sim)-1
  nr = nrow(sim)
  simulations = matrix(0, ncol=nc, nrow=nr*no_sims)
  simulations[1:nr,] = sim[,2:nc]
  if(no_sims == 1) return(simulations)
  
  for(i in 2:no_sims) {
     sim = discretise(simulator(initial, pars, maxtime, ...), tstep)[,2:nc]
     rows = ((i-1)*nr+1):(i*nr)
     simulations[rows,] = sim
   }
  return(simulations)
}


sim_summary_stats = function(initial, pars, maxtime,
  tstep, no_sims,no_cores, simulator, ...) {

  s_per_core = ceiling(no_sims/no_cores)
  no_sims = s_per_core*no_cores
  message("Running ", no_sims, " simulations\n")
  ##Not sure what methods=FALSE means!!!
  cl = makeCluster(no_cores, methods = FALSE)

  ##Not nice - export everything!
  clusterExport(cl,ls(envir = .GlobalEnv),.GlobalEnv)
  clusterExport(cl,ls(), environment())

  l = clusterCall(cl, simulate,
    initial, pars, maxtime,
    tstep, s_per_core, simulator, ...)
  stopCluster(cl)
  l = Reduce("rbind", l)
  times = seq(0, maxtime, by=tstep)
  m_sim = cbind(Time = times, l)
  return(m_sim)
}

