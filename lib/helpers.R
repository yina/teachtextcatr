read.ohsumed.json <- function(file) {
  jf <- fromJSON(file=file)
  jf <- lapply(jf, function(x) {
    unlist(x)
  })
  jdf <- do.call("rbind", jf)
  jdf <- as.data.frame(jdf)
}

#' filename is generated from tfidf.py file.
read.tfidf.file <- function(filename) {
  preproc <- read.table(filename, sep=",", header=FALSE, stringsAsFactors=FALSE)
  names(preproc) <- c(".I", "payload")
  preproc$.I <- as.numeric(str_sub(basename(preproc$.I), 1, -5))
  return(preproc)
}


