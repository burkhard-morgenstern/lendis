#!/usr/bin/perl -w


if( $#ARGV != 1) {
  print("\n\n   usage:  $0  <k> <w> \n\n"); 
  print("   <k> is number of mismatches, <w> is width of smoothing window \n");
  print("   <k> must be integer, <w> must be odd integer \n\n");
  print("   $0 runs kmacs on all pairs of *.fa files in current directory\n");
  print("   and runs shift.pl, smth.pl, maxfind.pl on result \n\n"); 
  print("   program output is matrix with estimated number of \n");
  print("   substitutions per position for each pair of sequences \n\n\n"); 
  exit() ; 
} 

$k = $ARGV[0] ; 
$k1 = $k+1 ;
$smth_win = $ARGV[1] ;

if( $smth_win % 2 != 1 ) {
  print("\n width w of smoothing window must be odd number \n\n");
  exit();
}



$cnt = 0 ; 

@FILES = glob("*.fa");

foreach my $f_name (@FILES){

$file_name[ $cnt ] = $f_name,
$name[ $cnt ]      = $f_name,
$name[ $cnt ]  =~ s{\.[^.]+$}{}; 

	open my $file, '<', "$f_name"; 
	my $firstline = <$file>; 
	close $file;

	$f_name =~ s{\.[^.]+$}{}; 

 $cnt++ ; 
} 


printf("$cnt \n");


for($i = 0 ; $i < $cnt ; $i++ ) { 
printf("%-14s ", $name[ $i ]); 
  for($j = 0 ; $j < $i ; $j++ ) { 
      $in_file= $name[ $i ] . '_' . $name[ $j ] . '.fa'; 
      $out_file= $name[ $i ] . '_' . $name[ $j ] . '_k=' . $k .'.out'; 
      $shift_file= $name[ $i ] . '_' . $name[ $j ] . '_k=' . $k .'.sh'; 
      $smth_file= $name[ $i ] . '_' . $name[ $j ] . '_k=' . $k .'.sm'; 
	system("cat $file_name[ $i ] $file_name[ $j ] > $in_file " );  
        system("kmacs_n4 $in_file $k1  > $out_file");
        system("rm -rf $in_file");

        system("shift.pl $out_file $k > $shift_file") ; 
	system("smth.pl	$shift_file $smth_win > $smth_file");

	system("dist_calc.pl $smth_file $k"); 
        print(" "); 
        system("rm -rf $out_file");
        system("rm -rf $shift_file");
        system("rm -rf $smth_file");
}

printf(" \n"); 
}


system("rm -rf DMat");


