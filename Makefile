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
	npx postject $(BUILD_DIR)\$(PROJECT_NAME).exe NODE_SEA_BLOB $(BUILD_DIR)\$(PROJECT_NAME).blob --sentinel-fuse NODE_SEA_FUSE_fce680ab2cc467b6e072b8b5df1996b2
	signtool sign /fd SHA256 $(BUILD_DIR)\$(PROJECT_NAME).exe
