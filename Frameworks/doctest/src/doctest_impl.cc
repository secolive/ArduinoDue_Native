#define DOCTEST_CONFIG_NO_MULTITHREADING
#define DOCTEST_CONFIG_NO_POSIX_SIGNALS
#define DOCTEST_CONFIG_NO_EXCEPTIONS
#define DOCTEST_CONFIG_IMPLEMENT
#define DOCTEST_CONFIG_COLORS_NONE
#define DOCTEST_CONFIG_USE_STD_HEADERS
#include <doctest.h>

int doctest_impl(int argc, char** argv) {
    doctest::Context context;

    // defaults
#ifdef ARDUINO_BUILD_FOR_HOST
    context.setOption("abort-after", 5);              // stop test execution after 5 failed assertions
#endif
    context.setOption("order-by", "name");            // sort the test cases by their name

    if(argc>0)
        context.applyCommandLine(argc, argv);

    // overrides
    context.setOption("no-breaks", true);             // don't break in the debugger when assertions fail

    int res = context.run(); // run

    if(context.shouldExit()) // important - query flags (and --exit) rely on the user doing this
        return res;          // propagate the result of the tests

    return res;
}
