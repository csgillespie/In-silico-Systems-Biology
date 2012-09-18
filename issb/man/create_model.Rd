\name{create_model}
\alias{create_model}
\title{A mechanism for creating a stochastic kinetic model (skm)}
\usage{
  create_model(stoic, hazards, initial, pars,
    jacobian = NULL)
}
\arguments{
  \item{stoic}{the stoichiometric of the skm model. The
  number of rows should equal the number of species and the
  number of columns should equal the number of reactions.}

  \item{hazards}{a function for calculating the hazards.}

  \item{initial}{a vector containing the initial conditions
  of the model.}

  \item{pars}{a vector containing the parameter vector}

  \item{jacobian}{only needed when simulating from the
  linear noise approximation}
}
\value{
  A list with class skm
}
\description{
  A mechanism for creating a stochastic kinetic model (skm)
}
\examples{
demo(lv)
}
\author{
  Colin Gillespie
}
\keyword{character}

