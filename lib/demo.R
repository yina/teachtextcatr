demo <- function() {
  # remove blank abstracts
  ohsumed91 <- read.ohsumed.json("data/ohsumed.91.subset.json")
  names(ohsumed91) <- c("id", "mesh", "authors", "pub type", "source",
                        "title", "pmid", "abstract")

  ohsumed91_filtered <- ohsumed91 %>% filter(abstract != "")

  doc_matrix <- create_matrix(ohsumed91_filtered$abstract, language="english")
  doc_labels <- labelDocument(ohsumed91_filtered$mesh, "Animal")

  writeDocumentTermMatrixToLibsvmFile(doc_matrix, outputfilename = "int/ohsumed91_filtered.libsvm",
                                      binary_label=doc_labels)

  # text data can be very large and toward that end, we opt to write to disk a libsvm
  # file and then use command line libsvm tools to classify the results.

  # the clml package supports 5 classifiers at this time

  #clml.estimate.nfold("ohsumed91_filtered.libsvm", classifier="naivebayes")
  #clml.estimate.nfold("ohsumed91_filtered.libsvm", classifier="fest")
  clml.estimate.nfold("int/ohsumed91_filtered.libsvm", classifier="liblinear")
  #clml.estimate.nfold("ohsumed91_filtered.libsvm", classifier="libsvm")
  #clml.estimate.nfold("ohsumed91_filtered.libsvm", classifier="bbr")
}
