# SRTT_analysis
MATLAB scripts for the analysis of **Serial Reaction Time Task performance**, as performed in Rakowska et al. (2021)[^1] and (2022)[^2]

These scripts get the reaction time and error rate per block of the SRTT. Hands can be analysed together (BH) or separately (LH/RH). Separate result files are created for the reactivated and non-reactivated blocks. Trials with reaction time > 1000 ms were excluded from the reaction time analysis; trials with incorrect button presses prior to the correct ones remain.

This repository contains 4 scripts:
- SRTT_reactiontime4BH.m - SRTT reaction time analysis for all (both-hands) trials
- SRTT_reactiontime4LHRH.m - SRTT reaction time analysis for left- and right- hand trials
- SRTT_errorrate4BH.m - SRTT error rate analysis for all (both-hands) trials
- SRTT_errorrate4LHRH.m - SRTT error rate analysis for left- and right- hand trials

## Requirements
The pipeline requires an ALL_subjects.txt file with particpant IDs listeted, one per row.

## Authors and contributors
* Martyna Rakowska

### References:

[^1]: Rakowska, M., Abdellahi, M. E., Bagrowska, P., Navarrete, M., & Lewis, P. A. (2021). Long term effects of cueing procedural memory reactivation during NREM sleep. NeuroImage, 244, 118573.

[^2]: Rakowska, M., Bagrowska, P., Lazari, A., Navarrete, M., Abdellahi, M. E., Johansen-Berg, H., & Lewis, P. A. (2022). Cueing motor memory reactivation during NREM sleep engenders learning-related changes in precuneus and sensorimotor structures. bioRxiv.
