convert_int_to_str <- function(int, unit = "s") {
  paste0(int, unit)
}

convert_lgl_to_str <- function(lgl) {
  ifelse(lgl, "true", "false")
}

process_response <- function(response) {
  show_status_code(response)
  tryCatch({
    httr::content(response)
  })
}

show_status_code <- function(response) {
  sc <- httr::status_code(response)
  message("Response returned with status code: ", sc)
  invisible(sc)
}

# TODO: write function to extract error cause from api response

get_request <- function(host, port, path, user, password) {
  # may be needed to send GET requests with body, which is silently ignored by httr::GET
  h <- curl::new_handle()
  curl::handle_setopt(
    h,
    username = user,
    password = password,
    timeout = 3
  )
  curl::handle_setheaders(
    h,
    "Content-Type" = "application/json",
    "Cache-Control" = "no-cache"
  )
  target_url <- construct_url(host, port, path)
  req <- curl::curl_fetch_memory(target_url, handle = h)

  if(req$status %in% c(200L, 201L)) {
    stop("Response status code: ", req$status)
  }
  content(req)
}
