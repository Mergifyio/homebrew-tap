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

## How it stays current

`mergify-cli` releases to PyPI; a scheduled workflow in this tap detects new
versions, opens a bump PR, builds bottles for macOS (arm64/x86_64) and Linux
(arm64/x86_64), and publishes them to GitHub Packages automatically.

## License

Apache-2.0.
