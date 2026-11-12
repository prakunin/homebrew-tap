cask "quietglobe" do
  version "1.1.2"
  sha256 "19922df8baeeab2a237e3765faae3bfea7d9cd3c939f31a448cf0ed64c39b084"

  url "https://github.com/prakunin/quietglobe/releases/download/v#{version}/QuietGlobe.zip"
  name "QuietGlobe"
  desc "Silent Globe-key layout switching and Fn+Esc retype in the other layout"
  homepage "https://github.com/prakunin/quietglobe"

  livecheck do
    url :url
    strategy :github_latest
  end

  # Sparkle updates the app itself; `brew upgrade --greedy` also works.
  auto_updates true
  depends_on macos: :ventura

  app "QuietGlobe.app"

  # Signed with a self-signed certificate, not notarized: Gatekeeper would block
  # a quarantined copy, so drop the quarantine flag Homebrew adds on download.
  # Install steps cannot refer to appdir, hence the fixed path (see caveats).
  postflight_steps do
    run "/usr/bin/xattr",
        args:           ["-dr", "com.apple.quarantine", "/Applications/QuietGlobe.app"],
        must_succeed:   false,
        writable_paths: ["/Applications/QuietGlobe.app"]
  end

  uninstall quit: "io.github.prakunin.quietglobe"

  caveats <<~EOS
    Grant Accessibility on first launch:
      System Settings → Privacy & Security → Accessibility.
    QuietGlobe updates itself (menu → Check for Updates…).
    With a custom --appdir, clear the quarantine flag yourself:
      xattr -dr com.apple.quarantine <appdir>/QuietGlobe.app
  EOS

  zap trash: [
    "~/Library/Caches/io.github.prakunin.quietglobe",
    "~/Library/HTTPStorages/io.github.prakunin.quietglobe",
    "~/Library/Preferences/io.github.prakunin.quietglobe.plist",
  ]
end
