source("sim_summary.R")
source("LV.R")

##For simulation averages
tstep = 1
no_sims = 20

##Gillespie example
source("gillespie.R")
set.seed(1)
sim = gill(initial, pars, maxtime)
tail(sim)

par(mfrow=c(1,2))
plot(sim[,1], sim[,2], type="s", ylab="Prey")
plot(sim[,1], sim[,3],type="s", ylab="Predators")

##Work out means and variances
m = sim_summary_stats(initial, pars, maxtime, tstep, no_sims, gill)
plot(m$Time, m[,2], ylim=c(0, 500))
lines(m$Time, m[,2] + sqrt(m[,4]), col=2, lty=3)

##Diffusion example
source("diffusion.R")
set.seed(1)
sim = cle(initial, pars, maxtime, ddt=0.1)

par(mfrow=c(1, 2))
plot(sim[,1], sim[,2], type="s", ylab="Prey")
plot(sim[,1], sim[,3],type="s", ylab="Predators")

##Deterministic example
source("deterministic.R")
sol = detsol(initial, pars, maxtime, dt = 0.01)
head(sol)
par(mfrow=c(1, 3))
plot(sol[,1],sol[,2],type="l",xlab="t",ylab="Prey")
plot(sol[,1],sol[,3],type="l",xlab="t",ylab="Predators")
plot(sol[,2],sol[,3],type="l",xlab="Prey",ylab="Predators")

##LNA example
source("lna.R")
##LNA1
sol = lnasol(initial, pars, maxtime, c(0,0), diag(c(0,0)),0.01)
head(sol)
plot(ts(sol,start=0,deltat=0.01))

##LNA2
sol2 = lnasol2(initial, pars, maxtime, c(0,0), diag(c(0,0)), 0.01)
plot(ts(sol2,start=0,deltat=0.01))


