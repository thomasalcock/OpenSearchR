% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/utils.R
\name{process_response}
\alias{process_response}
\title{Get the content from a `response` object}
\usage{
process_response(response)
}
\arguments{
\item{response}{`response`, API response}
}
\value{
`list`, response content
}
\description{
Tries to access the response content, throws a user-friendly
error if something went wrong, i.e. if the response body is empty.
}
