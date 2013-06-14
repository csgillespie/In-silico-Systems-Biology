require(issb)
require(ggplot2)
theme_set(theme_bw(base_size = 11))


#We want the following percentiles
stats = c(0.025, 0.25, 0.5, 0.75, 0.975)

##This assumes you have already simulated from the model
##and saved the data. See code at bottom.

##Gillespie
load("data_dd1.RData")
quarts = tapply(dd1[,3], dd1[,2], quantile, stats)
dd = Reduce("rbind", quarts)
dd = as.data.frame(dd[1:nrow(dd),])
colnames(dd) = paste("Q", 1:ncol(dd), sep="")
dd$Time = unique(dd1$Time)
dd$Simulator = "Gillespie"
rm(dd1)

##CLE
load("data_dd2.RData")
quarts = tapply(dd2[,3], dd2[,2], quantile, stats)
dd_t = Reduce("rbind", quarts)
dd_t = as.data.frame(dd_t[1:nrow(dd_t),])
colnames(dd_t) = paste("Q", 1:ncol(dd_t), sep="")
dd_t$Time = unique(dd2$Time)
dd_t$Simulator = "CLE"
rm(dd2)

dd = rbind(dd, dd_t)
##LNA 1
load("data_dd3.RData")
quarts = tapply(dd3[,3], dd3[,2], quantile, stats)
dd_t = Reduce("rbind", quarts)
dd_t = as.data.frame(dd_t[1:nrow(dd_t),])
colnames(dd_t) = paste("Q", 1:ncol(dd_t), sep="")
dd_t$Time = unique(dd3$Time)
dd_t$Simulator = "LNA 1"
rm(dd3)
dd = rbind(dd, dd_t)


##LNA 2
load("data_dd4.RData")
quarts = tapply(dd4[,3], dd4[,2], quantile, stats)
dd_t = Reduce("rbind", quarts)
dd_t = as.data.frame(dd_t[1:nrow(dd_t),])
colnames(dd_t) = paste("Q", 1:ncol(dd_t), sep="")
dd_t$Time = unique(dd4$Time)
dd_t$Simulator = "LNA 2"
rm(dd4)
dd = rbind(dd, dd_t)


##Construct the plot
dd$Simulator = factor(dd$Simulator,
  labels=c("Gillespie", "CLE", "LNA Method 1", "LNA Method 2"),
  levels=c("Gillespie","CLE",  "LNA 1", "LNA 2"))

g =  ggplot(dd, aes(Time))
g = g +
  geom_ribbon(aes(ymin=Q1, ymax=Q5), fill="grey70",alpha=0.4) +
  geom_ribbon(aes(ymin=Q2, ymax=Q4), fill="grey60",alpha=0.4) +
  geom_line(aes(y=Q3)) + facet_wrap( ~Simulator, ncol=2) +
  ylab("Prey Population")
g


pdf("../graphics/figure2.pdf", width=6,height=4.5)
print(g)
dev.off()
#####################################################
##Need to use cairo for transparent postscript files#
#####################################################
# library(grDevices)
# cairo_ps("../graphics/figure2.eps", width=6,height=4.5)
# print(g)
# dev.off()

# N = 1000
# dd1a = dd1[dd1$no_sim < N,]
# ggplot(data=dd1a,aes(Time, V2))  + 
#     geom_line(aes(group=no_sim), alpha=I(1/sqrt(N))) + 
#     theme_bw() + ylim(c(0, 750))




###################################
###################################
###################################
#The following code runs 10000 simulations using each of the simulators
#This can take a while!
#The function sim_summary_stats runs in parallel.
#Use the no_cores option to specify the no_cores you want to use
require(issb)
demo(lv, ask=FALSE)

##tstep controls the output of the simulator, not the ODE timestep.
maxtime = 50
tstep = 0.05
##Change to something appropriate
no_sims = 1000

##Gillespie
set.seed(1)
dd1 = as.data.frame(
    multiple_sims(model, maxtime, tstep, no_sims, no_cores=2, gillespie))
dd1$type = "Gillespie"
save(dd1, file="data_dd1.RData")
rm(dd1)

##Diffusion
dd2 = as.data.frame(
    multiple_sims(model, maxtime, tstep, no_sims, no_cores=3, diffusion, ddt=0.01))
dd2$type = "CLE"
save( dd2, file="data_dd2.RData")
rm(dd2)


##LNA 1
dd3 = as.data.frame(
    multiple_sims(model, maxtime,  tstep, no_sims, no_cores=3, lna, ddt=0.05))
dd3$type = "LNA 1"
save(dd3, file="data_dd3.RData")
rm(dd3)

##LNA 2
dd4 = as.data.frame(
    multiple_sims(model, maxtime,  tstep, no_sims, no_cores=3, lna, ddt=0.05, restart=TRUE))
dd4$type = "LNA 2"
save(dd4, file="data_dd4.RData")
rm(dd4)