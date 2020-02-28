# gitignore-templates.el - Create .gitignore using GitHub or gitignore.io API

[![Melpa](https://melpa.org/packages/gitignore-templates-badge.svg)](https://melpa.org/#/gitignore-templates)

An Emacs package for creating .gitignore using GitHub or gitignore.io API

- https://developer.github.com/v3/gitignore/
- https://www.gitignore.io/

## Usage

### `M-x gitignore-templates-insert NAME`

Insert .gitignore template for NAME.

### `M-x gitignore-templates-new-file NAME`

Create a .gitignore file for NAME.

## Customize

### `gitignore-templates-api` (defaults to `gitignore.io`)

API used to get gitignore templates. Should be a symbol and one of
`gitignore.io` and `github`, e.g.,

``` emacs-lisp
(setq gitignore-templates-api 'github)
```
