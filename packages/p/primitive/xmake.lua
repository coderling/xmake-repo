package("primitive")
    add_urls("https://github.com/coderling/LPrimitive.git")
    on_install(function(package)
        print("on install LPrimitive: ${projectdir}")
        local configs = {}
        configs["build-tests"] = false
        import("package.tools.xmake").install(package, configs)
    end)