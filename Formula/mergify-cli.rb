class MergifyCli < Formula
  desc "CLI for stacked PRs, CI insights, merge queue, freezes, and config"
  homepage "https://mergify.com"
  license "Apache-2.0"

  # Plain constant (NOT the `version` DSL): keeps the URLs DRY while Homebrew
  # still auto-detects the version from the version-named asset URL. Declaring
  # `version` here would trip `brew audit --strict`'s "redundant with version
  # scanned from URL" check.
  RELEASE = "2026.11.26".freeze

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/Mergifyio/mergify-cli/releases/download/#{RELEASE}/mergify-#{RELEASE}-aarch64-apple-darwin.tar.gz"
      sha256 "167df42e453d867e88c33cda45570e1585b4821e096d1de868ecee5d9378cc4f"
    end
    on_intel do
      url "https://github.com/Mergifyio/mergify-cli/releases/download/#{RELEASE}/mergify-#{RELEASE}-x86_64-apple-darwin.tar.gz"
      sha256 "fd93324e62766ae177cffae7653ef93c2b7ced2e5e47076740a0223bdad37d87"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/Mergifyio/mergify-cli/releases/download/#{RELEASE}/mergify-#{RELEASE}-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "f7bd3f368223f6e9a8d3a165d06d9def71e66e75a8bbd629182dfd158b12a135"
    end
    on_intel do
      url "https://github.com/Mergifyio/mergify-cli/releases/download/#{RELEASE}/mergify-#{RELEASE}-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "c9a836d8104af7bd793bbd272ffed82740898be184fe7bdcfb564853e610d722"
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
