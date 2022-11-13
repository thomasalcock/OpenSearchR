#' Check if index exists
#'
#' This function checks if the specified index exists. If it does not exist,
#' an error is thrown.
#'
#' @param conn `OpenSearchRConnection`, a connection object
#' @param index `character`, the name of the index
#' @param allow_no_indices `logical`, Whether to ignore wildcards that don’t match any indices.
#' Default is `TRUE`.
#' @param expand_wildcards `character`, Expands wildcard expressions to different indices.
#' Combine multiple values with commas. Available values are:
#' \itemize{
#'    \item{"all" (match all indices)}
#'    \item{"open" (match open indices)}
#'    \item{"closed" (match closed indices)}
#'    \item{"hidden" (match hidden indices)}
#'    \item{"none" (do not accept wildcard expressions)}
#' }
#  Default is "open".
#' @param include_defaults `logical`, Whether to include default settings as part of the response.
#' This parameter is useful for identifying the names and current values of settings you want to update.
#' Default is `FALSE`
#' @param ignore_unavailable, `logical`, If `TRUE`, OpenSearch does not search for missing or closed indices.
#' Default is `FALSE`
#' @param local `logical`, Whether to return information from only the local node instead of from the master node.
#' Default is `FALSE`.
#' @return `TRUE` if the index exists
#' @importFrom httr HEAD authenticate
#' @export
index_exists <- function(conn,
                         index,
                         allow_no_indices = TRUE,
                         expand_wildcard_settings = "open",
                         include_defaults = FALSE,
                         ignore_unavailable = FALSE,
                         local = FALSE) {

  stopifnot("index must be NULL or a length 1 character" =
              is.null(index) || (is.character(index) && length(index) == 1))
  stopifnot("allow_no_indices must be a length 1 logical" =
              is.logical(allow_no_indices) && length(allow_no_indices) == 1)
  stopifnot("expand_wildcard_settings must be a length 1 character" =
              is.character(expand_wildcard_settings) && length(expand_wildcard_settings) == 1 &&
              expand_wildcard_settings %in% c("open", "all", "closed", "hidden", "none"))
  stopifnot("include_defaults must be a length 1 logical" =
              is.logical(expand_wildcard_settings) && length(expand_wildcard_settings) == 1)
  stopifnot("ignore_unavailable must be a length 1 logical" =
              is.logical(ignore_unavailable) && length(ignore_unavailable) == 1)
  stopifnot("local must be a length 1 logical" =
              is.logical(local) && length(local) == 1)

  allow_no_indices <- convert_lgl_to_str(allow_no_indices)
  include_defaults <- convert_lgl_to_str(include_defaults)
  ignore_unavailable <- convert_lgl_to_str(ignore_unavailable)
  local <- convert_lgl_to_str(local)

  response <- httr::HEAD(
    url = conn$host,
    httr::authenticate(
      user = conn$user,
      password = conn$password,
      type = "basic"
    ),
    port = conn$port,
    path = index,
    query = list(
      allow_no_indices = allow_no_indices,
      expand_wildcard_settings = expand_wildcard_settings,
      include_defaults = include_defaults,
      ignore_unavailable = ignore_unavailable,
      local = local
    )
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
