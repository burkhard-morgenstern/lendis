# lendis
Length distribution of k-mismatch common substrings to estimate phylogenetic distances. 


The purpose of this software is to estimate phylogenetic distances between DNA sequences from the length
distribution of k-mismatch common substrings. Here, the distance between two sequences is defined as the number
of substitutions since they diverged from their last common ancestor.

The approach is described in:

B. Morgenstern, S. Schöbel, C-A. Leimeister (2017)
Phylogeny reconstruction based on the length distribution of k-mismatch common substrings
Algorithms for Molecular Biology 12, 27

https://almob.biomedcentral.com/articles/10.1186/s13015-017-0118-8

If you publish results obtained with our software, please cite this paper.


The program "lendis" requires as input a set of DNA sequences as single FASTA files (one single-sequence FASTA
file per species). These files must be in the same directory where you run the Perl scripts.  

To run the software, first install the specialized version of the program kmacs that is provided in this package:
detar kmacs_ld.tar and run "make". The produced executable is called "kmacs_ld" (for "length distribution").

The Perl scripts that are provided in this package further process the output of kmacs_ld and finally calculate
pairwise distances between all .fa sequences in the current directory.

- The file lendis.pl is a wrapper script that calls other Perl scripts. The program parameters are k and w: k is
the number of mismatches in kmacs_ld and w is the width of the smoothing window (w must be an uneven integer).

- If you call lendis.pl, it first runs kmacs_ld on all .fa files in the current directory (sequences in FASTA
format, one sequence per file!). For each pair of input sequences, the program outputs a table with the length
distribution of the k-mismatch common substrings: For each length m, the number of k-mismatch common substrings
of length m is given. E.g., "25 4" in the table means that there are 4 k-mismatch common substrings of length 25.
Here, kmacs does not count the mismatches in the length of the common substrings.

- The script shift.pl re-formats the table produced by kmacs_ld adding the number of mismatches (k) to the
lengths of the k-mismatch common substrings. Also, if for a length m no k-mismatch common substring of length m
is found, the program adds "<m> 0" to the table.

- The script smth.pl smooths the table produced by shift.pl using a window of width w. Note that w must be an
uneven integer.

- Finally, the script dist_calc.pl estimates for each pair of input sequences the number of substitutions per
position from the smoothed length distribution.

- The output is a distance matrix in phylip format.


In the directory "example", there are four .fa sequences. The file "example_testrun.txt" contains the result that
you should obtain if you run the software with k=20 and w=5 on these four sequences.

Note that it is possible that our software is unable to estimate the distance for a given pair of sequences and
parameters. In this case, the entry in the distance matrix is "---"


For questions, please consult the above paper or contact Burkhard Morgenstern: bmorgen@gwdg.de

