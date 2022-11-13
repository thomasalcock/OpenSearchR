test_that("checking cluster health with default args works", {
  ch <- check_cluster_health(conn)
  expect_equal(ch$status, "green")
  expect_equal(ch$timed_out, FALSE)
  expect_equal(ch$discovered_master, TRUE)
  expect_equal(ch$discovered_cluster_manager, TRUE)
  expect_equal(ch$number_of_nodes, 2)
  expect_equal(ch$number_of_data_nodes, 2)
})

test_that("checking cluster health with index works", {
  if(!index_exists(conn, test_index)) {
    create_index(conn, test_index)
  }
  ch <- check_cluster_health(conn, test_index)
  expect_equal(ch$status, "green")
  expect_equal(ch$timed_out, FALSE)
  expect_equal(ch$discovered_master, TRUE)
  expect_equal(ch$discovered_cluster_manager, TRUE)
  expect_equal(ch$number_of_nodes, 2)
  expect_equal(ch$number_of_data_nodes, 2)
  delete_index(conn, test_index)
})

test_that("checking cluster health with non-existent index times out", {
  ch <- check_cluster_health(conn, test_index, timeout = 1L, master_timeout = 1L)
  expect_equal(ch$status, "red")
  expect_equal(ch$timed_out, TRUE)
  expect_equal(ch$discovered_master, TRUE)
  expect_equal(ch$discovered_cluster_manager, TRUE)
  expect_equal(ch$number_of_nodes, 2)
  expect_equal(ch$number_of_data_nodes, 2)
})

test_that("argument checks work", {
  expect_error(check_cluster_health(list("a", "b"), test_index, timeout = 1L))
  expect_error(check_cluster_health(conn, index = 1, timeout = 1L))
  expect_error(check_cluster_health(conn, expand_wildcards = TRUE, timeout = 1L))
  expect_error(check_cluster_health(conn, level = 1, timeout = 1L))
  expect_error(check_cluster_health(conn, local = "true", timeout = 1L))
  expect_error(check_cluster_health(conn, master_timeout = "20", timeout = 1L))
  expect_error(check_cluster_health(conn, wait_for_active_shards = FALSE, timeout = 1L))
})
