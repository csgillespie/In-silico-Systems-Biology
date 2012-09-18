\name{deterministic}
\alias{deterministic}
\title{Calculates the deterministic solution of a skm}
\usage{
  deterministic(model, maxtime, dt = 0.01)
}
\arguments{
  \item{model}{a skm object, created using the create_model
  function}

  \item{maxtime}{the maximum simulation time}

  \item{dt}{the output grid size. Note this doesn't
  (really) affect the underlying ODE solver}
}
\value{
  A matix. The first column contains the simulation time,
  the other columns contain the species levels
}
\description{
  Calculates the deterministic solution of a skm
}
\examples{
#The Lokta-Volterra model
#A hazard function
h = function(x, pars) {
    hazs = numeric(length(pars))
    hazs[1] = pars[1]*x[1]
    hazs[2] = pars[2]*x[1]*x[2]
    hazs[3] = pars[3]*x[2]
    return(hazs)
}
#The stoichiometric matrix
smat = matrix(0,nrow=2,ncol=3)
smat[1,1] = 1
smat[1,2] = -1
smat[2,2] = 1
smat[2,3] = -1
rownames(smat) = c("Prey", "Predator")
#Build the model
initial = c(100, 100)
pars = c(0.5,0.0025,0.3)
m = create_model(smat, hars, initial, pars)


}
\author{
  Colin Gillespie
}
\seealso{
  create_model
}
\keyword{character}

