library(targets)
library(tarchetypes)
library(crew)
library(crew.cluster)

# here we assume that the project root is bound to
# the image's internal directory /pipeline
# this is attained by --bind /ddn/gs1/home/songi2/beethoven:/pipeline
# in the apptainer run command


tar_source("inst/targets/pipeline_base_functions.R")
tar_source("inst/targets/targets_initialize.R")
tar_source("inst/targets/targets_download.R")
tar_source("inst/targets/targets_calculate.R")
tar_source("inst/targets/targets_baselearner.R")
tar_source("inst/targets/targets_metalearner.R")
tar_source("inst/targets/targets_predict.R")
tar_source("inst/targets/targets_arglist.R")

# bypass option
Sys.setenv("BTV_DOWNLOAD_PASS" = "TRUE")


# plan(
#   list(
#     tweak(
#       future.batchtools::batchtools_slurm,
#       template = "inst/targets/template_slurm.tmpl",
#       resources =
#         list(
#           memory = 8,
#           log.file = "slurm_run.log",
#           ncpus = 1, partition = "geo", ntasks = 1,
#           email = arglist_common$user_email,
#           error.file = "slurm_error.log"
#         )
#     ),
#     multicore
#   )
# )

crew_default <-
  crew::crew_controller_local(
    name = "controller_default",
    workers = 20L,
    garbage_collection = TRUE
  )

# # invalidate any nodes older than 180 days: force running the pipeline
# tar_invalidate(any_of(tar_older(Sys.time() - as.difftime(180, units = "days"))))


# # nullify download target if bypass option is set
if (Sys.getenv("BTV_DOWNLOAD_PASS") == "TRUE") {
  target_download <- NULL
}

# targets options
# TODO: check if the controller and resources setting are required
tar_option_set(
  packages =
    c("amadeus", "chopin", "targets", "tarchetypes",
      "data.table", "sf", "terra", "exactextractr",
      "crew", "crew.cluster", 
      "tigris", "dplyr",
      "future.batchtools", "qs", "collapse",
      "future", "future.apply", "future.callr", "callr",
      "stars", "rlang", "foreach", "parallelly"),
  repository = "local",
  error = "stop",
  controller = crew_default,
  resources = tar_resources(
    crew = tar_resources_crew(
      controller = "controller_default"
    )
  ),
  memory = "transient",
  format = "qs",
  storage = "worker",
  deployment = "worker",
  garbage_collection = TRUE,
  seed = 202401L
)

# should run tar_make_future()

list(
  target_init,
  # targets::tar_target(
  #   int_feat_calc_radii,
  #   command = c(1e3, 1e4, 5e4),
  #   iteration = "vector"
  # ),
  target_download,
  target_calculate_fit#,
  # target_baselearner,
  # target_metalearner,
  # target_calculate_predict,
  # target_predict,
  # # documents and summary statistics
  # targets::tar_target(
  #   summary_urban_rural,
  #   summary_prediction(
  #     grid_filled,
  #     level = "point",
  #     contrast = "urbanrural"))
  # ,
  # targets::tar_target(
  #   summary_state,
  #   summary_prediction(
  #     grid_filled,
  #     level = "point",
  #     contrast = "state"
  #   )
  # )
)

# targets::tar_visnetwork(targets_only = TRUE)
# END OF FILE
