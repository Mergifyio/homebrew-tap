# Mergify Homebrew Tap

Homebrew tap for the [Mergify](https://mergify.com) CLI — stacked pull
requests, CI insights, merge queue, scheduled freezes, and config management.

## Install

```shell
brew install mergifyio/tap/mergify-cli
```

The fully-qualified name taps and installs in one step. Then run `mergify --help`.

> **Homebrew 6.0 tap trust.** Since Homebrew 6.0, third-party taps must be
> trusted before their code runs. Installing by the **fully-qualified** name
> above trusts just this formula, so the command works as-is. To instead add
> the tap and install by short name, trust it once:
>
> ```shell
> brew tap mergifyio/tap
> brew trust mergifyio/tap
> brew install mergify-cli
> ```
>
> See [Homebrew Tap Trust](https://docs.brew.sh/Tap-Trust).

## Updating

```shell
brew upgrade mergify-cli
```

Manage it with Homebrew, **not** `mergify self-update` — self-update overwrites
the Homebrew-managed binary and is reverted on the next `brew upgrade`.

## Maintainers

The formula is `Formula/mergify-cli.rb`. To ship a new CLI version, bump the
`RELEASE` constant and the four `sha256`s, then open a PR — the merge queue
tests all four platforms and merges on green.

## License

Apache-2.0.
