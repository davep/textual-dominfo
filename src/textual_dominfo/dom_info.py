"""Provides a DOM info debug renderable."""

##############################################################################
# Python imports.
from typing import Any

##############################################################################
# Rich imports.
from rich.console import Group
from rich.rule import Rule

##############################################################################
# Textual imports.
from textual.app import App
from textual.widget import Widget


##############################################################################
class DOMInfo:
    """A renderable that shows a widget's DOM information.

    Designed to be installed as the tooltip for widgets in the DOM.
    """

    def __init__(self, widget: Widget) -> None:
        """Initialise the DOM info renderable.

        Args:
            widget: The widget to show the information for.
        """
        self._widget = widget
        """The widget we're showing information about."""

    def __rich__(self) -> Group:
        """The Rich representation of the widget's DOM information."""
        return Group(
            Rule("DOM hierarchy"),
            "\n".join(f"{node!r}" for node in self._widget.ancestors_with_self),
            Rule("Dimensions"),
            f"Container: {self._widget.container_size}",
            f"Content: {self._widget.content_size}",
            Rule("CSS"),
            self._widget.styles.css,
            Rule(),
        )

    @classmethod
    def attach_to(cls, widget: Widget | App[Any]) -> None:
        """Attach the `DOMInfo` to a widget and all its offspring.

        Args:
            widget: The node to attach to.
        """
        if isinstance(widget, App):
            widget = widget.screen
        for node in (widget, *widget.query("*")):
            node.tooltip = cls(node)


### dom_info.py ends here
