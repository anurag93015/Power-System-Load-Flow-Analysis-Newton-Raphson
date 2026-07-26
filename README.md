# ⚡ Power System Load Flow Analysis using Newton-Raphson Method

![MATLAB](https://img.shields.io/badge/MATLAB-R2023-blue)
![Power Systems](https://img.shields.io/badge/Power-System-green)
![Numerical Methods](https://img.shields.io/badge/Newton-Raphson-orange)
![License](https://img.shields.io/badge/License-MIT-yellow)

## 📖 Project Overview

Power Flow (Load Flow) Analysis is a fundamental study in power system engineering used to determine the steady-state operating condition of an electrical network. It calculates the voltage magnitude, voltage angle, active power flow, reactive power flow, and transmission losses for each bus in the system.

This project implements the **Newton-Raphson Load Flow Algorithm** in MATLAB for a 3-bus power system. The program automatically constructs the Y-Bus admittance matrix from transmission line data and iteratively solves the nonlinear power flow equations until convergence.

The project is designed with a modular architecture, making it easy to extend to larger IEEE test systems and additional load flow methods.

## ✨ Features

- Automatic Y-Bus matrix formation
- Newton-Raphson iterative load flow solver
- Bus voltage magnitude and angle calculation
- Line power flow computation
- Active and reactive power loss calculation
- Voltage profile visualization
- Automatic result export to text file
- Modular MATLAB implementation

- ## 🚀 Getting Started

### Prerequisites

- MATLAB R2020a or later

### Steps

```matlab
cd Codes
main
```

The simulation will:

- Generate the Y-Bus matrix
- Solve the load flow problem
- Display voltage profile
- Calculate line power flow
- Export results to `Results/load_flow_results.txt`
