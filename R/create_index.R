#' Create an index
#'
#' The function creates an index. If the index already exists, the function
#' will return an error.
#'
#' @param conn `OpenSearchRConnection`, a connection object
#' @param index `character`, the name of the index
#'
#' @return `integer`, the status code of the response
#' @export
#'
create_index <- function(conn, index) {
  # TODO: add url parameters as arguments
  response <- httr::PUT(
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
