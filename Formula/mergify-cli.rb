class MergifyCli < Formula
  desc "CLI for stacked PRs, CI insights, merge queue, freezes, and config"
  homepage "https://mergify.com"
  license "Apache-2.0"

  # Plain constant (NOT the `version` DSL): keeps the URLs DRY while Homebrew
  # still auto-detects the version from the version-named asset URL. Declaring
  # `version` here would trip `brew audit --strict`'s "redundant with version
  # scanned from URL" check.
  RELEASE = "2026.11.15".freeze

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/Mergifyio/mergify-cli/releases/download/#{RELEASE}/mergify-#{RELEASE}-aarch64-apple-darwin.tar.gz"
      sha256 "bd16643ba7f78c47c5b50cdc988bbcf22d76165ec2a22034e095ea3d423e7fbf"
    end
    on_intel do
      url "https://github.com/Mergifyio/mergify-cli/releases/download/#{RELEASE}/mergify-#{RELEASE}-x86_64-apple-darwin.tar.gz"
      sha256 "a629ba77590e912ce0b3561476b29969987e3ea6531949a8557b8df15161289c"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/Mergifyio/mergify-cli/releases/download/#{RELEASE}/mergify-#{RELEASE}-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "290b628f7c7b4f0a32a5b01bf508c72c3420083d116b846c727af505de004fdc"
    end
    on_intel do
      url "https://github.com/Mergifyio/mergify-cli/releases/download/#{RELEASE}/mergify-#{RELEASE}-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "08ef34ed4676ca744ef67daddbdc8106ca90943e520245b4c4e62b0818f4718e"
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
