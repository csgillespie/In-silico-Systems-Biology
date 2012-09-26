\name{gillespie}
\alias{gillespie}
\title{Stochastic simulation using the standard Gillespie algorithm}
\usage{
  gillespie(model, maxtime)
}
\arguments{
  \item{model}{a skm object, created using the create_model
  function}

  \item{maxtime}{the maximum simulation time}
}
\value{
  A matrix. The first column contains the simulation time,
  the other columns contain the species levels
}
\description{
  Stochastic simulation using the standard Gillespie
  algorithm
}
\examples{
demo(lv)
gillespie(model, 10)
}
\author{
  Colin Gillespie
}
\keyword{character}

