#	-- cpp-template --
#
#	cpp-template's project Makefile.
#
#	Utilization example:
#		make [<target>] [DFLAG=true]
#
#	@param target
#		Can be any of the following:
#		all - compiles.
#		clean - cleans up all binaries generated during compilation.
#		redo - cleans up and then compiles.
#		print-<var> - prints the content of the Makefile variable
#                             (example: make print-OBJ).
#
#	@param "DFLAG=true"
#		When present, the compilation will happen in debug mode.
#
#	Make's default action is "all", when no parameters are provided.


################################################################################
#	Definitions:

#	-- Project's directories
INC_DIR := include
OBJ_DIR := bin
OUT_DIR := build
SRC_DIR := src
LIB_DIR := lib

DFLAG :=

#	-- Compilation flags
#	Compiler and language version
CC := g++ -std=c++17
#	If DFLAG is defined, we'll turn on the debug flag and attach address
#	sanitizer on the executables.
DEBUG := $(if $(DFLAG),-g -fsanitize=address)
CFLAGS :=\
	-Wall \
	-Wextra \
	-Wpedantic\
	-Wshadow \
	-Wunreachable-code
OPT := $(if $(DFLAG),-O0,-O3)
LIB := -L$(LIB_DIR)
INC := -I$(INC_DIR)

# Put here any dependencies you wish to include in the project, according to the
# following format:
# "<name> <URL> [<URL> ...]" "<name> <URL> [<URL> ...]" ...
DEPS :=

################################################################################
#	Files:

#	-- Main source files
#	Presumes that all "main" source files are in the root of SRC_DIR
MAIN := $(wildcard $(SRC_DIR)/*.cpp)

#	-- Path to all final binaries
TARGET := $(patsubst %.cpp, $(OUT_DIR)/%, $(notdir $(MAIN)))

#	-- Other source files
SRC := $(filter-out $(MAIN), $(shell find $(SRC_DIR) -name '*.cpp'))

#	-- Objects to be created
OBJ := $(patsubst %.cpp, $(OBJ_DIR)/%.o, $(notdir $(SRC)))

################################################################################
#	Rules:

#	-- Executables
$(TARGET): $(OUT_DIR)/%: $(SRC_DIR)/%.cpp $(OBJ)
	$(CC) -o $@ $^ $(INC) $(LIB) $(DEBUG) $(OPT)

#	-- Objects
$(OBJ_DIR)/%.o:
	$(CC) -c -o $@ $(filter %/$*.cpp, $(SRC)) $(INC) $(CFLAGS) $(DEBUG) $(OPT)

################################################################################
#	Targets:

.DEFAULT_GOAL = all

all: deps $(TARGET)

deps:
	@./scripts/build.sh '$(DEPS)'

clean:
	rm -f $(OBJ_DIR)/*.o $(INC_DIR)/*~ $(TARGET) *~ *.o

redo: clean all

#	Debug of the Make variables
print-%:
	@echo $* = $($*)

.PHONY: all clean redo print-%
