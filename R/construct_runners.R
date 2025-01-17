#' Construct runners
#' 
#' Construct runner configurations across multiple Operating Systems (OS)
#'  for GitHub Actions workflow. 
#' @param os Which OS to launch GitHub Actions on. 
#' @param bioc Which Bioconductor version to use on each OS. 
#' See \link[rworkflows]{bioc_r_versions} documentation for all options.
#' @param r Which R version to use on each OS. 
#' @param cont Which Docker container to use on each OS
#'  (\code{NULL} means no container will be used for that OS).
#'  See 
#'  \href{https://hub.docker.com/r/bioconductor/bioconductor_docker/tags}{here}
#'   for a list of all official Bioconductor Docker container versions.
#' @param rspm Which R repository manager to use on each OS
#'  (\code{NULL} means the default will be used for that OS).
#' @param versions_explicit Specify R/Bioc versions explicitly
#'  (e.g. \code{r: 4.2.0, bioc: 3.16}) 
#'  as opposed to flexibly (e.g. \code{r: "latest", bioc: "release"}).
#' @returns Named list of configurations for each runner OS.
#' 
#' @export
#' @importFrom stats setNames
#' @examples 
#' runners <- construct_runners()
construct_runners <- function(os=c("ubuntu-latest",
                                   "macOS-latest",
                                   "windows-latest"),
                              bioc = stats::setNames(
                                list("devel",
                                     "release",
                                     "release"),
                                os
                                ),
                              r = stats::setNames(
                                list("auto",
                                     "auto",
                                     "auto"),
                                os
                              ),
                              cont = stats::setNames(
                                list(paste0("bioconductor/bioconductor_docker:",
                                            bioc[[1]]),
                                     NULL,
                                     NULL),
                                os
                              ), 
                              rspm = stats::setNames(
                                list(paste0(
                                  "https://packagemanager.rstudio.com/",
                                  "cran/__linux__/focal/release"
                                ),
                                     NULL,
                                     NULL),
                                os
                              ),
                              versions_explicit=FALSE
                              ){ 
  
  # templateR:::source_all()
  # templateR:::args2vars(construct_runners)
  
  #### Check args ####
  construct_runners_check_args(os = os, 
                               bioc = bioc, 
                               r = r, 
                               cont = cont)
  cont <- construct_runners_check_cont(cont = cont,
                                       versions_explicit = versions_explicit)
  #### Set runners  
  runners <- lapply(os, function(o){
    if(isTRUE(versions_explicit)){
      info <- bioc_r_versions(bioc_version = bioc[[o]])
    } else {
      info <- list(bioc=bioc[[o]], 
                   r=r[[o]])
    } 
    list(os = o,
         bioc=info$bioc,
         r=info$r,
         cont=cont[[o]],
         rspm=rspm[[o]]
         )
  })
  return(runners) 
}
