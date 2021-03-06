#' Parse the server error or raise for status.
#'
#' @param response A response object from \code{httr::POST} or \code{httr::GET}.
#' @return If the response code is 200 or 204, a parsed response. Else, a server error or raised exception.
#' @examples
#' \dontrun{
#' b2 <- "http://httpbin.org/post"
#' response <- httr::POST(b2, body = "A simple text string")
#' parse_server_error_or_raise_for_status(response)
#' }
#' @export
parse_server_error_or_raise_for_status <- function(response) {
  if (httr::status_code(response) == 204) {
    return(invisible())
  }

  if (httr::http_type(response) != "application/json") {
    stop("API did not return json", call. = FALSE)
  }

  cont <- httr::content(response, as = "text", encoding = "UTF-8")
  parsed <- jsonlite::fromJSON(cont, simplifyVector = FALSE)

  if (!(httr::status_code(response) %in% c(200, 204))) {
    stop(
      sprintf(
        "OpenAI Gym API request failed [%s]\n%s\n<%s>",
        httr::status_code(response),
        parsed$message,
        parsed$documentation_url
      ),
      call. = FALSE
    )
  }

  parsed
}

#' Submit a POST request to an OpenAI Gym server.
#'
#' @param x An instance of class "GymClient"; this object has "remote_base" as an attribute.
#' @param route The URL path or endpoint.
#' @param data URL query arguments. Default value is NULL.
#' @return If the response code is 200 or 204, a parsed response. Else, a server error or raised exception.
#' @examples
#' \dontrun{
#' remote_base <- "http://127.0.0.1:5000"
#' client <- create_GymClient(remote_base)
#' route <- "/v1/envs/"
#' env_id <- "CartPole-v0"
#' data <- list(env_id = env_id)
#' post_request(client, route, data)
#' }
#' @export
post_request <- function(x, route, data = NULL) {
  url <- httr::modify_url(x$remote_base, path = route)
  response <- httr::POST(url, body = data, encode = "json")
  parse_server_error_or_raise_for_status(response)
}

#' Submit a GET request to an OpenAI Gym server.
#'
#' @param x An instance of class "GymClient"; this object has "remote_base" as an attribute.
#' @param route The URL path or endpoint.
#' @param data URL query arguments. Default value is NULL.
#' @return If the response code is 200 or 204, a parsed response. Else, a server error or raised exception.
#' @examples
#' \dontrun{
#' remote_base <- "http://127.0.0.1:5000"
#' client <- create_GymClient(remote_base)
#' route <- "/v1/envs/"
#' get_request(client, route)
#' }
#' @export
get_request <- function(x, route, data = NULL) {
  url <- httr::modify_url(x$remote_base, path = route)
  response <- httr::GET(url, body = data, encode = "json")
  parse_server_error_or_raise_for_status(response)
}
