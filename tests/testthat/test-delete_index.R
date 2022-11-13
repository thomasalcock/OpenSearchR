test_that("deleting an index works", {
  skip_if(
    cluster_status != "green",
    sprintf("cluster status should be \"green\" but is %s",
            cluster_status)
  )
  if(!index_exists(conn, test_index)) {
    create_index(conn, test_index)
  }
  expect_true(delete_index(conn, test_index))
})
