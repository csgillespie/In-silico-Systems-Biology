library(grDevices)
library(grid)
require(reshape2)
require(ggplot2)
theme_set(theme_bw(base_size = 11))
vplayout = function(x, y) 
  viewport(layout.pos.row = x, layout.pos.col = y)

##Simulation parameters
source("gillespie.R")
source("deterministic.R")
initial = c(100, 100)
pars = c(0.5,0.0025,0.3)
maxtime = 50

##Gillespie
set.seed(1)
sim = gill(initial, pars, maxtime)
dd1 = as.data.frame(sim)
dd2 =melt(dd, id = c("Time"))
colnames(dd2)[3] = "Population"

g1 = ggplot(dd2, aes(Time, Population)) +
  geom_step() +
  facet_grid(.~variable) + ylim(c(0, 500))

g2 = ggplot(dd1) +
  geom_path(aes(x=Prey, y=Predator)) +
  xlim(c(0, 400)) + ylim(c(0, 500))

dd3 = as.data.frame(detsol(initial, pars, maxtime, dt = 0.01))
dd4 = melt(dd3, id = c("Time"))
colnames(dd4)[3] = "Population"

g3 = ggplot(dd4, aes(Time, Population)) +
  geom_step() +
  facet_grid(.~variable) + ylim(c(0, 500))

g4 = ggplot(dd3) +
  geom_path(aes(x=Prey, y=Predator)) +
  xlim(c(0, 400)) + ylim(c(0, 500))

## #postscript("tmp1.eps", horizontal=FALSE, width=20,height=6)
## cairo_ps("../graphics/figure1.eps", width=9,height=4.5)
## grid.newpage()
## pushViewport(viewport(layout = grid.layout(2, 3)))
## print(g1, vp = vplayout(1, 1:2))
## print(g2, vp = vplayout(1, 3))
## print(g3, vp = vplayout(2, 1:2))
## print(g4, vp = vplayout(2, 3))
## dev.off()
###################
###################
###################

dd1$type = "Stochastic"
dd2$type = "Stochastic"
dd3$type = "Deterministic"
dd4$type = "Deterministic"
df = rbind(dd2, dd4)

g5 = ggplot(df, aes(Time, Population)) +
  geom_step() +
  facet_grid(type~variable) + ylim(c(0, 500))


df = rbind(dd1, dd3)
g6 = ggplot(df) +
  geom_path(aes(x=Prey, y=Predator)) +
  xlim(c(0, 400)) + ylim(c(0, 500)) +
  facet_grid(type ~ .)

cairo_ps("../graphics/figure1.eps", width=8,height=4.5)
#postscript("../graphics/figure1.eps", horizontal=FALSE, width=20,height=6)
grid.newpage()
pushViewport(viewport(layout = grid.layout(1, 3)))
print(g5, vp = vplayout(1, 1:2))
print(g6, vp = vplayout(1, 3))
dev.off()

pdf("../graphics/figure1.pdf", width=8,height=4.5)
#postscript("../graphics/figure1.eps", horizontal=FALSE, width=20,height=6)
grid.newpage()
pushViewport(viewport(layout = grid.layout(1, 3)))
print(g5, vp = vplayout(1, 1:2))
print(g6, vp = vplayout(1, 3))
dev.off()

