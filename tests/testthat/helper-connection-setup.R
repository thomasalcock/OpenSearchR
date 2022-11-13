conn <- create_connection("https://localhost", 9200L, "admin", "admin")
cluster_status <- check_cluster_health(conn)
test_index <- "test"
