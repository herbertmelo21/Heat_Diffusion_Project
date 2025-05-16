#!/usr/bin/env bash
# run.sh — compile the Fortran code, run the simulation, and generate the animation

set -euo pipefail

# Ensure output directory exists
mkdir -p output

echo "Compiling Fortran sources with OpenMP support..."
make

echo "Running the heat diffusion simulation..."
./heat_diffusion

echo "Generating temperature animation..."
python3 animation.py

echo "All done! Check ./output/output.csv and ./output/temperature_animation.gif"
