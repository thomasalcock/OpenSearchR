
# OpenSearchR

<!-- badges: start -->
<!-- badges: end -->

OpenSearchR provides an R interface to the OpenSearch API.

## Installation

You can install the development version of OpenSearchR like so:

``` r
remotes::install_github()
```

## Start an instance of OpenSearch

```
cd docker
docker-compose up -d
```

## Use the package

OpenSearchR works with a connection object. Once instantiated, the connection is
passed to functions which wrap the [OpenSearch REST API](https://opensearch.org/docs/2.3/api-reference/index/)

``` r
library(OpenSearchR)

# Setup a connection object
conn <- create_connection("<URL to your instance>", "<port number>", "<username>", "<password>")

# check if the cluster is up and running
check_cluster_health(conn)

# create an index
create_index(conn, "myindex")

# check if the index exists
index_exists(oc, "myindex")

# write a document to the index
write_document(conn, "myindex", document = list(hello = "world"))
```

