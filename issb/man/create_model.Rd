\name{create_model}
\alias{create_model}
\title{A mechanism for creating a stochastic kinetic model (skm)}
\usage{
  create_model(stoic, hazards, initial, pars)
}
\arguments{
  \item{stoic}{the stoichiometric of the skm model. The
  number of rows should equal the number of species and the
  number of columns should equal the number of reactions.}

  \item{hazards}{a function for calculating the hazards.}

  \item{initial}{a vector containing the initial conditions
  of the model.}

  \item{pars}{a vector containing the parameter vector}
}
\value{
  A list with class skm
}
\description{
  A mechanism for creating a stochastic kinetic model (skm)
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
\keyword{character}

