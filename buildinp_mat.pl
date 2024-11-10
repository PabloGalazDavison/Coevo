#!/usr/bin/perl
# Dec. 2007, by Eshel Faraggi
# Construct the input feature file tmp.inpfet
use v5.10;
use File::Basename;
# Send error messages to the user, not system log
   open(STDERR,'<&STDOUT'); $| = 1;   
   die "usage: $0 pro.mat" if @ARGV < 1;
   $infl = $ARGV[0];
#  $inpfetfl = basename($infl);
   $inpfetfl = "infet.inp";

main: {

   open(INPUT,$infl) || die("Could not open file: $infl! aborted");
   @inseq = <INPUT>;
   close(INPUT);
   $i = 0;
   $prfbeg = 0;
   for (@inseq)
     {
     if (substr($_,3,2) eq ' 1')
       {
       $prfbeg = $i;
       }
     if ((substr($_,3,2) eq '  ')&&($prfbeg>0))
       {
       $prfend = $i-1;
       last;
       }
     $i++;
     }
   for($i=0;$i<($prfend-$prfbeg);$i++)
     {
        $dres = substr($inseq[$prfbeg+$i],6,1);
        $seqres[$i] = $dres;
        if ($dres eq "R") {
            $resdval[$i] = " 0.105   0.373   0.466  -0.900   0.900   0.528  -0.371  ";
        } elsif ($dres eq "K") {
            $resdval[$i] = "-0.088   0.066   0.163  -0.889   0.727   0.279  -0.265  ";
        } elsif ($dres eq "D") {
            $resdval[$i] = "-0.213  -0.417  -0.281  -0.767  -0.900  -0.155  -0.635  ";
        } elsif ($dres eq "E") {
            $resdval[$i] = "-0.230  -0.241  -0.058  -0.696  -0.868   0.900  -0.582  ";
        } elsif ($dres eq "N") {
            $resdval[$i] = "-0.213  -0.329  -0.243  -0.674  -0.075  -0.403  -0.529  ";
        } elsif ($dres eq "Q") {
            $resdval[$i] = "-0.230  -0.110  -0.020  -0.464  -0.276   0.528  -0.371  ";
        } elsif ($dres eq "H") {
            $resdval[$i] = " 0.384   0.110   0.138  -0.271   0.195  -0.031  -0.106  ";
        } elsif ($dres eq "Y") {
            $resdval[$i] = " 0.363   0.417   0.541   0.188  -0.274  -0.155   0.476  ";
        } elsif ($dres eq "W") {
            $resdval[$i] = " 0.479   0.900   0.900   0.900  -0.209   0.279   0.529  ";
        } elsif ($dres eq "S") {
            $resdval[$i] = "-0.337  -0.637  -0.544  -0.364  -0.265  -0.466  -0.212  ";
        } elsif ($dres eq "T") {
            $resdval[$i] = " 0.402  -0.417  -0.321  -0.199  -0.288  -0.403   0.212  ";
        } elsif ($dres eq "G") {
            $resdval[$i] = "-0.900  -0.900  -0.900  -0.342  -0.179  -0.900  -0.900  ";
        } elsif ($dres eq "P") {
            $resdval[$i] = " 0.247  -0.900  -0.294   0.055  -0.010  -0.900   0.106  ";
        } elsif ($dres eq "A") {
            $resdval[$i] = "-0.350  -0.680  -0.677  -0.171  -0.170   0.900  -0.476  ";
        } elsif ($dres eq "M") {
            $resdval[$i] = " 0.110   0.066   0.087   0.337  -0.262   0.652  -0.001  ";
        } elsif ($dres eq "C") {
            $resdval[$i] = "-0.140  -0.329  -0.359   0.508  -0.114  -0.652   0.476  ";
        } elsif ($dres eq "F") {
            $resdval[$i] = " 0.363   0.373   0.412   0.646  -0.272   0.155   0.318  ";
        } elsif ($dres eq "L") {
            $resdval[$i] = " 0.213  -0.066  -0.009   0.596  -0.186   0.714  -0.053  ";
        } elsif ($dres eq "V") {
            $resdval[$i] = " 0.677  -0.285  -0.232   0.331  -0.191  -0.031   0.900  ";
        } elsif ($dres eq "I") {
            $resdval[$i] = " 0.900  -0.066  -0.009   0.652  -0.186   0.155   0.688  ";
        } elsif ($dres eq "X") {
            $resdval[$i] = "-0.900  -0.900  -0.900  -0.342  -0.179  -0.900  -0.900  "; # from G
        } elsif ($dres eq "B") {
            $resdval[$i] = "-0.213  -0.417  -0.281  -0.767  -0.900  -0.155  -0.635  "; # for Asx(B), set to Asp(D) by occurrence
        } elsif ($dres eq "Z") {
            $resdval[$i] = "-0.230  -0.241  -0.058  -0.696  -0.868   0.900  -0.582  "; # for Glx(Z), set to Glu(E) by occurrence
        } elsif ($dres =~ /[a-z]/) {
            $resdval[$i] = "-0.140  -0.329  -0.359   0.508  -0.114  -0.652   0.476  "; # for Cysteine(C) S-S bridge in DSSP program.
        } else {
            die "ERROR! can't find residue '$dres', aborted";
        }
        @ss = split /\s+/, substr($inseq[$prfbeg+$i],8);
        shift @ss if $ss[0] eq "";
        $seqprf[$i]  = "@ss[0..19]";
    #    $seqprf[$i] = substr($inseq[$prfbeg+$i],8,63);
    }
    
    # open (PPFL, ">$inpfetfl");
    # print PPFL ">pro\n";
    # print ">pro\n";
    for($i=0; $i<@seqres; $i++){
        print "$seqres[$i] $seqprf[$i] $resdval[$i]\n";
    }
   for($i=0; $i<@seqres; $i++){
   	print "$seqres[$i] $seqprf[$i] $resdval[$i]\n"
	}
#   for (@seqres) {
#     format PPFL = 
#@>>  @>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> @>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
#$seqres[$i] , $seqprf[$i] , $resdval[$i] .
#     write PPFL ; $i++;
#   }
#   close (PPFL);
}


