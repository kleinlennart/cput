#' Translate path to here::here path
#'
#' Call this function as an addin to insert here path from selection.
#'
#' @export
translateHere <- function() {
  context <- rstudioapi::getActiveDocumentContext()
  selection <- rstudioapi::primary_selection(context)
  path <- selection$text
  # selection$range ## use to insert?

  if (!stringr::str_detect(path, '^\\"') | !stringr::str_detect(path, '\\"$')) {
    usethis::ui_stop("Selection included more than just the path.")
  }


  # FIXME: change to {cli}
  usethis::ui_info(path)
  path <- stringr::str_split(path, "/") |>
    unlist() |>
    paste(collapse = '", "')
  here <- stringr::str_glue('here::here(', path, ')')

  rstudioapi::insertText(here)
  cli::cli_alert_success("Inserted!")
}
