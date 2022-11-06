#' Check if index exists
#'
#' This function checks if the specified index exists, in which case the
#' status code of 200 is displayed.
#'
#' @param conn `OpenSearchRConnection`, a connection object
#' @param index `character`, the name of the index
#'
#' @return `integer` the response status code
#' @export
index_exists <- function(conn, index) {

  # TODO: add url parameters as arguments
  response <- httr::HEAD(
    url = conn$host,
    httr::authenticate(
      user = conn$user,
      password = conn$password,
      type = "basic"
    ),
    port = conn$port,
    path = index
  )
  show_status_code(response)
}
