# Example preprocessing script.
ohsumed91 <- read.ohsumed.json("data/ohsumed.91.subset.json")
names(ohsumed91) <- c("id", "mesh", "authors", "pub type", "source",
                      "title", "pmid", "abstract")

ohsumed91_filtered <- ohsumed91 %>% filter(abstract != "")


