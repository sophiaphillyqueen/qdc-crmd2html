use strict;

my @all_the_objs = ();
my @all_the_heads = ();
my $name_of_prog = '';
my $the_c_comp = 'gcc';

# First, we make sure we are doing our configuration
# from within the correct directory.

&chadira($ARGV[0]);

sub chadira {
  my $lc_rg;
  my $lc_suc;
  my $lc_plc;
  
  foreach $lc_rg (@_)
  {
    $lc_suc = chdir($lc_rg);
    if ( $lc_suc < 0.5 )
    {
      $lc_plc = `pwd`;
      chop($lc_plc);
      die("Fatal configuration error: failed to change directory:\n"
          . "From: " . $lc_plc . " :\n"
          . "  To: " . $lc_rg . " :\n"
          . "\n" );
    }
  }
}


# Now it is time to load basic preferences
{
  my $lc_rwa;
  my @lc_rwb;
  my $lc_rwc;
  
  $lc_rwa = `cat config.txt`;
  @lc_rwb = split(/\n/,$lc_rwa);
  foreach $lc_rwc (@lc_rwb) { &nx_proc_line($lc_rwc); }
}


sub nx_proc_line {
  my @lc_rwd;
  
  @lc_rwd = split(quotemeta(':'),("x" . $_[0] . "::::::::z"));
  
  if ( $lc_rwd[1] eq 'c' )
  {
    @all_the_objs = (@all_the_objs, $lc_rwd[2]);
    return;
  }
  
  if ( $lc_rwd[1] eq 'h' )
  {
    @all_the_heads = (@all_the_heads, $lc_rwd[2]);
    return;
  }
  
  if ( $lc_rwd[1] eq 'out' )
  {
    $name_of_prog = $lc_rwd[2];
    return;
  }
  
  if ( $lc_rwd[1] eq '' ) { return; }
  
  die("\nUnrecognized config line-type: " . $lc_rwd[1] . " :\n\n");
}

# And now, having read the configuration file, we begin
# the writing of the Makefile.

open OMAK, "| cat > Makefile";

# Let us start out by defining the universal target
print OMAK "\nall: cres/" . $name_of_prog . "\n";

# And now for the install instructions
print OMAK "\ninstall: all\n\t";
print OMAK "cp cres/" . $name_of_prog . " ~/bin/.\n";

# Now, the instructions for assembling the output file.
print OMAK "\ncres/" . $name_of_prog . ":";
{
  my $lc_a;
  my $lc_b;
  
  $lc_b = '';
  foreach $lc_a (@all_the_objs)
  {
    $lc_b .= ' ' . $lc_a . '.o';
  }
  print OMAK $lc_b . "\n\t";
  print OMAK "mkdir -p cres\n\t";
  print OMAK $the_c_comp . " -o cres/" . $name_of_prog . $lc_b;
  print OMAK "\n";
}

# And now, instructions for making each object file.
{
  my $lc_obj;
  my $lc_hed;
  
  foreach $lc_obj (@all_the_objs)
  {
    print OMAK "\n" . $lc_obj . ".o: " . $lc_obj . ".c";
    foreach $lc_hed (@all_the_heads)
    {
      print OMAK " " . $lc_hed . ".h";
    }
    print OMAK "\n\t" . $the_c_comp . " -c -o ";
    print OMAK $lc_obj . ".o " . $lc_obj . ".c\n";
  }
}

# Finally, the CLEAN instructions
print OMAK "\nclean:\n\trm -rf cres *.o */*.o";
print OMAK " */*/*.o */*/*/*.o\n";

# And now we can, finally, close things out.
print OMAK "\n";
close OMAK;





























