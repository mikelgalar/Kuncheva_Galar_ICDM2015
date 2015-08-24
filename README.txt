

L Kuncheva and M Galar. Theoretical and Empirical Criteria for the Edited Nearest Neighbour Classifier, ICDM 2015

-----------------------------------------------------------------

The code comes without any guarantee.

The folder contains:

=== scripts:
-----------------------------------------------------------------
ToyExample                        - calculates the error for ALL 
                                    possible reference sets 
                                    (*takes 5 hours; use Toy18a*)
CheckDWbound                      - calculates the curves for the 
                                    Devroye-Wagner bound (RHS of
                                    (1))
CheckVCDimension                  - calculates the curves for the 
                                    VC-confidence (2)
AlphaAnalysisToyExample           - calculates the results in 
                                    Table 1
FiguresCurves_ToyExample          - draws Figure 4
FiguresShadedRegions_ToyExample   - draws Figure 3


=== data files:
-----------------------------------------------------------------
Toy18a.mat          - the resultant file from ToyExample
FiguresData.mat     - data for Figures 3 and 4


=== functions:
-----------------------------------------------------------------
gendatcb            - generates a rotated checker-board dataset
train_1nn           - trains 1-nn
test_1nn            - tests 1-nn

test_edited_1nn_loo - tests edited 1-nn with leave-one-out

train_vr            - trains Voronoi classifier
train_vr_refset     - trains a Voronoi classifier with a 
                      specified reference set
test_vr             - tests Voronoi classifier
test_voronoi_loo    - tests Voronoi classifier with leave-one-out

