class MergifyCli < Formula
  desc "CLI for stacked PRs, CI insights, merge queue, freezes, and config"
  homepage "https://mergify.com"
  license "Apache-2.0"

  # Plain constant (NOT the `version` DSL): keeps the URLs DRY while Homebrew
  # still auto-detects the version from the version-named asset URL. Declaring
  # `version` here would trip `brew audit --strict`'s "redundant with version
  # scanned from URL" check.
  RELEASE = "2026.7.8.1".freeze

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/Mergifyio/mergify-cli/releases/download/#{RELEASE}/mergify-#{RELEASE}-aarch64-apple-darwin.tar.gz"
      sha256 "709690d0780b1a963932456d6274db7fe55a3973d7679ba291ccfc9b1f4f6385"
    end
    on_intel do
      url "https://github.com/Mergifyio/mergify-cli/releases/download/#{RELEASE}/mergify-#{RELEASE}-x86_64-apple-darwin.tar.gz"
      sha256 "447da15bedc7a14fa3a8f6a9c3bf18e699c38c1cf148d3d5ddc6e7e53d55dcb3"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/Mergifyio/mergify-cli/releases/download/#{RELEASE}/mergify-#{RELEASE}-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "516b562a0c5a7037264c058bab5f45687b0fb20a3bf5348fc6e38e3c265694ab"
    end
    on_intel do
      url "https://github.com/Mergifyio/mergify-cli/releases/download/#{RELEASE}/mergify-#{RELEASE}-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "bcda9d8138df71dd302aee924749d98fb360568c939af6cc9197644915097543"
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
