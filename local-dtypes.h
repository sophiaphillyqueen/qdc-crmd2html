#ifndef LC___LOCAL_DTYPES__H
#define LC___LOCAL_DTYPES__H

#include "local-invoke.h"

typedef struct ident_o_fl {
  // The next item in the chain
  struct ident_o_fl *nx;
  
  // The name of this item (full pathname)
  char *fl;
} ident_o_fl;

#endif
