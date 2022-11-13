#' Check if index exists
#'
#' This function checks if the specified index exists. If it does not exist,
#' an error is thrown.
#'
#' @param conn `OpenSearchRConnection`, a connection object
#' @param index `character`, the name of the index
#' @return `TRUE` if the index exists
#' @importFrom httr HEAD authenticate
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
  resp <- process_response(response)
  if(response$status %in% c(200, 201)) {
    message(sprintf("Index %s exists!", index))
    return(TRUE)
  }
  else {
    message(resp$error$reason)
    return(FALSE)
  }
}
