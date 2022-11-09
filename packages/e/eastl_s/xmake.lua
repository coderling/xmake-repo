package("eastl_s")

    set_homepage("https://github.com/electronicarts/EASTL")
    set_description("EASTL stands for Electronic Arts Standard Template Library.")
    set_license("BSD-3-Clause")

    add_urls("https://github.com/electronicarts/EASTL/archive/$(version).tar.gz")
    add_versions("3.18.00", "a3c5b970684be02e81fb16fbf92ed2584e055898704fde87c72d0331afdea12b")

    add_deps("cmake")
    add_deps("eabase")

    on_install("windows", "linux", "macosx", function (package)
        io.replace("CMakeLists.txt", "add_subdirectory(test/packages/EABase)", "", {plain = true})
        io.replace("CMakeLists.txt", "target_link_libraries(EASTL EABase)", "", {plain = true})
        local configs = {"-DEASTL_BUILD_TESTS=OFF", "-DEASTL_BUILD_BENCHMARK=OFF"}
        table.insert(configs, "-DCMAKE_BUILD_TYPE=" .. (package:debug() and "Debug" or "Release"))
        if not package:is_plat("windows") then
            table.insert(configs, "-DBUILD_SHARED_LIBS=" .. (package:config("shared") and "ON" or "OFF"))
        end
        import("package.tools.cmake").install(package, configs, {packagedeps = "eabase"})
        os.cp("include/EASTL", package:installdir("include"))
    end)


    on_test(function (package)
        assert(package:check_cxxsnippets({test = [[
            void test() {
                eastl::vector<int> testInt{};
            }
        ]]},{configs = {languages = "c++20"}, includes = "EASTL/vector.h"}))
    end)