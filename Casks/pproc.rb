cask "pproc" do
  version "0.3.0"

  on_arm do
    url "https://github.com/tackish/pigeonproc/releases/download/v#{version}/PigeonProc-darwin-arm64.tar.gz"
    sha256 "56491131b40371c57471a16cb7df14b2b89db6dfed152d11610c57bf2530eadf"
  end
  on_intel do
    url "https://github.com/tackish/pigeonproc/releases/download/v#{version}/PigeonProc-darwin-x86_64.tar.gz"
    sha256 "d7ae8a631f5ffa46e83b3ebf1b6ac96051fbf6540f9d610d98dc4935c793fed8"
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
