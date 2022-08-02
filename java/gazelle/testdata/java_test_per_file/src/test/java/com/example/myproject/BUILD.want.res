load("@rules_java//java:defs.bzl", "java_test")

java_test(
    name = "AppTest",
    srcs = ["AppTest.java"],
    test_class = "com.example.myproject.AppTest",
    deps = [
        "@maven//:junit_junit",
        "@maven//:org_hamcrest_hamcrest_all",
    ],
)

java_test(
    name = "OtherAppTest",
    srcs = ["OtherAppTest.java"],
    test_class = "com.example.myproject.OtherAppTest",
    deps = [
        "@maven//:junit_junit",
        "@maven//:org_hamcrest_hamcrest_all",
    ],
)
