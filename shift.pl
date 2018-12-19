#!/usr/bin/perl -w

$infile = $ARGV[0] ; 
$k = $ARGV[1] ; 

if( $#ARGV != 1) {
  print("\n\n usage:  $0  <in_file> <k> \n\n "); 
  exit() ; 
} 


open (IN_FILE , "$infile" );


$last = 1000000000;

while(<IN_FILE>){

  chomp;
    my $line = $_;
    my @elements = split (" ", $line);
    my $current_len = $elements[0] + $k;
    my $number = $elements[1];

    for( $i = $last + 1 ; $i < $current_len ; $i++ ) { 
        printf(" $i 0 \n"); 
      }	    

    printf(" $current_len $number \n"); 

    $last = $current_len ; 
} 



