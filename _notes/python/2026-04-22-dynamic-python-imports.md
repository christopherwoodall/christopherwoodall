---
layout: post
title: "Dynamic Python Imports"
date: 2026-04-22
tags: [ "python", "imports", "dynamic" ]
---

## Structuring Python Imports: From Explicit to Dynamic Methods

When organizing a Python project into packages and sub-packages, managing imports can sometimes be confusing. A common hurdle developers face is encountering an `AttributeError` when trying to access a submodule through its parent package (e.g., `core_app.plugins.docker`).

This happens because importing a directory only executes its `__init__.py` file; it does not automatically load nested submodules into memory or attach them as attributes.

Here is a summary of four methods to handle package imports, ranging from explicit approaches to fully dynamic solutions.

### 1. Direct Imports (The Standard Approach)
The most straightforward approach is to leave your `__init__.py` files empty. Instead of routing through the parent package, you import the exact module you need directly into the file where it will be used.

**Implementation:**
Leave `core_app/plugins/__init__.py` empty.

**Usage:**
```python
from core_app.plugins import docker

print(docker.run())
```
* **Pros:** No boilerplate code, perfect IDE support (autocompletion and static analysis), highly readable.
* **Cons:** Slightly longer import statements in your operational files.

---

### 2. The Facade Pattern (Explicit Wiring)
If you prefer the dot-notation syntax (e.g., `plugins.docker`), you must explicitly expose the submodule inside the parent package's `__init__.py`. This acts as an API gateway.

**Implementation (`core_app/plugins/__init__.py`):**
```python
from . import docker

__all__ = [
    "docker",
]
```

**Usage:**
```python
from core_app import plugins

print(plugins.docker.run())
```
* **Pros:** Creates a clean, public-facing API for your package and hides internal structure.
* **Cons:** Requires manual updating of the `__init__.py` file every time you add or remove a module.

---

### 3. True Dynamic Loading (The `pkgutil` Way)
If you want to avoid updating the `__init__.py` file altogether, you can write a dynamic script to auto-discover and load every Python file in the directory.

**Implementation (`core_app/plugins/__init__.py`):**
```python
import importlib
import pkgutil

__all__ = []

for loader, module_name, is_pkg in pkgutil.iter_modules(__path__):
    module = importlib.import_module(f".{module_name}", package=__name__)
    globals()[module_name] = module
    __all__.append(module_name)
```
* **Pros:** Zero maintenance; any new file dropped into the folder is instantly exposed as `plugins.module_name`.
* **Cons:** Breaks IDE autocompletion and static type checkers (like `mypy`), as editors cannot read dynamic runtime loops.

---

### 4. Lazy Loading (The `__getattr__` Way)
Using a feature introduced in Python 3.7, you can define a module-level `__getattr__` function. This allows you to keep the dot-notation syntax without loading all modules upfront. Modules are only imported at the exact moment they are called.

**Implementation (`core_app/plugins/__init__.py`):**
```python
import importlib

__all__ = ["docker", "kubernetes", "local"]

def __getattr__(name):
    if name in __all__:
        return importlib.import_module(f".{name}", package=__name__)
    raise AttributeError(f"module {__name__!r} has no attribute {name!r}")
```
* **Pros:** Excellent performance for heavy codebases since modules are lazy-loaded on demand.
* **Cons:** Still requires manual updates to the `__all__` list, and static analysis support can be inconsistent depending on your editor's capabilities.

---

### Conclusion
For most codebases, **Method 1 (Direct Imports)** or **Method 2 (Facade Pattern)** are the standard recommendations. They preserve code readability and ensure your editor's tooling functions correctly. While dynamic methods (3 and 4) are powerful, they should be used carefully, as sacrificing static analysis often costs more time in long-term maintenance than it saves in initial typing.