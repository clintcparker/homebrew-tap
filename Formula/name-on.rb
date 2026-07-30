# Homebrew formula TEMPLATE for name-on — do not copy to the tap by hand.
# To use: brew install clintcparker/tap/name-on
#
# The "homebrew" job in .github/workflows/release-cli.yml renders this file on
# every release: it substitutes the version and per-platform sha256
# placeholders below (computed from the assets attached to the GitHub Release)
# and commits the result to clintcparker/homebrew-tap as Formula/name-on.rb.
# The render step fails the release if any placeholder is missing here or
# survives into the rendered output.

class NameOn < Formula
  desc "Generate unique, human-readable names (adjective-noun-number)"
  homepage "https://github.com/clintcparker/name-on"
  license "MIT"
  version "1.0.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/clintcparker/name-on/releases/download/v1.0.0/name-on-osx-arm64.tar.gz"
      sha256 "b95d3f14229a170c8f994980d853facfd55cdc400cc4d907d80c335c9f5f1ca0"
    else
      url "https://github.com/clintcparker/name-on/releases/download/v1.0.0/name-on-osx-x64.tar.gz"
      sha256 "64e7dd96143524d2d11b276d5ca63285537df06739057683d34d96615595676d"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/clintcparker/name-on/releases/download/v1.0.0/name-on-linux-arm64.tar.gz"
      sha256 "9cabd28858a4c48c8028cabc9a9b43823bd7b99e64258346a441a08d7952dbd8"
    else
      url "https://github.com/clintcparker/name-on/releases/download/v1.0.0/name-on-linux-x64.tar.gz"
      sha256 "a8b860b9084e6c9afaddd1c65f93e60bc59f4426ebf1b6c64368ff0f6736c996"
    end
  end

  def install
    bin.install "name-on"
  end

  def post_install
    (bash_completion/"name-on").write Utils.safe_popen_read(bin/"name-on", "completions", "bash")
    (zsh_completion/"_name-on").write Utils.safe_popen_read(bin/"name-on", "completions", "zsh")
    (fish_completion/"name-on.fish").write Utils.safe_popen_read(bin/"name-on", "completions", "fish")
  end

  test do
    output = shell_output("#{bin}/name-on")
    assert_match(/^[a-zA-Z]+-[a-zA-Z]+-\d+$/, output.strip)
  end
end
