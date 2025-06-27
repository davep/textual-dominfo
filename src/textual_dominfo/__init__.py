"""A library that provides a simple DOM node info tootip debug tool."""

##############################################################################
# Python imports.
from importlib.metadata import version

######################################################################
# Main app information.
__author__ = "Dave Pearson"
__copyright__ = "Copyright 2024-2025, Dave Pearson"
__credits__ = ["Dave Pearson"]
__maintainer__ = "Dave Pearson"
__email__ = "davep@davep.org"
__version__ = version("textual_dominfo")
__licence__ = "GPLv3+"

##############################################################################
# Local imports.
from .dom_info import DOMInfo

##############################################################################
# Export the imports.
__all__ = ["DOMInfo"]

### __init__.py ends here
