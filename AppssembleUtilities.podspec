Pod::Spec.new do |spec|
  spec.name = "AppssembleUtilities"
  spec.version = "1.0.0"
  spec.summary = "Utilities for new iOS projects"
  spec.homepage = "https://github.com/appssemble/appssembleUtilities"
  spec.license = { type: 'WTFPL', file: 'LICENSE' }
  spec.authors = { "Dragos Dobrean" => 'dragos@appssemble.com' }
  spec.social_media_url = "http://www.appssemble.com"

  spec.platform = :ios, "9.0"
  spec.requires_arc = true
  spec.source = { git: "https://github.com/appssemble/appssembleUtilities.git", tag: "v#{spec.version}", submodules: false }
  spec.source_files = "AppssembleUtilities/**/*.{h,swift}"
end