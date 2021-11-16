# Pharyngeal_Pumping_Analysis_Script_JM2021
Analysis script for studying worm pharyngeal pumping with single worm  - Matlab

Use files from InVivo BioSystems (formerly Nemametrix) single worm EPG system to analyze.
Each condition (1 to 8 conditions) needs to be separated on 3 files per conditions named 'CondX_1', 'CondX_2' and 'Condx_3' where X is a number between 1 and 8\\
\\for a total of 90 worms (can be modified in PPdataClass.m). Files needs to be in the same folder where you execute the scripts.
Wrapper function triggers every script one after the other and may take a while. For a specific plot or test, LoadData.m needs to be first launched before the adequate script.
Number of conditions need change in some of the analysis by adding or removing '%' to ignore/reinstate the proper number of conditions (up to 8).

These scripts were written by Jonathan Millet to make the analysis for the following research paper:
https://www.biorxiv.org/content/10.1101/2021.05.10.443141v3

contact: jonathan.r.m.millet@gmail.com
