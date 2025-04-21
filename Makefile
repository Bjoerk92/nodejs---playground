SHELL=cmd
PROJECT_NAME = myFirst
BUILD_DIR = build

build : Bundle createSea Node InjectCode SignCode

cleanBuild: clean build 

clean:
	rmdir .\$(BUILD_DIR)\ /s
		
Bundle:
	mkdir $(BUILD_DIR)
	ncc build $(PROJECT_NAME).js -o $(BUILD_DIR)

createSea:
	node --experimental-sea-config sea-config.json

Node:
	copy "C:\Program Files\nodejs\node.exe" $(BUILD_DIR)
	ren $(BUILD_DIR)\node.exe $(PROJECT_NAME).exe
	signtool remove /s $(BUILD_DIR)\$(PROJECT_NAME).exe

InjectCode:
	npx postject $(BUILD_DIR)\$(PROJECT_NAME).exe NODE_SEA_BLOB $(BUILD_DIR)\$(PROJECT_NAME).blob --sentinel-fuse NODE_SEA_FUSE_fce680ab2cc467b6e072b8b5df1996b2
	

SignCode:
	signtool sign /a /fd SHA256 .\$(BUILD_DIR)\$(PROJECT_NAME).exe