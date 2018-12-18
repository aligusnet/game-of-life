ELM_BIN?=elm
ELM_TEST_BIN?=elm-test

ELMFILES = $(wildcard src/*.elm)

run: build
	elm reactor

build:
	$(ELM_BIN) make ${ELMFILES} 

test:
	elm-test

format:
	elm-format --yes --elm-version=0.19 .
