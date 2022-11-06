#' Check the cluster health
#'
#' Use this function to check the health of the OpenSearch cluster.
#'
#' @param conn `OpenSearchRConnection`, a connection object
#' @param index `character`, the name of the index
#' @param expand_wildcards `character`,
#' @param level `character`
#' @param local `logical`
#' @param master_timeout `integer`
#' @param timeout `integer`
#' @param wait_for_active_shards `character`
#' @param wait_for_nodes `character`
#' @param wait_for_events `character`
#' @param wait_for_no_relocating_shards `logical`
#' @param wait_for_no_initializing_shards `logical`
#' @param wait_for_status `character`
#'
#' @return `list`, the API response containing the status of the cluster
#' @importFrom httr GET authenticate
#'
#' @export
#'
check_cluster_health <- function(conn,
                                 index = NULL,
                                 expand_wildcards = "open",
                                 level = "cluster",
                                 local = FALSE,
                                 master_timeout = 30L,
                                 timeout = 30L,
                                 wait_for_active_shards = "0",
                                 wait_for_nodes = "<12",
                                 wait_for_events = "normal",
                                 wait_for_no_relocating_shards = FALSE,
                                 wait_for_no_initializing_shards = FALSE,
                                 wait_for_status = "green"
                                 ) {
  # TODO: add url parameters as arguments
  # TODO: check input args
  path <- ifelse(
    is.null(index),
    endpoints["cluster_health"],
    paste0(endpoints["cluster_health"], "/", index)
  )

  local <- convert_lgl_to_str(local)
  wait_for_no_relocating_shards <- convert_lgl_to_str(wait_for_no_relocating_shards)
  wait_for_no_initializing_shards <- convert_lgl_to_str(wait_for_no_initializing_shards)
  master_timeout <- convert_int_to_str(master_timeout)
  timeout <- convert_int_to_str(timeout)

  response <- httr::GET(
    url = conn$host,
    httr::authenticate(
      user = conn$user,
      password = conn$password,
      type = "basic"
    ),
    port = conn$port,
    path = path,
    query = list(
      index = index,
      expand_wildcards = expand_wildcards,
      level = level,
      local = local,
      master_timeout = master_timeout,
      timeout = timeout,
      wait_for_active_shards = wait_for_active_shards,
      wait_for_nodes = wait_for_nodes,
      wait_for_events = wait_for_events,
      wait_for_no_relocating_shards = wait_for_no_relocating_shards,
      wait_for_no_initializing_shards = wait_for_no_initializing_shards,
      wait_for_status = wait_for_status
    )
  )
  process_response(response)
}
