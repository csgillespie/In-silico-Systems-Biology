\name{discretise}
\alias{discretise}
\title{Discretises simulator output}
\usage{
  discretise(dd, tstep)
}
\arguments{
  \item{dd}{a dataframe/matrix containing simulator output.
  The first column should be the simulation time}

  \item{tstep}{output time stel}
}
\value{
  A matrix with the same number of columns as dd,
  discretised at time points: 0, tstep, 2tstep, ...
}
\description{
  Discretises simulator output
}
\examples{
set.seed(1)
dd = data.frame(time = c(0, sort(runif(9))),  y=rpois(10, 2))
discretise(dd, 0.1)
}
\author{
  Colin Gillespie
}
\keyword{character}

