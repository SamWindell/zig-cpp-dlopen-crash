#include <dlfcn.h>
#include <stdio.h>

static int main_helper(int argc, char **argv) {
#ifdef __cplusplus
  printf("running main() from c++ code\n");
#endif

  if (argc != 2) {
    printf("expected shared library path\n");
    return 1;
  }

  void *h = dlopen(argv[1], RTLD_LOCAL | RTLD_NOW);
  if (h == NULL) {
    printf("dlopen failed: %s\n", dlerror());
    return 1;
  } else {
    printf("dlopen success\n");
  }

  void (*func)(void);
  *(void **)(&func) = dlsym(h, "lib_function");
  char *err = dlerror();
  if (err != NULL) {
    printf("couldn't find lib_function: %s\n", err);
    return 1;
  } else {
    printf("found lib_function\n");
  }

  (*func)();

  if (dlclose(h) != 0) {
    printf("dlclose failed\n");
  }
  return 0;
}
