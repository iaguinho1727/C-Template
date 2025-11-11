# Basic Makefile for static or shared C library

# Compiler and archiver
CC = g++
AR = ar
ARFLAGS = rcs

# Directories
SRC_DIR = src
OUT_DIR = out
INCLUDE_DIR = include
OBJ_DIR=$(OUT_DIR)/obj
EXECUTABLE_EXTENSION=out
BIN_FOLDER=$(OUT_DIR)/bin
EXECUTABLE_BASENAME = NatoInvaders
# INSTALL_HEADER_DIR=/usr/include/$(EXCUTABLE_BASENAME)
# INSTALL_EXECUTABLE_DIR=/usr/lib/$(EXCUTABLE_BASENAME)

# Library name (without prefix/suffix)

# Choose build type: static or shared (default: static)

# Source and object files
SRC_EXTENSIONS=cpp hpp
SRCS =$(foreach ext,$(SRC_EXTENSIONS),$(wildcard $(SRC_DIR)/*.$(ext)) )
# TEST_DESTINATION=$(OUT_DIR)/tests
# TEST_DIR=tests
# TEST_SRCS=$(wildcard $(TEST_DIR)/*.$(SRC_EXTENSION))
# TEST_EXECUTABLES=$(TEST_SRCS:$(TEST_DIR)/%.$(SRC_EXTENSION)=$(TEST_DESTINATION)/%.$(EXECUTABLE_EXTENSION))

# Common compilation flags
PKG_CONFIG_LIBS=sfml-all
CFLAGS = -g -Wall -Wextra -I$(INCLUDE_DIR) $(shell pkg-config --cflags $(PKG_CONFIG_LIBS))
EXECUTABLE_DESTINATION=$(BIN_FOLDER)/$(EXECUTABLE_BASENAME).$(EXECUTABLE_EXTENSION)
LDFLAGS = $(shell pkg-config --libs $(PKG_CONFIG_LIBS))
# Adjust flags and output name based on build type

# Default target
all: $(EXECUTABLE_DESTINATION)

# --- Build rules ---

# Static library

# Object compilation
$(EXECUTABLE_DESTINATION): $(SRCS) 
	$(CC) $(CFLAGS) $^ $(LDFLAGS) -o $@

# $(TEST_DESTINATION)/%.$(EXECUTABLE_EXTENSION) : $(TEST_DIR)/%.c
# 	$(CC)  $(CFLAGS)  $< $(LDFLAGS) -o $@

# Ensure object directory exists
# $(OUT_DIR):
# 	mkdir -p $(STATIC_EXECUTABLE_DESTINATION) 

# compile_tests: $(TEST_EXECUTABLES)

# test:
# 	sh $(TEST_DIR)/tests.sh




valgrind: 
	valgrind $(EXECUTABLE_DESTINATION)



# install:
# 	mkdir -p $(INSTALL_EXECUTABLE_DIR)
# 	mkdir -p $(INSTALL_HEADER_DIR)
# 	cp $(EXECUTABLE_DESTINATION) $(INSTALL_EXECUTABLE_DIR)
# 	cp $(INCLUDE_DIR)/*.h $(INSTALL_HEADER_DIR)

# Clean up
clean:
	rm  $(BIN_FOLDER)/* $(OBJ_DIR)/*

# Phony targets
.PHONY: all clean valgrind 
