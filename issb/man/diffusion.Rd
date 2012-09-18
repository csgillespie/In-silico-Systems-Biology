\name{diffusion}
\alias{diffusion}
\title{Runs the Euler-Maruyama}
\usage{
  diffusion(model, maxtime, ddt)
}
\arguments{
  \item{ddt}{the step size used in the Euler-Maruyama
  solver}

  \item{model}{a skm object, created using the create_model
  function}

  \item{maxtime}{the maximum simulation time}
}
\value{
  A matix. The first column contains the simulation time,
  the other columns contain the species levels
}
\description{
  Runs the Euler-Maruyama
}
\examples{
demo(lv)
diffusion(m, 10, 0.05)
}
\author{
  Colin Gillespie
}
\keyword{character}

