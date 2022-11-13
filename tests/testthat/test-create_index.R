test_that("creating an index works", {
  skip_if(
    cluster_status != "green",
    sprintf("cluster status should be \"green\" but is %s",
            cluster_status)
  )
  if(index_exists(conn, test_index)) {
    delete_index(conn, test_index)
  }
  expect_true(create_index(conn, test_index))
})
