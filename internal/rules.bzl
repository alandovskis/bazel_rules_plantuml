load(
    ":actions.bzl",
    "plantuml_generate",
)

def _plantuml_graph_impl(ctx):
    outs = []
    for type in ["png", "svg"]:
        output = ctx.actions.declare_file("{name}.{format}".format(
               name = ctx.label.name,
               format = type,
        ))
        outs.append(output)
        plantuml_generate(
            ctx,
            src = ctx.file.src,
            type = type,
            config = ctx.file.config,
            out = output,
        )

    return [DefaultInfo(
        files = depset(outs),
    )]

plantuml_graph = rule(
    _plantuml_graph_impl,
    attrs = {
        "config": attr.label(
            doc = "Configuration file to pass to PlantUML. Useful to tweak the skin",
            allow_single_file = True,
        ),
        "format": attr.string(
            doc = "Output image format",
            default = "png",
            values = ["png", "svg"],
        ),
        "src": attr.label(
            allow_single_file = [".puml"],
            doc = "Source file to generate the graph from",
            mandatory = True,
        ),
        "_plantuml_tool": attr.label(
            default = "//third_party/plantuml",
            executable = True,
            cfg = "host",
        ),
    },
    outputs = {
        "graph": "%{name}.%{format}",
    },
    doc = "Generates a PlantUML graph from a puml file",
)
