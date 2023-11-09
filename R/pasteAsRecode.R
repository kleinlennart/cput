#' Paste Clipboard as Recode
#'
#' Call this function as an Addin to insert a recoder based on codebook clipboard
#'
#' @export
pasteAsRecode <- function() {
  clipy <- clipr::read_clip_tbl(header = FALSE)
  glue <- stringr::str_glue('"{clipy$V1}" = "{clipy$V2}"')
  recoder <- paste0("recode(\n  ", paste0(glue, collapse = ",\n  "), "\n)")
  rstudioapi::insertText(recoder)
}


#' Paste Clipboard as fct_recode
#'
#' Call this function as an Addin to insert a recoder based on codebook clipboard
#'
#' @export
pasteAsFctRecode <- function() {
  clipy <- clipr::read_clip_tbl(header = FALSE)
  glue <- stringr::str_glue('"{clipy$V2}" = "{clipy$V1}"')
  recoder <- paste0("fct_recode(\n  ", paste0(glue, collapse = ",\n  "), "\n)")
  rstudioapi::insertText(recoder)
}


#' Get Recoder from Vector
#'
#' @param vec Input vector
#' @param same Should the same factor labels be prepopulated? (defaults to TRUE)
#'
#' @export
use_recoder <- function(vec, same = TRUE) {
  if (is.factor(vec)) {
    lev <- levels(vec)
  } else {
    lev <- unique(vec)
  }

  if (same) {
    glue <- stringr::str_glue('"{lev}" = "{lev}"')
  } else {
    glue <- stringr::str_glue('"" = "{lev}"')
  }

  recoder <- paste0("fct_recode(\n  ", paste0(glue, collapse = ",\n  "), "\n)")
  cli::cli_code(recoder)
  cli::cli_h1("")

  if (usethis::ui_yeah(x = "Copy code to clipboard?", no = "No thanks", yes = "Yes", shuffle = FALSE)) {
    clipr::write_clip(recoder)
    usethis::ui_done("Copied!")
  }
}



#' Get case_match from vector
#'
#' @param vec Input vector
#' @param numbers Should levels be machted to numbers? (defaults to TRUE)
#'
#' @export
use_rematcher <- function(vec, numbers = TRUE) {
  if (is.factor(vec)) {
    lev <- levels(vec)
  } else {
    lev <- unique(vec)
  }

  if (numbers) {
    glue <- stringr::str_glue('"{lev}" ~ {seq_along(lev)}')
  } else {
    glue <- stringr::str_glue('"{lev}" ~ ')
  }

  recoder <- paste0("case_match(\n  ", paste0(glue, collapse = ",\n  "), "\n)")
  cli::cli_code(recoder)
  cli::cli_h1("")

  if (usethis::ui_yeah(x = "Copy code to clipboard?", no = "No thanks", yes = "Yes", shuffle = FALSE)) {
    clipr::write_clip(recoder)
    usethis::ui_done("Copied!")
  }
}
