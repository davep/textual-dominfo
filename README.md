# Textual DOMInfo

## Introduction

This library provides a very simple debugging aid for Textual applications;
designed as a very quick and easy "what widget is under the mouse and how is
it styled" tool.

**TO BE CLEAR:** This isn't a full-blown DOM inspection tool; it's not even
close. It's a quick and dirty but handy bit of code to quickly check what
part of the terminal display belongs to what underlying widget and to see
how it's styled.

## Installing

The package can be installed with `pip` or related tools, for example:

```sh
$ pip install textual-dominfo
```

## Using

As mentioned above, this is only ever intended to be used when trying to
debug something, and also note that it will take over [the
tooltips](https://textual.textualize.io/guide/widgets/#tooltips) of any
widgets it is attached to.

To use, import the class:

```python
from textual_dominfo import DOMInfo
```

and then in your code somewhere, probably in the `on_mount` method of your
application or main screen, attach it like this:

```python
DOMInfo.attach_to(self)
```

This will then install the information tooltip in that widget and all of its
descendants.

To see this in action right away, with the library installed into your
development environment, do this:

```sh
$ python -m textual_dominfo
```

![The library in action](https://raw.githubusercontent.com/davep/textual-dominfo/main/images/textual-dominfo.png)

[//]: # (README.md ends here)
