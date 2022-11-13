#' Check the cluster health
#'
#' Use this function to check the health of the OpenSearch cluster.
#'
#' @param conn `OpenSearchRConnection`, a connection object
#' @param index `character`, the name of the index
#' @param expand_wildcards `character`, Expands wildcard expressions to concrete indexes.
#' Combine multiple values with commas. Supported values are
#' "all", "open", "closed", "hidden", and "none". Default is "open".
#' @param level `character` The level of detail for returned health information.
#' Supported values are "cluster", "indices", and "shards." Default is "cluster".
#' @param local `logical`, Whether to return information from the local node
#' only instead of from the cluster manager node. Default is `FALSE`
#' @param master_timeout `integer`, The amount of time to wait for a connection to the cluster manager node.
#' Default is 30 seconds.
#' @param timeout `integer`, The amount of time to wait for a response. If the timeout expires, the request fails.
#' Default is 30 seconds.
#' @param wait_for_active_shards `character`, Wait until the specified number of shards is active
#' before returning a response. all for all shards. Default is 0.
#' @param wait_for_nodes `character`, Wait for N number of nodes. Use "12" for exact match, ">12" and "<12" for range.
#' Default is "<12".
#' @param wait_for_events `character`, Wait until all currently queued events with the given priority are processed.
#' Supported values are "immediate", "urgent", "high", "normal", "low", and "languid".
#' @param wait_for_no_relocating_shards `logical`, Whether to wait until there are no relocating shards in the cluster. Default is `FALSE`
#' @param wait_for_no_initializing_shards `logical`, Whether to wait until there are no initializing shards in the cluster. Default is `FALSE`
#' @param wait_for_status `character`, Wait until the cluster health reaches the specified status or better.
#' Supported values are "green", "yellow", and "red". Default is "green".
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
  is_connection(conn)
  stopifnot("index must be NULL or a length 1 character" =
              is.null(index) || (is.character(index) && length(index) == 1))
  stopifnot("expand_wildcards must be a length 1 character" =
              is.character(expand_wildcards) && length(expand_wildcards) == 1)
  stopifnot("level must be a length 1 character" =
              is.character(level) && length(level) == 1)
  stopifnot("local must be a length 1 logical" =
              is.logical(local) && length(local) == 1)
  stopifnot("master_timeout must be a length 1 integer" =
              is.integer(master_timeout) && length(master_timeout) == 1)
  stopifnot("timeout must be a length 1 integer" =
              is.integer(timeout) && length(timeout) == 1)
  stopifnot("wait_for_active_shards must be a length 1 integer" =
              is.character(wait_for_active_shards) && length(wait_for_active_shards) == 1)
  stopifnot("wait_for_nodes must be a length 1 integer" =
              is.character(wait_for_nodes) && length(wait_for_nodes) == 1)
  stopifnot("wait_for_events must be a length 1 integer" =
              is.character(wait_for_events) && length(wait_for_events) == 1)
  stopifnot("wait_for_no_relocating_shards must be a length 1 integer" =
              is.logical(wait_for_no_relocating_shards) && length(wait_for_no_relocating_shards) == 1)
  stopifnot("wait_for_no_initializing_shards must be a length 1 integer" =
              is.logical(wait_for_no_initializing_shards) && length(wait_for_no_initializing_shards) == 1)
  stopifnot("wait_for_status must be a length 1 integer" =
              is.character(wait_for_status) && length(wait_for_status) == 1)

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
