BUILD_DIR=.build.dir
INSTALL_DIR=install

all: $(BUILD_DIR) $(INSTALL_DIR)
	cmake -S . -B $(BUILD_DIR)
	cmake --build $(BUILD_DIR)
	cmake --build $(BUILD_DIR) --target install

$(BUILD_DIR):
	mkdir -p $@

$(INSTALL_DIR):
	mkdir -p $@

clean:
	rm -rf $(BUILD_DIR) $(INSTALL_DIR)

.PHONY: all clean
