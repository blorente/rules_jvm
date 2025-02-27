load("@rules_jvm_external//:defs.bzl", "artifact")
load("//java/private:library.bzl", "java_test")
load("//java/private:package.bzl", "get_package_name")

"""Dependencies typically required by JUnit 5 tests.

See `java_junit5_test` for more details.
"""
JUNIT5_DEPS = [
    artifact("org.junit.jupiter:junit-jupiter-engine"),
    artifact("org.junit.platform:junit-platform-launcher"),
    artifact("org.junit.platform:junit-platform-reporting"),
]

JUNIT5_VINTAGE_DEPS = [
    artifact("org.junit.vintage:junit-vintage-engine"),
] + JUNIT5_DEPS

def java_junit5_test(name, test_class = None, runtime_deps = [], **kwargs):
    """Run junit5 tests using Bazel.

    This is designed to be a drop-in replacement for `java_test`, but
    rather than using a JUnit4 runner it provides support for using
    JUnit5 directly. The arguments are the same as used by `java_test`.

    The generated target does not include any JUnit5 dependencies. If
    you are using the standard `@maven` namespace for your
    `maven_install` you can add these to your `deps` using `JUNIT5_DEPS`
    or `JUNIT5_VINTAGE_DEPS` loaded from `//java:defs.bzl`

    Args:
      name: The name of the test.
      test_class: The Java class to be loaded by the test runner. If not
        specified, the class name will be inferred from a combination of
        the current bazel package and the `name` attribute.
    """
    if test_class:
        clazz = test_class
    else:
        clazz = get_package_name() + name

    java_test(
        name = name,
        main_class = "com.github.bazel_contrib.contrib_rules_jvm.junit5.JUnit5Runner",
        test_class = clazz,
        runtime_deps = runtime_deps + [
            "@contrib_rules_jvm//java/src/com/github/bazel_contrib/contrib_rules_jvm/junit5",
        ],
        **kwargs
    )
