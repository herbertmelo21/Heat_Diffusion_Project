# Makefile for Heat Diffusion Simulation + Animation

# Compiler and flags
FC = gfortran
FFLAGS = -O3 -fopenmp
SRC = main.f90 subroutines.f90
EXE = heat_diffusion

# Python script
PYTHON = python3
ANIM_SCRIPT = animation.py

# Output files
CSV = output/output.csv
GIF = output/temperature_animation.gif

# Default target
all: $(EXE)

# Compile Fortran code
$(EXE): $(SRC)
	$(FC) $(FFLAGS) -o $@ $^

# Run simulation + animation
run: $(EXE)
	@echo "🔧 Running Fortran simulation..."
	./$(EXE)
	@echo "🎞 Generating animation..."
	$(PYTHON) $(ANIM_SCRIPT)
	@echo "✅ Done! Output: $(GIF)"

# Clean build and output files
clean:
	rm -f *.o *.mod $(EXE)
	rm -f $(CSV) $(GIF)

# Clean everything, including intermediate files
distclean: clean
	rm -rf __pycache__ .vscode .DS_Store

.PHONY: all clean distclean run
