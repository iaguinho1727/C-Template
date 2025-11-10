# Basic Makefile for static or shared C library

# Compiler and archiver
CC = gcc
AR = ar
ARFLAGS = rcs

# Directories
SRC_DIR = src
OUT_DIR = out
INCLUDE_DIR = include
LIB_DIR=$(OUT_DIR)/lib
OBJ_DIR=$(OUT_DIR)/obj
EXECUTABLE_EXTENSION=out
LIB_BASENAME = IGStructures
INSTALL_HEADER_DIR=/usr/include/$(LIB_BASENAME)
INSTALL_LIB_DIR=/usr/lib/$(LIB_BASENAME)

# Library name (without prefix/suffix)

# Choose build type: static or shared (default: static)
IS_SHARED ?= 0

# Source and object files
SRCS = $(wildcard $(SRC_DIR)/*.c)
OBJS = $(SRCS:$(SRC_DIR)/%.c=$(OBJ_DIR)/%.o)
TEST_DESTINATION=$(OUT_DIR)/tests
TEST_DIR=tests
TEST_SRCS=$(wildcard $(TEST_DIR)/*.c)
TEST_EXECUTABLES=$(TEST_SRCS:$(TEST_DIR)/%.c=$(TEST_DESTINATION)/%.$(EXECUTABLE_EXTENSION))

# Common compilation flags
CFLAGS = -g -Wall -Wextra -I$(INCLUDE_DIR)
LIB_FILE = lib$(LIB_BASENAME).a
LIB_DESTINATION_FOLDER=$(OUT_DIR)/lib
LIB_DESTINATION=$(LIB_DESTINATION_FOLDER)/$(LIB_FILE)	
LDFLAGS = -l$(LIB_BASENAME) -L$(LIB_DESTINATION_FOLDER)
# Adjust flags and output name based on build type
ifeq ($(IS_SHARED),1)
	CFLAGS += -fPIC
	LIB_FILE = lib$(LIB_BASENAME).so
endif

# Default target
all: $(LIB_DESTINATION) compile_tests

# --- Build rules ---

# Static library
$(LIB_DESTINATION): $(OBJS)
ifeq ($(IS_SHARED),1)
	$(CC) -shared -o $@ $^
else
	$(AR) $(ARFLAGS) $@ $^
endif

# Object compilation
$(OBJ_DIR)/%.o: $(SRC_DIR)/%.c 
	$(CC) $(CFLAGS) -c $< -o $@

$(TEST_DESTINATION)/%.$(EXECUTABLE_EXTENSION) : $(TEST_DIR)/%.c
	$(CC)  $(CFLAGS)  $< $(LDFLAGS) -o $@

# Ensure object directory exists
$(OUT_DIR):
	mkdir -p $(STATIC_LIB_DESTINATION) && mkdir -p $(DYNAMIC_LIB_DESTINATION)

compile_tests: $(TEST_EXECUTABLES)

test:
	sh $(TEST_DIR)/tests.sh




valgrind: 
	valgrind $(EXECUTABLE_PATH)



install:
	mkdir -p $(INSTALL_LIB_DIR)
	mkdir -p $(INSTALL_HEADER_DIR)
	cp $(LIB_DESTINATION) $(INSTALL_LIB_DIR)
	cp $(INCLUDE_DIR)/*.h $(INSTALL_HEADER_DIR)

# Clean up
clean:
	rm -rf $(LIB_DIR)/* $(OBJ_DIR)/* $(TEST_DESTINATION)/*

# Phony targets
.PHONY: all clean test valgrind	install 
