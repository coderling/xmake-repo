package("xmake-utils")
    add_urls("https://github.com/coderling/xmake_utils.git")
    on_install(function(package)
        print("on install xmake utils:$(projectdir)")
        local ins_dir = package:installdir()
        os.cp("xmake/*", ins_dir)
        local ins_dir = package:installdir()
        local valid_path = string.gsub(ins_dir, "\\", "/")
        io.writefile("$(projectdir)/xmake/modules/xmake_utils_modules_import.lua", "add_moduledirs(\"" .. valid_path .. "\")")
    end)
    on_load(function(package) 
        print("on load xmake-utils")
        local ins_dir = package:installdir()
        local valid_path = string.gsub(ins_dir, "\\", "/")
        io.writefile("$(projectdir)/xmake/modules/xmake_utils_modules_import.lua", "add_moduledirs(\"" .. valid_path .. "\")")
    end)