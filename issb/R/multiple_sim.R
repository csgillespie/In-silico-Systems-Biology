simulate = function(i, model, maxtime,
                    tstep, simulator, set_seed, ...) {
    if(set_seed) set.seed(i)    
    simulator(model, maxtime, ...)
    discretise(simulator(model, maxtime, ...), tstep)
}

#' @title Multiple stochastic simulation
#' @inheritParams deterministic
#' @param no_sims the number of stochastic simulations to perform
#' @param no_cores the number of CPU cores to utilise.
#' @param simulator the stochastic simulator that will be used.
#' @param ... additional parameters that will be passed to the simulator
#' @param set_seed Default \code{FALSE}. If \code{TRUE}, gives a crude way to reproduce simulation results.
#' @author Colin Gillespie
#' @return  A matrix. The first column contains the simulation time, the other columns contain the species.
#' levels
#' @keywords character
#' @export
#' @importFrom parallel makeCluster clusterEvalQ parLapply stopCluster
#' @examples demo(lv)
#' multiple_sims(model, 5, 1, 4, 2, pleap, ddt=0.5)

multiple_sims = function(model, maxtime,
                         tstep, no_sims, no_cores, simulator, set_seed=FALSE, ...) {
    
    ## Force the hazard to be evaluated
    ## Otherwise strange errors in the parallel part
    ## Parhaps lazy loading?
    model$get_haz(model$get_initial())    
    
    cl = makeCluster(no_cores)
    clusterEvalQ(cl, require(issb))
    l = parLapply(cl, 1:no_sims, simulate, model, maxtime, tstep, simulator, set_seed=set_seed, ...)
    stopCluster(cl)

    l = Reduce("rbind", l)
    times = unique(l[,1])
    m_sim = cbind(rep(1:no_sims, each=length(times)), l)
    colnames(m_sim) = c("sim_no", "Time", rownames(model$get_stoic()))
    return(m_sim)
}

