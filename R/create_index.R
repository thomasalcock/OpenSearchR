#' Create an index
#'
#' The function creates an index. If the index already exists, the function
#' will throw an error.
#'
#' @param conn `OpenSearchRConnection`, a connection object
#' @param index `character`, the name of the index
#' @return `logical`, TRUE if the index was created
#' @importFrom httr PUT authenticate status_code
#' @export
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
  resp <- process_response(response)
  if(response$status %in% c(200, 201)) {
    message(sprintf("Index %s was successfully created!", index))
    return(TRUE)
  }
  else {
    stop(resp$error$reason)
  }
}
