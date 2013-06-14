##Libraries needed
library(issb)
library(grid)
require(reshape2)
require(ggplot2)
theme_set(theme_bw(base_size = 11))
vplayout = function(x, y) 
    viewport(layout.pos.row = x, layout.pos.col = y)

##Simulation parameters
demo(lv, ask=FALSE)
maxtime = 50

##Gillespie simulator
set.seed(1)
sim = gillespie(model, maxtime)
dd1 = as.data.frame(sim)
dd2 = melt(dd1, id = c("Time"))
colnames(dd2)[3] = "Population"
dd1$type = "Stochastic"
dd2$type = "Stochastic"

##Deterministic
dd3 = as.data.frame(deterministic(model, maxtime, tstep = 0.01))
dd4 = melt(dd3, id = c("Time"))
colnames(dd4)[3] = "Population"
dd3$type = "Deterministic"
dd4$type = "Deterministic"



#Construct plots: Left panel
df1 = rbind(dd2, dd4)
g1 = ggplot(df1, aes(Time, Population)) +
    geom_step() +
    facet_grid(type~variable) + 
    ylim(c(0, 500))
g1

#Right panel
df2 = rbind(dd1, dd3)
g2 = ggplot(df2) +
    geom_path(aes(x=Prey, y=Predator)) +
    xlim(c(0, 400)) + ylim(c(0, 500)) +
    facet_grid(type ~ .)

pdf("../graphics/figure1.pdf", width=8,height=4.5)
grid.newpage()
pushViewport(viewport(layout = grid.layout(1, 3)))
print(g1, vp = vplayout(1, 1:2))
print(g2, vp = vplayout(1, 3))
dev.off()

#####################################################
##Need to use cairo for transparent postscript files#
#####################################################
library(grDevices)
cairo_ps("../graphics/figure1.eps", width=8,height=4.5)
grid.newpage()
pushViewport(viewport(layout = grid.layout(1, 3)))
print(g1, vp = vplayout(1, 1:2))
print(g2, vp = vplayout(1, 3))
dev.off()


