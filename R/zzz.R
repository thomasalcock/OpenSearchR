.onAttach <- function(libname, pkgname) {
  packageStartupMessage("OpenSearchR version: ", packageVersion("OpenSearchR"))
  httr::set_config(
    httr::config(
      ssl_verifypeer = 0L,
      ssl_verifyhost = 0L
    )
  )
  packageStartupMessage("Disabled ssl_verifypeer and ssl_verifyhost config in httr for development.\n",
                        "Do not use these settings in production!")
}
