package("xmake-utils")
    add_urls("https://github.com/coderling/xmake_utils.git main")
    on_install(function(package)
        print("project dir: $(projectdir)")
        print("cur dir: $(curdir)")
    end)