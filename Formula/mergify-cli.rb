class MergifyCli < Formula
  desc "CLI for stacked PRs, CI insights, merge queue, freezes, and config"
  homepage "https://mergify.com"
  license "Apache-2.0"

  # Plain constant (NOT the `version` DSL): keeps the URLs DRY while Homebrew
  # still auto-detects the version from the version-named asset URL. Declaring
  # `version` here would trip `brew audit --strict`'s "redundant with version
  # scanned from URL" check.
  RELEASE = "2026.8.11.1".freeze

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/Mergifyio/mergify-cli/releases/download/#{RELEASE}/mergify-#{RELEASE}-aarch64-apple-darwin.tar.gz"
      sha256 "7121e6a371135a9987e6cea36402943c37247cae94ae401158f12df3c3acaa8b"
    end
    on_intel do
      url "https://github.com/Mergifyio/mergify-cli/releases/download/#{RELEASE}/mergify-#{RELEASE}-x86_64-apple-darwin.tar.gz"
      sha256 "79eeae9e40abaddfffa17e7e932d51f1db7c41cc18aa27eef9191446efb803f7"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/Mergifyio/mergify-cli/releases/download/#{RELEASE}/mergify-#{RELEASE}-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "aa764e3f76cf007197f3f7cac47995a432e20080cd0cb196ae21a4c516b82d2d"
    end
    on_intel do
      url "https://github.com/Mergifyio/mergify-cli/releases/download/#{RELEASE}/mergify-#{RELEASE}-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "1f1fb26b333ad7255acb5c31a50127dfc8cbfbf016b6351d7a3ab44045384beb"
    end
  end

  def install
    bin.install "mergify"
    # `mergify completions <shell>` is pure clap introspection (no network),
    # so it's safe to invoke at install time to ship first-class completions.
    generate_completions_from_executable(bin/"mergify", "completions")
  end

  def caveats
    <<~EOS
      This `mergify` is managed by Homebrew — update it with `brew upgrade
      mergify-cli`, not `mergify self-update`, which overwrites the
      Homebrew-managed binary and is reverted on the next `brew upgrade`.
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/mergify --version")
    assert_match "stacked pull requests", shell_output("#{bin}/mergify stack --help 2>&1")
    assert_match "#compdef mergify", shell_output("#{bin}/mergify completions zsh")
  end
end
