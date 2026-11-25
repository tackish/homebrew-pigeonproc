cask "pproc" do
  version "0.2.0"

  on_arm do
    url "https://github.com/tackish/pigeonproc/releases/download/v#{version}/PigeonProc-darwin-arm64.tar.gz"
    sha256 "ff5eea93ec8e09191f2473a8e211c44b92c5199218661f222f23703f648728f4"
  end
  on_intel do
    url "https://github.com/tackish/pigeonproc/releases/download/v#{version}/PigeonProc-darwin-x86_64.tar.gz"
    sha256 "36974c606f97d465908f87ccd72c128944bd9cf14fb4e4bee1e89a2ab44105ce"
  end

  name "PigeonProc"
  desc "Process status, ports and traffic at a glance — and a way to end them"
  homepage "https://github.com/tackish/pigeonproc"

  app "PigeonProc.app"
  # Launch it from the terminal like the sibling apps: `pproc` opens it.
  # Symlinks the app's own executable, so it's a real launcher, not a wrapper.
  binary "#{appdir}/PigeonProc.app/Contents/MacOS/PigeonProc", target: "pproc"

  # The app is ad-hoc signed but not notarized, so Homebrew's quarantine flag
  # makes Gatekeeper block the first launch. Clear it on install so `pproc`
  # and double-click just work. (Drop this once we notarize.)
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/PigeonProc.app"]
  end

  zap trash: [
    "~/Library/Application Support/dev.tackish.pigeonproc",
    "~/Library/Caches/dev.tackish.pigeonproc",
    "~/Library/WebKit/dev.tackish.pigeonproc",
  ]
end
