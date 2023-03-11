#' Paste Clipboard as Vector
#'
#' Call this function as an addin to insert content of clipboard as vector assignment.
#'
#' @export
pasteAsVector <- function() {
  # clipy <- clipr::read_clip()
  # rstudioapi::insertText(capture.output(dput(clipy)))

  clipy <- clipr::read_clip_tbl(header = FALSE)
  if (identical(ncol(clipy), 1L)) { # convert to vector
    clipy <- clipy$V1
  }
  rstudioapi::insertText(utils::capture.output(dput(clipy)))
}
