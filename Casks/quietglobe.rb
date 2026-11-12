cask "quietglobe" do
  version "1.2.0"
  sha256 "ffb711960b4c19f395377e5b9608ca9921dc4cd70124b0c35d1b83b639b34a41"

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

  zap trash: [
    "~/Library/Caches/io.github.prakunin.quietglobe",
    "~/Library/HTTPStorages/io.github.prakunin.quietglobe",
    "~/Library/Preferences/io.github.prakunin.quietglobe.plist",
  ]

  caveats <<~EOS
    Grant Accessibility on first launch:
      System Settings → Privacy & Security → Accessibility.
    QuietGlobe updates itself (menu → Check for Updates…).
    With a custom --appdir, clear the quarantine flag yourself:
      xattr -dr com.apple.quarantine <appdir>/QuietGlobe.app
  EOS
end
