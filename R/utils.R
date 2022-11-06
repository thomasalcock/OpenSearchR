#' Convert integer to character
#'
#' This function converts an integer value to a string for the OpenSearch API.
#' Certain URL parameters like timeout values require units of time, i.e. "30s".
#'
#' @param int `integer`, value to be converted
#' @param unit `character`, unit of time
#'
#' @return `character`, the integer as a converted string
#'
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
#'
#' @return `character`, the logical as a converted string
#'
convert_lgl_to_str <- function(lgl) {
  ifelse(lgl, "true", "false")
}

#' Get the content from a http response
#'
#' @param response
#'
#' @return
#'
#' @importFrom httr content
#'
#' @examples
process_response <- function(response) {
  show_status_code(response)
  tryCatch({
    httr::content(response)
  },
  error = function(e) {
    message("The response could not be processed")
  })
}

#' Title
#'
#' @param response
#'
#' @return
#' @export
#'
#' @importFrom httr status_code
#'
#' @examples
show_status_code <- function(response) {
  sc <- httr::status_code(response)
  message("Response returned with status code: ", sc)
  invisible(sc)
}

# TODO: write function to extract error cause from api response

