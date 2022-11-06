#' Delete index
#'
#' This function deletes an index on OpenSearch. If the index does not exist
#' the function returns an error.
#'
#' @param conn `OpenSearchRConnection`, a connection object
#' @param index `character`, the name of the index
#'
#' @return `list`, the content of the API response
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
  process_response(response)
}
