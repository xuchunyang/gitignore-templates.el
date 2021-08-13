# Create .gitignore using GitHub or gitignore.io API

[![Melpa](https://melpa.org/packages/gitignore-templates-badge.svg)](https://melpa.org/#/gitignore-templates)

An Emacs package for creating .gitignore using API supplied by

- [GitHub](https://docs.github.com/en/rest/reference/gitignore)
- [gitignore.io](https://docs.gitignore.io/use/api)

## Usage

### `M-x gitignore-templates-insert NAME`

Insert .gitignore template for NAME.

### `M-x gitignore-templates-new-file NAME`

Create a .gitignore file for NAME.

## Customization

`M-x customize-group RET gitignore-templates` lists all customizable variables. Using textual GUI customization interface is a recommended way to set user preferences. Any changes will be saved to `$HOME/.emacs`, which usually won't pollute your personal configuration. This is also less error-prone and can avoid possible typos.

### `gitignore-templates-api` (defaults to `gitignore.io`)

API used to get gitignore templates. Should be a symbol and one of
`gitignore.io` and `github`, e.g.,

``` emacs-lisp
(setq gitignore-templates-api 'github)
```

## Proxy Setting

If you're inside company's network, or facing with blocked or unstable connection to those APIs, a proxy setting is just for your need.

Internally, gitignore-templates uses `url` package, which provides methods to enable proxy: `M-x customize-variable RET url-proxy-services`. It's a list of form `protocol url`. For example:

```lisp
(setq url-proxy-services '(("http" . "www.example.com:1234")
                           ("https" . "www.example.com:1234")))
```

Incidentally, if you have your proxy related environment variables set up, Emacs can automatically read them.

## Debug

If you mistype an API or the template required is not found, a proper error message should be printed. But under some situations like the connection is blocked, there is possibility that you only get dump information.

Customize variable `url-debug` using GUI interface. Set to `t`, which means print all. Then check them in buffer `*URL-DEBUG*` after invoking your problematic command.
