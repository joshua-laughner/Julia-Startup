import Printf
import Pkg

# To use this as your startup.jl file, either copy or link it into 
# ~/.julia/config. 
#
# Setting this as your startup.jl script does two things:
#
#   1) If you start Julia in a project directory (that has a Project.toml
#      or JuliaProject.toml file), it will automatically ask you if it should
#      activate that project.
#   2) It will append "." to the end of LOAD_PATH, allowing you to import modules
#      from your current directory.
#
# By default, these will only be activated if running Julia interactively, i.e. you
# did not call it as "julia script.jl" but just "julia". I have set this up so that
# you may override that if you wish, but generally I don't recommend doing so. If
# you write code that relies on your startup.jl, it loses a lot of portability, as
# anyone else you give the code to will need their startup.jl file to do the same
# things.

# Set this to true to automatically activate projects if you start Julia running a
# script in a project directory
activate_proj_for_script = false

# Set this to true to automatically add the current directory to your LOAD_PATH even
# when running a script.
add_curr_dir_for_script = false


# END CONFIG #

# I tried a few ways to test if we are running a script or running interactively.
# Looking at @__FILE__ and using isinteractive() fail b/c while running this file,
# they both behave as if you are running a script, because you are.
is_interactive = PROGRAM_FILE == ""


# First, either if running an interactive REPL or if overridded above,
# ask to activate a project in the current directory if it exists.
if is_interactive || activate_proj_for_script

    if isfile("./Project.toml") || isfile("./JuliaProject.toml")
        Printf.@printf("A project toml file exists at %s.\n", pwd())
        print("Do you want to activate this project [Y/n]?: ")
        user_ans = chomp(readline())

        if lowercase(user_ans) == "n"
            println("Not activating project.")
        else
            Pkg.activate(".")
            Printf.@printf("Activated project at %s.\n", pwd())
        end
    end

    Printf.@printf("Note: automatic project activation implemented in %s.\n", @__FILE__)

end

# Second add the current directory to the load path to make it easier to load modules.
# Note that this way works such that if you change directories, it will search the new 
# current directory, not the directory you were in when you first started Julia.
if is_interactive || add_curr_dir_for_script
    push!(LOAD_PATH, ".")
    println("Added current directory to LOAD_PATH - this is not included by default when running scripts.")
end
