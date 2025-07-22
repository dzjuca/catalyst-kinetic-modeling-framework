# Catalyst Performance Evaluation System

[![MATLAB](https://img.shields.io/badge/MATLAB-R2022b+-orange.svg)](https://www.mathworks.com/products/matlab.html)
[![License](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
<!-- [![Chemical Engineering Journal](https://img.shields.io/badge/Publication-Chemical%20Engineering%20Journal-green.svg)](https://doi.org/your-doi-here) -->

## 📋 Overview

This MATLAB system evaluates catalyst performance for methanol synthesis via CO₂ hydrogenation. The program simulates a fixed-bed reactor and calculates key parameters including conversion, selectivity, and catalytic activity. The computational framework has been validated against experimental data and is designed for research applications in heterogeneous catalysis.

<!-- > **Citation**: If you use this code in your research, please cite our publication in *Chemical Engineering Journal* (DOI: to be added upon publication). -->

## 🧪 Chemical Reactions Modeled

The system models three main reactions in the methanol synthesis network:

1. **CO hydrogenation to methanol**: CO + 2H₂ ⇌ CH₃OH
2. **Reverse water-gas shift reaction**: CO₂ + H₂ ⇌ H₂O + CO  
3. **Direct CO₂ hydrogenation to methanol**: CO₂ + 3H₂ ⇌ CH₃OH + H₂O

The kinetic model incorporates competitive adsorption mechanisms and thermodynamic equilibrium constraints based on established literature correlations.

## 📁 File Structure

### Core Files
- **`main.m`** - Main program, processes data and generates comprehensive results
- **`catPerfEvalFcn.m`** - Primary catalyst evaluation function with convergence algorithms
- **`globalDataFcn.m`** - Global constants and reactor configuration parameters

### Kinetic and Thermodynamic Functions
- **`kineticConstantsFcn.m`** - Temperature-dependent kinetic constants calculation
- **`kineticFcn.m`** - Kinetic rate expressions for each chemical species
- **`reactionVelocityFcn.m`** - Reaction rates based on Langmuir-Hinshelwood kinetics
- **`K_eq_Fcn.m`** - Thermodynamic equilibrium constants

### Reactor Model Functions
- **`odeFcn.m`** - Differential equation system for the fixed-bed reactor
- **`initialConditionsFcn.m`** - Initial conditions and feed composition
- **`boundaryFlowFcn.m`** - Inlet flow rate calculations
- **`pressureFcn.m`** - Pressure drop correlation for packed bed
- **`partialPressureFcn.m`** - Species partial pressures

### Analysis and Visualization
- **`xi_Fcn.m`** - Conversion calculations and performance metrics
- **`s_x_Fcn.m`** - Selectivity vs. conversion analysis with curve fitting
- **`createFit.m`** - Smooth spline fitting for data interpolation
- **`g_*.m`** - Plotting functions (conversion, flow, pressure profiles, etc.)

### Utilities
- **`Iterations.m`** - Singleton class for iteration counting and monitoring
- **`x_ghsv_Fcn.m`** - Catalytic activity analysis

## 🔧 Input Data Requirements

### Data File (`dataCat.mat`)
The program requires a structured table with the following experimental columns:

| Column | Description | Units |
|--------|-------------|-------|
| **ID** | Unique experiment identifier | - |
| **REF** | Literature reference | - |
| **Group** | Catalyst - Group clasification | - |
| **CAT** | Catalyst type/composition | - |
| **PMPa** | Reactor pressure | MPa |
| **TC** | Temperature | °C |
| **RH2_CO2** | H₂/CO₂ molar ratio | - |
| **GHSVh1** | Gas hourly space velocity | h⁻¹ |
| **X** | Experimental CO₂ conversion | % |
| **S** | Experimental methanol selectivity | % |

### Data Format Requirements
- All numerical values must be positive
- Temperature range: 200-350°C (validated range)
- Pressure range: 1-8 MPa (typical operating conditions)
- GHSV range: 100-10,000 h⁻¹

## 🚀 System Usage

### Execution
```matlab
% Ensure dataCat.mat is in the working directory
run('main.m')

% Load custom data
load('your_catalyst_data.mat');
results = catPerfEvalFcn(data_table);
```
<!-- 
### Advanced Usage
```matlab
% Load custom data
load('your_catalyst_data.mat');
results = catPerfEvalFcn(data_table);

% Generate specific plots
g_conversion_profile(results);
g_selectivity_analysis(results);
``` -->

### Generated Outputs
- **`results.xlsx`** - Comprehensive results table with calculated parameters
- **`results/` folder** - Individual plots for each experimental condition
- **Key calculated variables**:
  - `K_eq_T`: Theoretical equilibrium constant
  - `K_eq_Aprox`: Approach to the equilibrium
  - `K_eq_R`: Equilibrium constant ratio
  - `Activity`: Catalytic activity factor (a*)
  - `Selectivity`: Selectivity enhancement factor (s*)

## 📊 Model Parameters

### Reactor Specifications
- **Internal diameter**: 0.30 m
- **Height/diameter ratio**: 3
- **Bed porosity**: 0.50
- **Particle porosity**: 0.35
- **Catalyst bulk density**: 1450 kg/m³
- **Average particle radius**: 2×10⁻⁴ m

### Kinetic Parameters
- **Activation energies**: 32.2, 64.7, 25.2 kJ/mol (reactions 1-3)
- **Pre-exponential factors**: Literature-fitted values
- **Adsorption constants**: Temperature-dependent correlations
- **Heat of adsorption**: Species-specific values

## 🔍 Algorithm Features

### Convergence Strategy
1. **Initial verification**: Compares calculated vs. experimental conversion
2. **Adaptive adjustment**: Modifies GHSV to achieve target conversion
3. **Iterative optimization**: Search within 0-85% adjustment factor range
4. **Convergence criteria**: Relative error < 1% for conversion matching

### Numerical Methods
- **ODE solver**: `ode15s` (implicit method for stiff systems)
- **Tolerances**: RelTol = AbsTol = 1×10⁻⁶
- **Constraints**: Non-negative concentrations enforced
- **Jacobian**: Analytical derivatives for improved stability

## 📈 Results Analysis

### Performance Metrics
- **Activity Factor (a\*)**: Ratio of experimental to reference GHSV
- **Selectivity Factor (s\*)**: Experimental to reference selectivity ratio
- **Equilibrium Analysis**: Thermodynamic vs. calculated constants comparison
<!-- - **Space-time yield**: Methanol production rate per catalyst volume -->

### Generated Visualizations
<!-- - Axial conversion profiles along reactor length
- Molar flow evolution through the reactor
- Pressure drop characteristics
- Selectivity-conversion relationships with fitted curves
- Parity plots for model validation -->
The system produces two key diagnostic plots for each catalyst evaluation:
1. **Methanol selectivity vs. CO₂ conversion** (S_CH₃OH vs X_CO₂): Shows the trade-off between conversion and selectivity with fitted curves
2. **CO₂ conversion vs. inverse space velocity** (X_CO₂ vs 1/GHSV): Illustrates the relationship between residence time and conversion performance

## ⚙️ Advanced Configuration

### Parameter Modification
Edit `globalDataFcn.m` to customize:
- Reactor geometry and operating conditions
- Catalyst properties and kinetic parameters
- Thermodynamic correlations
- Numerical solver settings

<!-- ### Custom Analysis
```matlab
% Sensitivity analysis example
temperatures = [200:25:350];
for T = temperatures
    results(T) = catPerfEvalFcn(data, 'Temperature', T);
end
``` -->

### Plot Customization
The `g_*.m` functions allow modification of:
- Figure formatting and export settings
- Line styles, colors, and markers
- Axis labels and legends in multiple languages
- High-resolution output for publication

## 🐛 Troubleshooting

### Common Issues

| Error | Cause | Solution |
|-------|-------|----------|
| **File not found** | Missing `dataCat.mat` | Verify file location and format |
| **Slow convergence** | Stiff system | Adjust ODE solver tolerances |
| **NaN values** | Invalid initial conditions | Check physical parameter ranges |
| **Memory issues** | Large dataset | Reduce integration points or batch process |

### Debugging Tools
- `Iterations` class provides integration progress monitoring
- `odeFcn` includes function call counting
- Automatic range truncation prevents numerical overflow
- Warning messages for boundary condition violations

### Performance Optimization
- Pre-compile functions for repeated use
- Vectorize operations where possible
- Use parallel processing for parameter studies
- Profile code to identify bottlenecks

## 📚 Scientific Background

This computational framework is based on established kinetic models for methanol synthesis reported in:
- Heterogeneous catalysis literature
- Chemical reaction engineering textbooks
- Peer-reviewed journal articles on CO₂ hydrogenation

The implementation follows best practices for:
- Reactor modeling and simulation
- Parameter estimation and validation
- Uncertainty quantification
- Reproducible research standards

## 🤝 Contributing

We welcome contributions to improve this catalyst evaluation system:

### How to Contribute
1. **Report issues**: Provide detailed error descriptions with input data
2. **Suggest enhancements**: Submit feature requests with scientific justification
3. **Code contributions**: Follow MATLAB coding standards and include tests
4. **Documentation**: Help improve comments and user guides

### Development Guidelines
- Maintain backward compatibility
- Include comprehensive error handling
- Document all functions with proper headers
- Validate against experimental benchmarks

## 📄 License

This project is licensed under the MIT License 
<!-- - see the [LICENSE](LICENSE) file for details. -->

<!-- ## 📖 Citation

If you use this software in your research, please cite:

```bibtex
@article{juca2024catalyst,
  title={Catalyst Performance Evaluation System for Methanol Synthesis via CO₂ Hydrogenation},
  author={Juca, Daniel Z.},
  journal={Chemical Engineering Journal},
  year={2024},
  doi={to-be-added},
  url={https://github.com/your-username/catalyst-evaluation-system}
}
``` -->
<!-- 
## 🔗 Related Publications

- Main article in *Chemical Engineering Journal* (in preparation)
- Supporting data and additional analyses available in repository
- Conference presentations and technical reports linked in documentation

--- -->

**Author**: Daniel Zambrano Juca, Ph.D.  
**Affiliation**: Department of Chemical and Environmental Engineering, I3A- University of Zaragoza, Spain
**Contact**: [dzambrano@unizar.es](mailto:dzambrano@unizar.es) | [dzjuca@gmail.com](mailto:dzjuca@gmail.com)  
**Version**: 1.0  
**Last Updated**: June 2025

**Funding**: This research was supported by the Margarita Salas Program for the requalification of the Spanish university system (2021-2023), co-financed by the Spanish Ministry of Universities and the European Union through the NextGeneration EU/Recovery, Transformation and Resilience Plan (PRTR).

**Acknowledgments**: The author acknowledges the CREG research group at I3A and the Reactor Laboratory for providing the computational resources and research environment that made this work possible.