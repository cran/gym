% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/api.R
\name{env_action_space_contains}
\alias{env_action_space_contains}
\title{Evaluate whether an action is a member of an environments's action space.}
\usage{
env_action_space_contains(x, instance_id, action)
}
\arguments{
\item{x}{An instance of class "GymClient"; this object has "remote_base" as an attribute.}

\item{instance_id}{A short identifier (such as "3c657dbc") for the environment instance.}

\item{action}{An action to take in the environment.}
}
\value{
A boolean atomic vector of length one indicating if the action is a member of an environments's action space.
}
\description{
Evaluate whether an action is a member of an environments's action space.
}
\examples{
\dontrun{
remote_base <- "http://127.0.0.1:5000"
client <- create_GymClient(remote_base)
env_id <- "CartPole-v0"
instance_id <- env_create(client, env_id)
action <- env_action_space_sample(client, instance_id)
env_action_space_contains(client, instance_id, action)
}
}

