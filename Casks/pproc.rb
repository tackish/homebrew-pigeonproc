cask "pproc" do
  version "0.1.0"

  on_arm do
    url "https://github.com/tackish/pigeonproc/releases/download/v#{version}/PigeonProc-darwin-arm64.tar.gz"
    sha256 "026c7b901de1997df121f96d56efcebe87fca8afd34434f45a2327e83121f558"
  end
  on_intel do
    url "https://github.com/tackish/pigeonproc/releases/download/v#{version}/PigeonProc-darwin-x86_64.tar.gz"
    sha256 "425e9191c01291162faf7d889eaff184b4fc0d9714d336845107a611bfaa410d"
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
