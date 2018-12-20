ELM_BIN?=elm
ELM_TEST_BIN?=elm-test
DEV_JS=public/game-of-life.js

ELMFILES = $(wildcard src/*.elm)

run: build
	elm reactor

build:
	$(ELM_BIN) make ${ELMFILES} --output=$(DEV_JS)

test:
	elm-test

format:
	elm-format --yes --elm-version=0.19 .
