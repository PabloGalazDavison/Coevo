# My little workshop

**Pipeline for doing protein-protein coevolution.**

The notebook is largely based on the colabfold.com colab for searching the sequence alignment, or you can ignore that bit and manually input the sequence. I have a script for parsing and pairing the sequences as well. So far I have used the final MSA for AF advancedv2 [Coevo analysis](https://arxiv.org/abs/1906.02598) and MSA transformer. I have not put much (none at all) work into making this amenable for everyone, so I am open to criticism. The notebook using MSA Transformer and Colabfold is [here](https://github.com/PabloGalazDavison/Coevo-multiprotein/blob/main/coevolution_PPI.ipynb).


**Update on Fragment generation.**

I have updated to the current perl version (5.38 atm) the [make_fragments.pl](https://github.com/PabloGalazDavison/Coevo-multiprotein/blob/main/make_fragments.pl) master script for making structure fragments for MC sampling in Rosetta. This includes updating a bit of the code of [buildinp_mat.pl](https://github.com/PabloGalazDavison/Coevo-multiprotein/blob/main/buildinp_mat.pl) which should be located inside the ./sparks-x/SPINE-X/bin/ directory where . is your rosetta/main/tools/fragment_tools/ path. Also, I was unable to make this code work with the MPI fragment picker, so I used .static version. In any case it took very little to install and you cannot trust good [Old Robetta](old.robetta.org) to be always online anymore.
