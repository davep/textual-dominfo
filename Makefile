lib      := textual_dominfo
src      := src/
run      := rye run
test     := rye test
python   := $(run) python
lint     := rye lint -- --select I
fmt      := rye fmt
mypy     := $(run) mypy
mkdocs   := $(run) mkdocs
spell    := $(run) codespell

##############################################################################
# Local "interactive testing" of the code.
.PHONY: run
run:				# Run the code in a testing context
	$(python) -m $(lib)

.PHONY: debug
debug:				# Run the code with Textual devtools enabled
	TEXTUAL=devtools make

.PHONY: console
console:			# Run the textual console
	$(run) textual console

##############################################################################
# Setup/update packages the system requires.
.PHONY: setup
setup:				# Set up the repository for development
	rye sync
	$(run) pre-commit install

.PHONY: update
update:				# Update all dependencies
	rye sync --update-all

.PHONY: resetup
resetup: realclean		# Recreate the virtual environment from scratch
	make setup

##############################################################################
# Checking/testing/linting/etc.
.PHONY: lint
lint:				# Check the code for linting issues
	$(lint) $(src)

.PHONY: codestyle
codestyle:			# Is the code formatted correctly?
	$(fmt) --check $(src)

.PHONY: typecheck
typecheck:			# Perform static type checks with mypy
	$(mypy) --scripts-are-modules $(src)

.PHONY: stricttypecheck
stricttypecheck:	        # Perform a strict static type checks with mypy
	$(mypy) --scripts-are-modules --strict $(src)

.PHONY: spellcheck
spellcheck:			# Spell check the code
	$(spell) *.md $(src) $(docs)

.PHONY: checkall
checkall: spellcheck codestyle lint stricttypecheck # Check all the things

##############################################################################
# Documentation.
.PHONY: docs
docs:                           # Generate the system documentation
	$(mkdocs) build

.PHONY: rtfm
rtfm:                           # Locally read the library documentation
	$(mkdocs) serve

.PHONY: publishdocs
publishdocs:			# Set up the docs for publishing
	$(mkdocs) gh-deploy

##############################################################################
# Package/publish.
.PHONY: package
package:			# Package the library
	rye build

.PHONY: spackage
spackage:			# Create a source package for the library
	rye build --sdist

.PHONY: testdist
testdist: package			# Perform a test distribution
	rye publish --yes --skip-existing --repository testpypi --repository-url https://test.pypi.org/legacy/

.PHONY: dist
dist: package			# Upload to pypi
	rye publish --yes --skip-existing

##############################################################################
# Utility.
.PHONY: repl
repl:				# Start a Python REPL in the venv.
	$(python)

.PHONY: delint
delint:			# Fix linting issues.
	$(lint) --fix $(src)

.PHONY: pep8ify
pep8ify:			# Reformat the code to be as PEP8 as possible.
	$(fmt) $(src)

.PHONY: tidy
tidy: delint pep8ify		# Tidy up the code, fixing lint and format issues.

.PHONY: clean-packaging
clean-packaging:		# Clean the package building files
	rm -rf dist

.PHONY: clean-docs
clean-docs:			# Clean up the documentation building files
	rm -rf site .screenshot_cache

.PHONY: clean
clean: clean-packaging clean-docs # Clean the build directories

.PHONY: realclean
realclean: clean		# Clean the venv and build directories
	rm -rf .venv

.PHONY: help
help:				# Display this help
	@grep -Eh "^[a-z]+:.+# " $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.+# "}; {printf "%-20s %s\n", $$1, $$2}'

##############################################################################
# Housekeeping tasks.
.PHONY: housekeeping
housekeeping:			# Perform some git housekeeping
	git fsck
	git gc --aggressive
	git remote update --prune

### Makefile ends here
