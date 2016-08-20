
#Compiler to use for the make
cc=clang++
#Location to store object files
DO=obj
#Directory for main binaries
DB=bin
#Directory where source files are
DS=src
#Directory where docs are stored
DD=doc

#Compiler flags to use for debugging
FD=-Wall -g
#Compiler flags to use for object files
FO=-c 
#Compiler Flags to use for binaries
FB=-framework SDL2 

#Tarball output file
TAR_FILE=nes.tar.gz

################################################
# Build Commands
################################################

all: prep nes

#Remove any previously built files
clean:
	#Remove any objects from the object directory
	rm -rf $(DO)

#Removes any files other thatn the source from the directory
purge: clean
	#Remove any binaries from the output directory
	rm -rf $(DB)
	#Remove the source tarball if it exists
	rm -rf $(TAR_FILE)
	#Remove the documentation files
	rm -rf $(DD)

#Create the directory structure required for output
prep:
	#Create the objects directory
	mkdir -p $(DO)
	#Create output directory
	mkdir -p $(DB)

documentation:
	#Generating documentaton
	doxygen Doxyfile

#Tar the project to make it easier to move around
tarball:
	tar -zcvf $(TAR_FILE) Doxyfile Makefile src

################################################
# Executable Binaries
################################################

#Build NES Emulator executable
nes: prep driver.o 
	#Building and linking the Emulator binary
	$(cc) $(FB) -o $(DB)/$@ $(DO)/driver.o 

################################################
# Object Files
################################################

driver.o: $(DS)/driver.cpp
	#Compiling driver object
	$(cc) $(FO) -o $(DO)/$@ $^


