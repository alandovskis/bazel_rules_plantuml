load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive", "http_jar")

def plantuml_rules_dependencies():
    _maybe(
        http_archive,
        name = "bazel_skylib",
        urls = [
            "https://mirror.bazel.build/github.com/bazelbuild/bazel-skylib/releases/download/1.0.2/bazel-skylib-1.0.2.tar.gz",
            "https://github.com/bazelbuild/bazel-skylib/releases/download/1.0.2/bazel-skylib-1.0.2.tar.gz",
        ],
        sha256 = "97e70364e9249702246c0e9444bccdc4b847bed1eb03c5a3ece4f83dfe6abc44",
    )

    _maybe(
        http_jar,
        name = "plantuml",
        url = "https://downloads.sourceforge.net/project/plantuml/1.2020.15/plantuml.1.2020.15.jar?r=https%3A%2F%2Fsourceforge.net%2Fprojects%2Fplantuml%2Ffiles%2Fplantuml.1.2020.15.jar%2Fdownload&ts=1593896550",
        sha256 = "1b6903a3a271ed5ce35f6b8ba2ce9cd90a87253f0fc60a7e7ce1e40623117537",
    )

def _maybe(repo_rule, name, **kwargs):
    if name not in native.existing_rules():
        repo_rule(name = name, **kwargs)
