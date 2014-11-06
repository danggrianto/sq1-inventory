ACTIVATE = $(ENVDIR)/bin/activate
APP = app.py
ENVDIR = ./env
FABRIC = $(ENVDIR)/bin/fab
PIP = C_INCLUDE_PATH="/opt/local/include:/usr/local/include" $(ENVDIR)/bin/pip
PIPOPTS=$(patsubst %,-r %,$(wildcard $(HOME)/.requirements.pip requirements.pip)) --index-url=$(PYTHON_INDEX_URL)
PYTHON = $(ENVDIR)/bin/python
PYTHON_INDEX_URL = https://pypi.python.org/simple
PYTHON_VERSION = python3.4
REQUIREMENT = requirements.pip
VIRTUALENV = virtualenv
VIRTUALENVOPTS = --python=$(PYTHON_VERSION)

.PHONY: requirements req virtualenv
requirements:
	@rm -f .req
	$(MAKE) .req

req: .req
.req: $(ENVDIR) requirements.pip
	$(PIP) install $(PIPOPTS)
	@touch .req

virtualenv: $(ENVDIR)
$(ENVDIR):
	$(VIRTUALENV) $(VIRTUALENVOPTS) $(ENVDIR)

server:
	$(PYTHON) $(APP)

clean:
	rm -rf $(ENVDIR)