% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/pipeline_base_functions.R
\name{load_modis_files}
\alias{load_modis_files}
\title{Load MODIS files from a specified path.}
\usage{
load_modis_files(path, pattern = "hdf$", date = character(2))
}
\arguments{
\item{path}{The path where the MODIS files are located.}

\item{pattern}{An optional regular expression pattern to filter the files.
The default pattern is "hdf$".}

\item{date}{A vector of two dates to filter the files by.
The default is an empty character vector.}
}
\value{
A list of full file names of the MODIS files found
in the specified path.
}
\description{
This function takes a path and an optional pattern as input and
returns a list of MODIS files found in the specified path.
}
\examples{
\dontrun{
# Load MODIS files from the current directory
modis_files <- load_modis_files(".")

# Load MODIS files from a specific directory with a custom pattern
modis_files <- load_modis_files("/path/to/files", pattern = "MOD.*hdf$")
}
}
\keyword{Utility}
