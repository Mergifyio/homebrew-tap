# Mergify Homebrew Tap

Homebrew tap for the [Mergify CLI](https://github.com/Mergifyio/mergify-cli).

## Install

```shell
brew install mergifyio/tap/mergify
```

Or:

```shell
brew tap mergifyio/tap
brew install mergify
```

## Usage

```shell
mergify --help
```

See the [CLI docs](https://docs.mergify.com/cli/). Commands: `stack`, `ci`,
`tests`, `queue`, `freeze`, `config`.

> **Status:** this tap is being set up. The `mergify` formula and its
> bottle CI are landing via pull requests; `brew install` will work once
> they merge to `main`.

## License

Apache-2.0.
