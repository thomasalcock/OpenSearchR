#' Create a connection object
#'
#' To interact with the OpenSearch REST API, the connection details are stored in
#' an object, which is then passed to functions that use the REST API.
#'
#' @param host `character`, the host url of the OpenSearch instance
#' @param port `integer`, the port number
#' @param user `character`, the username
#' @param password `character`, the password
#'
#' @return `OpenSearchRConnection`, a connection object
#' @export
create_connection <- function(host, port, user, password) {
  stopifnot("host must be character" = is.character(host))
  stopifnot("port number must be an integer" = is.integer(port))
  stopifnot("user must be a character" = is.character(user))
  stopifnot("password must be a character" = is.character(password))
  structure(
    list(host = host,
         port = port,
         user = user,
         password = password),
    class = "OpenSearchRConnection"
  )
}


is_connection <- function(conn) {
  stopifnot(
    "conn must be an OpenSearchRConnection object" =
    inherits(conn, "OpenSearchRConnection")
  )
  stopifnot(
    "conn has an incorrect structure" =
    identical(names(conn), c("host", "port", "user", "password"))
  )
  return(TRUE)
}
