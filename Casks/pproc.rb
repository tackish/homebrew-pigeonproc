cask "pproc" do
  version "0.1.2"

  on_arm do
    url "https://github.com/tackish/pigeonproc/releases/download/v#{version}/PigeonProc-darwin-arm64.tar.gz"
    sha256 "451946dea73b673b20523faccade8b92f47da2101db7c4308d216d54d5ac41d9"
  end
  on_intel do
    url "https://github.com/tackish/pigeonproc/releases/download/v#{version}/PigeonProc-darwin-x86_64.tar.gz"
    sha256 "8f80e3fc676649e51c97c55b6f2922fdef913199a53c1250732b436ea697e7a1"
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
