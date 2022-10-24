
#include "main-head.h"

int m2_ain ( void )
{
  init_pram_vars();
  procs_comd_line();
  procs_all_files();
  out_with_the_html();
  return 0;
}