\name{pleap}
\alias{pleap}
\title{A simple poisson leap method}
\usage{
  pleap(model, maxtime, ddt)
}
\arguments{
  \item{ddt}{the timestep.}

  \item{model}{a skm object, created using the create_model
  function}

  \item{maxtime}{the maximum simulation time}
}
\value{
  A matrix. The first column contains the simulation time,
  the other columns contain the species levels
}
\description{
  A simple poisson leap method
}
\examples{
demo(lv)
pleap(model, 10, 0.1)
}
\author{
  Colin Gillespie
}
\keyword{character}

