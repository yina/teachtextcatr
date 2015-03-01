# libsvm file helpers

#' writeDocumentTermMatrixToLibsvmFile
#' @param
writeDocumentTermMatrixToLibsvmFile <- function(doc_matrix, outputfilename, binary_label) {
  # doc_matrix is in slam format as produced by create_matrix from the RTextTools
  # package. There isn't a direct way to convert this to a libsvm file, but
  # we can conver to some intermediates which will allow us to convert to
  # libsvm format
  doc_matrix_sparse <-  sparseMatrix(i=doc_matrix$i, j=doc_matrix$j, x=doc_matrix$v,
                                     dims=c(doc_matrix$nrow, doc_matrix$ncol))

  X.csc <- new("matrix.csc", ra = doc_matrix_sparse@x,
               ja = doc_matrix_sparse@i + 1L,
               ia = doc_matrix_sparse@p + 1L,
               dimension = doc_matrix_sparse@Dim)
  X.csr <- as.matrix.csr(X.csc)

  write.matrix.csr(X.csr, file=outputfilename, y=binary_label)

  basefile <- sub("^([^.]*).*", "\\1", outputfilename)
  write.table(colnames(doc_matrix), file=paste(basefile, "_wordlist.txt", sep=""),
              col.names=FALSE, quote=FALSE)
}

labelDocument <- function(string, matchword) {
  return(as.numeric(str_detect(string, matchword)))
}
