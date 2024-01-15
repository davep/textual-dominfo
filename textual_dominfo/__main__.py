"""A simple demonstration of the tool."""

##############################################################################
# Textual imports.
from textual.app import App, ComposeResult
from textual.containers import Horizontal, Vertical, Grid
from textual.widgets import Button, RadioSet, Label

##############################################################################
# Local imports.
from textual_dominfo import DOMInfo


##############################################################################
class DemoApp(App[None]):
    """A demo of DOMInfo."""

    CSS = """
    Grid {
        grid-size: 3 2;
    }

    Label {
        width: 1fr;
        height: 1fr;
        content-align: center middle;
    }

    Button {
        width: 1fr;
    }

    Tooltip {
        max-width: 100%;
    }
    """

    def compose(self) -> ComposeResult:
        """Compose the content of the demo."""
        with Horizontal():
            with Grid():
                for n in range(6):
                    yield Label(f"Label #{n}")
        with Horizontal():
            with Vertical():
                for n in range(6):
                    yield Button(f"Button {n}")
            with Vertical():
                yield RadioSet(*(f"Option {n}" for n in range(6)))
                yield RadioSet(*(f"Option {n}" for n in range(6)))
            with Vertical():
                for n in range(6):
                    yield Button(f"Button {n}")

    def on_mount(self) -> None:
        """Add the DOMInfo once the DOM is mounted."""
        DOMInfo.attach_to(self)


##############################################################################
if __name__ == "__main__":
    DemoApp().run()

### __main__.py ends here
