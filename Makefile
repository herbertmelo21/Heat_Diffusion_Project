# Makefile for Heat Diffusion Simulation + Animation

# Fortran compiler and flags
FC       = gfortran
FFLAGS   = -O3 -fopenmp

# Source files and executable name
SRC      = main.f90 subroutines.f90
EXE      = heat_diffusion

# Python interpreter and animation script
PYTHON        = python3
ANIM_SCRIPT   = animation.py

# Output files
CSV      = output/output.csv
GIF      = output/temperature_animation.gif

# Default target: compile the Fortran executable
all: $(EXE)

# Build the Fortran program with OpenMP support
$(EXE): $(SRC)
	$(FC) $(FFLAGS) -o $@ $^

# Run both simulation and animation
run: $(EXE)
	@echo Running Fortran simulation...
	./$(EXE)
	@echo Generating animation...
	$(PYTHON) $(ANIM_SCRIPT)
	@echo Done. Check $(GIF)

# Remove compiled objects, modules, executable, and outputs
clean:
	rm -f *.o *.mod $(EXE)
	rm -f $(CSV) $(GIF)

# Full clean: also remove caches or editor junk
distclean: clean
	rm -rf __pycache__ .vscode .DS_Store

.PHONY: all run clean distclean
