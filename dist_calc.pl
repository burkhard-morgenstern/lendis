#!/usr/bin/perl -w

$infile = $ARGV[0] ; 
$k = $ARGV[1] ; 

if( $#ARGV != 1) {
  print("\n\n   usage:  $0  <in_file> <k> \n\n"); 
  print("   Finds second peak in 2nd column and");  
  print(" estimates p and distance \n\n");  
  exit() ; 
} 


open (IN_FILE , "$infile" );


$global_max = 0;
$i = 0 ;

while(<IN_FILE>){
  chomp;
    my $line = $_;
    my @elements = split (" ", $line);
    $length[ $i ] = $elements[0] ;
    $number[ $i ] = $elements[1];

    if( $number[ $i ] > $global_max ) { 
	    $global_max = $number[ $i ] ;
	    $global_max_len = $length[ $i ] ;
    }
  $i++;
} 

$active = 0 ; 
$local_max = 0 ; 
$maxfound = 0 ;

close IN_FILE  ;
open (IN_FILE , "$infile" );


while(<IN_FILE>){
      	chomp;
  my $line = $_;
  my @elements = split (" ", $line);
  $length[ $i ] = $elements[0] ;
  $number[ $i ] = $elements[1];

  if( ( $length[ $i ] > $global_max_len )  && 
      ( $number[ $i ] < $global_max / 10 ) &&
      ( $number[ $i ] > $number[ $i - 4 ] ) 
    ) { 
    $active = 1 ;
  }  
#    print("len = $length[ $i ] num = $number[ $i ]  active = $active \n");

  if( $active && ( $number[ $i ] > $local_max ) ) { 
    $local_max = $number[ $i ] ; 
    $local_max_len = $length[ $i ] ; 
    $maxfound = 1 ; 
  } 

  $i++;
}


if( $maxfound == 0 ) { 
	 print(" --- "); 
	 exit() ;
 }

#printf("\n global max = $global_max at $global_max_len \n"); 
#printf("\n local max  = $local_max at $local_max_len \n\n"); 
#printf("$local_max_len"); 


$p = ($local_max_len + 1 - $k ) / ($local_max_len + 1 ) ; 

$dist = - 3/4 * log( 1 - 4/3 * (1-$p));

#printf("  %.2f %.2f | ", $p, $dist); 
printf("%.3f", $dist); 





