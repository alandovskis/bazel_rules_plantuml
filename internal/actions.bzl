load("@bazel_skylib//lib:shell.bzl", "shell")

def plantuml_generate(ctx, src, type, config, out):
    """Generates a single PlantUML graph from a puml file.

    Args:
        ctx: analysis context.
        src: source file to be read.
        type: the output image format.
        config: the configuration file. Optional.
        out: output image file.
    """
    command = plantuml_command_line(
        executable = ctx.executable._plantuml_tool.path,
        config = config.path if config else None,
        src = src.path,
        output = out.path,
        output_type = type,
    )

    inputs = [src]

    if config:
        inputs.append(config)

    ctx.actions.run_shell(
        outputs = [out],
        inputs = inputs,
        tools = [ctx.executable._plantuml_tool],
        command = command,
        mnemonic = "PlantUML",
        progress_message = "Generating %s" % out.basename,
    )

def plantuml_command_line(executable, config, src, output, output_type):
    """Formats the command line to call PlantUML with the given arguments.

    Args:
        executable: path to the PlantUML binary.
        config: path to the configuration file. Optional.
        src: path to the source file.
        output: path to the output file.
        output_type: image format of the output file.

    Returns:
        A command to invoke PlantUML
    """

    command = "%s -nometadata -p -t%s " % (
        shell.quote(executable),
        output_type,
    )

    if config:
        command += " -config %s " % shell.quote(config)

    command += " < %s > %s" % (
        shell.quote(src),
        shell.quote(output),
    )

    return command
