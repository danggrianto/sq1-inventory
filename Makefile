ENVDIR = ./env
PIP = C_INCLUDE_PATH="/opt/local/include:/usr/local/include" $(ENVDIR)/bin/pip
PYTHON_VERSION = python3.4
PYPI = https://pypi.python.org/simple
REQUIREMENT = requirements.txt

environment:
	virtualenv $(ENVDIR) --python=$(PYTHON_VERSION)

requirements: environment
	$(PIP) install --index-url=$(PYPI) -r $(REQUIREMENT)
