ELM_BIN?=elm
ELM_TEST_BIN?=elm-test

ELMFILES = $(wildcard src/*.elm)

build:
	$(ELM_BIN) make ${ELMFILES} --output=$(DEV_JS)

test:
	elm-test

format:
	elm-format --yes --elm-version=0.19 .
