package("primitive")
    add_urls("https://github.com/coderling/LPrimitive.git")
    on_install(function(package)
        print("on install LPrimitive: ${projectdir}")
        local configs = {}
        configs["build-tests"] = false
        import("package.tools.xmake").install(package, configs)
    end)

    on_fetch(function (package)
        local result = {}
        local libfiledir = (package:config("shared") and package:is_plat("windows", "mingw")) and "bin" or "lib"
        result.links = "primitive"
        result.linkdirs = package:installdir("lib")
        result.includedirs = package:installdir("include")
        result.libfiles = path.join(package:installdir(libfiledir), "primitive.lib")
        return result
    end)

    on_test(function (package)
        assert(package:has_cxxincludes("Align.hpp"))
    end)