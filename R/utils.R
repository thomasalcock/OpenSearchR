#' Convert integer to character
#'
#' This function converts an integer value to a string for the OpenSearch API.
#' Certain URL parameters like timeout values require units of time, i.e. "30s".
#'
#' @param int `integer`, value to be converted
#' @param unit `character`, unit of time
#' @return `character`, the integer as a converted string
convert_int_to_str <- function(int, unit = "s") {
  paste0(int, unit)
}

#' Convert logical to character
#'
#' This function converts an logical value to a string for the OpenSearch API.
#' Certain URL parameters like require boolean values to be specied as strings
#' i.e. "false" instead of `FALSE`.
#'
#' @param lgl `logical`, value to be converted
#' @return `character`, the logical as a converted string
convert_lgl_to_str <- function(lgl) {
  ifelse(lgl, "true", "false")
}

#' Get the content from a `response` object
#'
#' Tries to access the response content, throws a user-friendly
#' error if something went wrong, i.e. if the response body is empty.
#'
#' @param response `response`, API response
#' @return `list`, response content
#' @importFrom httr content
process_response <- function(response) {
  tryCatch({
    httr::content(response)
  },
  error = function(e) {
    stop("The response could not be processed")
  })
}

#' Get status code
#'
#' Returns the status code of an API response
#'
#' @param response `response`, API response
#' @return `integer`, status code
#' @importFrom httr status_code
show_status_code <- function(response) {
  sc <- httr::status_code(response)
  message("Response returned with status code: ", sc)
  invisible(sc)
}
