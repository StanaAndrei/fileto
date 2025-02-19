# Compiler settings
HC = ghc
HFLAGS = --make

# Executable names
TEMP_NAME = main
TARGET = exec.exe

.PHONY: all clean

all:
	cd src && $(HC) $(HFLAGS) main.hs
	cd src && mv $(TEMP_NAME) $(TARGET)
	mv src/$(TARGET) .

clean:
	find . -type f -name "*.hi" -delete
	find . -type f -name "*.o" -delete

clean-exe:
	rm $(TARGET)