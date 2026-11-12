# prakunin/homebrew-tap

```sh
brew install --cask prakunin/tap/quietglobe
```

| Cask | App |
|---|---|
| `quietglobe` | [QuietGlobe](https://github.com/prakunin/quietglobe) — silent Globe-key layout switching, Fn+Esc retype in the other layout |

QuietGlobe updates itself (Sparkle); the cask is bumped automatically by the app's release workflow.
The app is signed with a self-signed certificate and not notarized, so the cask removes the
quarantine flag after install. After the first install, grant Accessibility in
System Settings → Privacy & Security → Accessibility.
