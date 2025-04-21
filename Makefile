PROJECT_NAME = myFirst
BUILD_DIR = build

all : Bundle createSea Node InjectCode | $(BUILD_DIR)

$(BUILD_DIR):
	mkdir $(BUILD_DIR)

Bundle:
	ncc build $(PROJECT_NAME).js -o $(BUILD_DIR)

createSea:
	node --experimental-sea-config sea-config.json

Node:
	
	copy "C:\Program Files\nodejs\node.exe" $(BUILD_DIR)
	ren $(BUILD_DIR)\node.exe $(PROJECT_NAME).exe
	signtool remove /s $(BUILD_DIR)\$(PROJECT_NAME).exe

InjectCode: Bundle Node | createSea
	npx postject hello NODE_SEA_BLOB sea-config.blob

