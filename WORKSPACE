# This is required to tell Bazel the workspace name. Otherwise
# undefined errors occur when using it as a dependency.
workspace(name = "rules_plantuml")

load("@rules_plantuml//:deps.bzl", "plantuml_rules_dependencies")

plantuml_rules_dependencies()

load("@bazel_skylib//:workspace.bzl", "bazel_skylib_workspace")
bazel_skylib_workspace()
