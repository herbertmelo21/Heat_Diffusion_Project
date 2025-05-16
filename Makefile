# Makefile for Heat Diffusion Simulation + Animation

# Fortran compiler and flags
FC     = gfortran
FFLAGS = -O3 -fopenmp

# Sources
MODULE_SRC = subroutines.f90
MAIN_SRC   = main.f90

# Object files (order matters: module first)
OBJS    = subroutines.o main.o
EXE     = heat_diffusion

# Python animation script
PYTHON      = python3
ANIM_SCRIPT = animation.py

# Output artifacts
CSV = output/output.csv
GIF = output/temperature_animation.gif

# Default target: build executable
all: $(EXE)

# 1) Compile the module (produces diffusion.mod + subroutines.o)
subroutines.o: $(MODULE_SRC)
	$(FC) $(FFLAGS) -c $<

# 2) Compile the main program (depends on diffusion.mod)
main.o: $(MAIN_SRC) subroutines.o
	$(FC) $(FFLAGS) -c $<

# 3) Link the executable
$(EXE): $(OBJS)
	$(FC) $(FFLAGS) -o $@ $^

# Run both the Fortran simulation and the Python animation
run: $(EXE)
	@echo "Running Fortran simulation..."
	./$(EXE)
	@echo "Generating animation..."
	$(PYTHON) $(ANIM_SCRIPT)
	@echo "Done. See $(GIF)"

# Remove compiled and generated files
clean:
	rm -f *.o *.mod $(EXE)
	rm -f $(CSV) $(GIF)

.PHONY: all run clean
