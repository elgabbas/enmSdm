% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/interpolateRasters.r
\name{interpolateRasters}
\alias{interpolateRasters}
\title{Interpolate a stack of rasters}
\usage{
interpolateRasters(rasts, interpFrom, interpTo, type = "linear",
  na.rm = TRUE, ...)
}
\arguments{
\item{rasts}{Raster stack.}

\item{interpFrom}{Numeric vector, one value per raster in \code{rasts}. Values represent "distance" along the set of rasters rasters (e.g., time).}

\item{interpTo}{Numeric vector, values of "distances" at which to interpolate the rasters.}

\item{type}{Either \code{'linear'} or \code{'spline'}. The \code{\link[stats]{approx}} function is used for linear interpolation and \code{\link[stats]{spline}} for spline-based interpolation.}

\item{na.rm}{Logical, if \code{TRUE} (default) then ignore cases where all values in the same cells across rasters from which interpolations are made are \code{NA} (i.e., do not throw an error). If \code{FALSE}, then throw an error when this occurs.}

\item{...}{Other arguments passed to \code{\link[stats]{approx}} or \code{\link[stats]{spline}}. \emph{Do not} include any of these arguments: \code{x}, \code{y}, or \code{xout}.}
}
\value{
A raster stack, one per element in \code{interpTo}.
}
\description{
This function returns a stack of rasters interpolated from a stack of rasters. For example, the input might represent rasters of a process measured at times t, t + 1, and t + 4. The rasters at t + 2 and t + 3 could be interpolated based on the values in the other rasters.
}
\details{
This function can be very memory-intensive for large rasters.  It may speed things up (and make them possible) to do interpolations piece by piece (e.g., instead of interpolating between times t0, t1, t2, t3, ..., interpolate between t0 and t1, then t1 and t2, etc. This may give results that differ from using the entire set, however. Note that using linear and splines will often yield very similar results except that in a small number of cases splines may produce very extreme interpolated values.
}
\examples{
interpFrom <- c(1, 3, 4, 8)
interpTo <- c(2, 5, 6, 7, 8, 9)
rx <- raster(nrows=10, ncols=10)
r1 <- setValues(rx, 1:100)
r3 <- setValues(rx, 100:1)
r4 <- setValues(rx, 100:1 - 30)
r8 <- setValues(rx, c(runif(95), rep(NA, 5)))
rasts <- stack(r1, r3, r4, r8)
names(rasts) <- paste0('rasts', interpFrom)

linear <- interpolateRasters(rasts, interpFrom, interpTo)
linear <- interpolateRasters(rasts, interpFrom, interpTo, rule=2)
splines <- interpolateRasters(rasts, interpFrom, interpTo, type='spline')
plot(rasts)
x11()
plot(linear)
x11()
plot(spline)
}
\seealso{
\code{\link[raster]{approxNA}}, \code{\link[stats]{approx}}, \code{\link[stats]{spline}}
}
