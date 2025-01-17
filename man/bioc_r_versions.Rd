% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/bioc_r_versions.R
\name{bioc_r_versions}
\alias{bioc_r_versions}
\title{Bioconductor / R versions}
\usage{
bioc_r_versions(bioc_version = NULL)
}
\arguments{
\item{bioc_version}{Version of Bioc to return info for.
Can be:
\itemize{
\item{"devel"}{Get the current development version of Bioc.}
\item{"release"}{Get the current release version of Bioc.}
\item{<numeric>}{A specific Bioc version number (e.g. \code{3.16}).}
\item{NULL}{Return info for all Bioc versions.}
}}
}
\value{
Named list of Bioc/R versions
}
\description{
Get the respective version of R for a given version of 
\href{https://bioconductor.org/}{Bioconductor}.
}
\examples{
ver <- bioc_r_versions(bioc_version="devel")
}
