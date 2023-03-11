#' Paste Clipboard as Recode
#'
#' Call this function as an Addin to insert a recoder based on codebook clipboard
#'
#' @export
pasteAsRecode <- function() {
  clipy <- clipr::read_clip_tbl(header = FALSE)
  glue <- stringr::str_glue('"{clipy$V1}" = "{clipy$V2}"')
  recoder <- paste0("var %>% recode(\n  ", paste0(glue, collapse = ",\n  "), "\n)")
  rstudioapi::insertText(recoder)
}
