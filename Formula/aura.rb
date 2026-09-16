class Aura < Formula
  desc "Album art, adaptive colors and synced lyrics for Spotify, in your terminal"
  homepage "https://github.com/Zezoo123/aura"
  url "https://github.com/Zezoo123/aura/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "a6b0b3421d49e5f0f4b5f1cdd95d1501b4a14116bb8889f339b37d164de97f8c"
  license "MIT"
  head "https://github.com/Zezoo123/aura.git", branch: "main"

  depends_on "rust" => :build
  depends_on :macos

  def install
    system "cargo", "install", *std_cargo_args
  end

  def caveats
    <<~EOS
      Run `aura` in a terminal with graphics support (iTerm2, Kitty, WezTerm, Ghostty)
      while the Spotify desktop app is open. The first run asks for permission to
      control Spotify; click Allow. Search and playlists need `aura login` (see README).
    EOS
  end

  test do
    assert_match "aura", shell_output("#{bin}/aura --version")
    assert_match "cache", shell_output("#{bin}/aura --help")
  end
end
