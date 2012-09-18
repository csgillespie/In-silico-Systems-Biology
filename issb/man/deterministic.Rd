\name{deterministic}
\alias{deterministic}
\title{Calculates the deterministic solution of a skm}
\usage{
  deterministic(model, maxtime, tstep)
}
\arguments{
  \item{model}{a skm object, created using the create_model
  function}

  \item{maxtime}{the maximum simulation time}

  \item{tstep}{the output grid size. Note this doesn't
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
demo(lv)
deterministic(model, 10, 0.1)
}
\author{
  Colin Gillespie
}
\seealso{
  create_model
}
\keyword{character}

