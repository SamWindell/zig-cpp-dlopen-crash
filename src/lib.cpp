#include <stdio.h>

#ifdef __cplusplus
extern "C" {
#endif

__attribute__((visibility("default"))) void lib_function() {
  printf("hello from lib\n");
}

#ifdef __cplusplus
}
#endif
