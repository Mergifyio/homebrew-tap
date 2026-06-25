class MergifyCli < Formula
  desc "CLI for stacked PRs, CI insights, merge queue, freezes, and config"
  homepage "https://mergify.com"
  license "Apache-2.0"

  # Plain constant (NOT the `version` DSL): keeps the URLs DRY while Homebrew
  # still auto-detects the version from the version-named asset URL. Declaring
  # `version` here would trip `brew audit --strict`'s "redundant with version
  # scanned from URL" check.
  RELEASE = "2026.6.25.1".freeze

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/Mergifyio/mergify-cli/releases/download/#{RELEASE}/mergify-#{RELEASE}-aarch64-apple-darwin.tar.gz"
      sha256 "008ec6b4d62f10ee0eee1bb53cff30af0f778481e6894be9be6f2fad0d99b992"
    end
    on_intel do
      url "https://github.com/Mergifyio/mergify-cli/releases/download/#{RELEASE}/mergify-#{RELEASE}-x86_64-apple-darwin.tar.gz"
      sha256 "1fb1b4b56b2c13bc3c259d64ff46b1e4d1e83fd41b35395e69c796b27912cacd"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/Mergifyio/mergify-cli/releases/download/#{RELEASE}/mergify-#{RELEASE}-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "675c8f06fe87a9cdfa68c3f60586350f8207b349d7635a8998ccc999a9cce905"
    end
    on_intel do
      url "https://github.com/Mergifyio/mergify-cli/releases/download/#{RELEASE}/mergify-#{RELEASE}-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "3df13aac5c39c64c91de49125f59b3b0cc2fd182d11fb7c6264cf3df8457e888"
    end
  end

  def install
    bin.install "mergify"
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
  end
end
