"""Unit tests for PlantUML action"""

load("@bazel_skylib//lib:unittest.bzl", "asserts", "unittest")
load(":actions.bzl", "plantuml_command_line")

def _no_config_impl(ctx):
    env = unittest.begin(ctx)
    asserts.equals(
        env,
        "'/bin/plantuml' -nometadata -p -tpng  < 'mysource.puml' > 'dir/myoutput.png'",
        plantuml_command_line(
            executable = "/bin/plantuml",
            config = None,
            src = "mysource.puml",
            output = "dir/myoutput.png",
            output_type = "png",
        ),
    )
    return unittest.end(env)

no_config_test = unittest.make(_no_config_impl)

def _with_config_impl(ctx):
    env = unittest.begin(ctx)
    asserts.equals(
        env,
        "'/bin/plantuml' -nometadata -p -tpng  -config 'myskin.skin'  < 'mysource.puml' > 'dir/myoutput.png'",
        plantuml_command_line(
            executable = "/bin/plantuml",
            config = "myskin.skin",
            src = "mysource.puml",
            output = "dir/myoutput.png",
            output_type = "png",
        ),
    )
    return unittest.end(env)

with_config_test = unittest.make(_with_config_impl)

def actions_test_suite():
    unittest.suite(
        "actions_tests",
        no_config_test,
        with_config_test,
    )
