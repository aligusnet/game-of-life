ELM_BIN?=elm
ELM_TEST_BIN?=elm-test
DEV_JS=public/game-of-life.js
RELEASE_JS=public/game-of-life.min.js

ELMFILES = $(wildcard src/*.elm)

run: build
	elm reactor

build:
	$(ELM_BIN) make ${ELMFILES} --output=$(DEV_JS)

test:
	elm-test

format:
	elm-format --yes --elm-version=0.19 .

# npm install uglify-js -g
release:
	$(ELM_BIN) make ${ELMFILES} --output=$(RELEASE_JS) --optimize
	uglifyjs $(RELEASE_JS) --compress 'pure_funcs="F2,F3,F4,F5,F6,F7,F8,F9,A2,A3,A4,A5,A6,A7,A8,A9",pure_getters,keep_fargs=false,unsafe_comps,unsafe' | uglifyjs --mangle --output=$(RELEASE_JS)
