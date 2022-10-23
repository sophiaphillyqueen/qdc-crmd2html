#ifndef LC___LOCAL_VARS__H
#define LC___LOCAL_VARS__H

#include "local-dtypes.h"

// Variables for global storage of command-line and
// environment:
extern int orgc;
extern char **orgv;
extern char **onviron;

// This is the actual main function
int m2_ain ( void );

// Get all the parameters that you need from the command line.
void procs_comd_line ( void );

// Initialize important variables used in the program
void init_pram_vars ( void );

// Process the tentent of all of the source files and prepare
// the basic parts of the HTML output - but do not acutally
// output it yet.
void procs_all_files ( void );

// Actually output the HTML content
void out_with_the_html ( void );

// The variable is used to index where you are
// in processing the command line.
int argum_idexr;

// Get the next argument from the command line.
char *get_nx_rg ( void )

// Process a single command-line option
void procs_cml_opt ( char *rg_a );

// Tests to see if two C strings are the same.
bool samestrg ( char *rg_a, char *rg_b );

// Add a file from the command line to our list
void add_file_of_targ ( void );

// true = We will output the full HTML at the end
// false  - We will just output what goes between (and not including) the body tags
// ** At the object file, set the default value to _true_ **
extern bool sd_show_if;

// Set a variable's value based on the command line.
void set_var_cml_val ( void );

#endif
