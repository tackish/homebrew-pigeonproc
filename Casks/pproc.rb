cask "pproc" do
  version "0.2.1"

  on_arm do
    url "https://github.com/tackish/pigeonproc/releases/download/v#{version}/PigeonProc-darwin-arm64.tar.gz"
    sha256 "f35c3377393dd1c6b7bc81141d595d6aeb233976a60bf93f2b5a104c0e593e1c"
  end
  on_intel do
    url "https://github.com/tackish/pigeonproc/releases/download/v#{version}/PigeonProc-darwin-x86_64.tar.gz"
    sha256 "0cbdf83281136f74f15084e64a350f51ec8c4dd80dfaf885d37fd8988fe3ecb9"
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
  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/PigeonProc.app"]
  end

  zap trash: [
    "~/Library/Application Support/dev.tackish.pigeonproc",
    "~/Library/Caches/dev.tackish.pigeonproc",
    "~/Library/WebKit/dev.tackish.pigeonproc",
  ]
end
