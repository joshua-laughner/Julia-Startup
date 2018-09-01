import Printf
import Pkg

if isfile("./PROJECT.toml")
    Printf.@printf("A PROJECT.toml file exists at %s.\n", pwd())
    print("Do you want to activate this project [Y/n]?: ")
    user_ans = chomp(readline())

    if lowercase(user_ans) == "n"
        print("Not activating project.\n")
    else
        Pkg.activate(".")
        Printf.@printf("Activated project at %s.\n", pwd())
    end
end

Printf.@printf("Note: automatic project activation implemented in %s.\n", @__FILE__)
