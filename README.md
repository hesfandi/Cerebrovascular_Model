
# Cerebrovascular Model: Design, Simulation, and Analysis Framework

## Overview
This repository contains MATLAB scripts for the in-silico design and simulation of a segmented cerebrovascular model, as described in "Depth-Dependent Contributions of Various Vascular Zones to Cerebral Autoregulation and Functional Hyperemia." The framework provides a platform for exploring the cerebral blood flow regulatory system.

## Repository Contents
1. **Cerebrovascular_Model/**
   - Contains scripts for the design of the cerebrovascular model and a saved version of the final design for immediate use.

2. **Autoregulation_FH/**
   - Core simulation scripts for modeling:
     - **`Model_Optimization.m`**: Optimizes the cerebrovascular model in its maximum dilation state.
     - **`Save_Autoregulation.m`**: Models both monophasic and biphasic autoregulation in the designed vasculature.
     - **`Save_FH_BC70.m`**: Simulates changes in cerebral blood flow (CBF) in response to 30% myogenic inhibition, as described in the study.
       - **Note**: Scripts prefixed with "Save" generate simulation outputs but do not analyze or plot results.

3. **Analysis/**
   - Includes example scripts (prefixed with `Run_`) for analyzing and plotting simulation results. These scripts provide guidance for interpreting the outputs of the cerebrovascular model.

4. **Hemodynamic_Analysis/**
   - Contains scripts for simulating blood circulation within the designed cerebrovascular model.

## Usage Instructions
1. **Software Requirements**
   - Tested on **MATLAB 2020b**. Should work on other versions of MATLAB without additional dependencies.

2. **Running Simulations**
   - Use the scripts in the `Autoregulation_FH/` folder for simulations.
   - Save output variables with `Save_Autoregulation.m` or `Save_FH_BC70.m`.

3. **Analyzing Results**
   - Refer to the `Analysis/` folder for example scripts to analyze simulation outputs.

## Citation
If you use these scripts in your research, please cite the associated publication:
Esfandi, H., Javidan, M., Anderson, R. M., & Pashaie, R. . Depth-Dependent Contributions of Various Vascular Zones to Cerebral Autoregulation and Functional Hyperemia: An In-Silico Analysis. Journal Name. [DOI Placeholder]

## License
This code is shared under the **MIT License**. For details, please refer to the LICENSE file in this repository.

## Contact
For questions or issues, please contact:hadi.esfandi@gmail.com


