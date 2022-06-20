#include <stdio.h>
#define DOCTEST_CONFIG_SUPER_FAST_ASSERTS
#include <doctest.h>

TEST_CASE("Hello World Test Case") {
  CHECK(0==0);
}

TEST_CASE("Hello World Test Case - Failing") {
  CHECK(1==0);
}
