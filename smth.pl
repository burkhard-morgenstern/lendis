#!/usr/bin/perl -w

$infile = $ARGV[0] ; 
$w = $ARGV[1] ; 

if( $#ARGV != 1) {
  print("\n    usage:  $0 <in_file> <w>  \n\n"); 
  print("    Smothes 2nd column using window width <w>\n\n");  
  exit() ; 
} 

if( $w % 2 != 1 ) {
  print("\n w must be odd number \n\n");
  exit();
}

open (IN_FILE , "$infile" );

$n = 0 ;

while(<IN_FILE>){
  $n++; 
  chomp;
  my $line = $_;
  my @elements = split (" ", $line);
  $number[ $n ] = $elements[0] ;
  $value[ $n ] = $elements[1] ;
} 

$sum = 0 ; 

for($i = 1 ; $i <= $w ; $i++ ) { 
 $sum = $sum + $value[ $i ] ;
}

$half_len = ( $w - 1 ) / 2 ; 

# print("half_len = $half_len \n");

for($i = $half_len + 1 ; $i < $n - $half_len; $i++) {


  $average = $sum / $w ; 
  printf("%8d % 10.2f \n", $number[ $i ] , $average); 

  $sum = $sum - $value[ $i - $half_len ] ;    
  $sum = $sum + $value[ $i + $half_len + 1] ;    

} 





