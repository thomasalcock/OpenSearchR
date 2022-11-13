#' Delete index
#'
#' This function deletes an index on OpenSearch. If the index does not exist
#' the function returns an error.
#'
#' @param conn `OpenSearchRConnection`, a connection object
#' @param index `character`, the name of the index
#' @return `list`, the content of the API response
#' @importFrom httr DELETE authenticate
#' @export
delete_index <- function(conn, index) {
  response <- httr::DELETE(
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
    message(sprintf("Index %s was successfully deleted!", index))
    return(TRUE)
  }
  else {
    stop(resp$error$reason)
  }
}
