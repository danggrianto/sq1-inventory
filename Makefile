ACTIVATE = $(ENVDIR)/bin/activate
APP = $(MODULE)/app.py
ENVDIR = ./env
FABRIC = $(ENVDIR)/bin/fab
MODULE = src
NOSE = $(ENVDIR)/bin/nosetests
PIP = C_INCLUDE_PATH="/opt/local/include:/usr/local/include" $(ENVDIR)/bin/pip
PIPOPTS=$(patsubst %,-r %,$(wildcard $(HOME)/.requirements.pip requirements.txt)) --index-url=$(PYTHON_INDEX_URL)
PYTHON = $(ENVDIR)/bin/python
PYTHON_INDEX_URL = https://pypi.python.org/simple
PYTHON_VERSION = python2.7
REQUIREMENT = requirements.txt
TESTS = tests
VIRTUALENV = virtualenv
VIRTUALENVOPTS = --python=$(PYTHON_VERSION)

.PHONY: requirements req virtualenv
requirements:
	@rm -f .req
	$(MAKE) .req

req: .req
.req: $(ENVDIR) $(REQUIREMENT)
	$(PIP) install $(PIPOPTS)
	@touch .req

virtualenv: $(ENVDIR)
$(ENVDIR):
	$(VIRTUALENV) $(VIRTUALENVOPTS) $(ENVDIR)

server: $(ENVDIR) .req
	$(PYTHON) $(APP)

test: $(ENVDIR) .req
	$(NOSE) --cover-package=$(MODULE) --tests=tests/$*

clean:
	rm .coverage

clean-all:
	rm -rf $(ENVDIR)