Pod::Spec.new do |s|
  s.name = 'SwiftyExtension'
  s.version = '1.2.0'
  s.summary = 'A handy collection of more than 500 native Swift extensions to boost your productivity.'
  s.description = <<-DESC
  SwiftyExtension is a collection of over 500 native Swift extensions, with handy methods, syntactic sugar, and performance improvements for wide range of primitive data types, UIKit and Cocoa classes –over 500 in 1– for iOS, macOS, tvOS and watchOS.
                   DESC

  s.homepage = 'https://github.com/amine2233/SwiftyExtension'
  s.license = { type: 'MIT', file: 'LICENSE' }
  s.authors = { 'Amine Bensalah' => 'amine.bensalah@outlook.com' }

  s.ios.deployment_target = '10.0'
  s.osx.deployment_target = '10.12'
  s.tvos.deployment_target = '10.0'
  s.watchos.deployment_target = '4.0'

  s.requires_arc = true
  s.source = { git: 'https://github.com/amine2233/SwiftyExtension.git', tag: s.version.to_s }
  s.source_files = 'Sources/**/*.swift'
  s.swift_version = '4.2'

  s.pod_target_xcconfig = {
    'SWIFT_VERSION' => s.swift_version
  }

  s.module_name = s.name

  s.watchos.exclude_files = "Sources/AppKit", "Sources/UIKit"

  # SwiftStdlib Extensions
  s.subspec 'SwiftStdlib' do |sp|
    sp.source_files  = 'Sources/SwiftStdlib/*.swift'
  end

  # Foundation Extensions
  s.subspec 'Foundation' do |sp|
    sp.source_files  = 'Sources/Foundation/*.swift'
  end

  # UIKit Extensions
  s.subspec 'UIKit' do |sp|
    sp.source_files  = 'Sources/UIKit/*.swift', 'Sources/Shared/ColorExtensions.swift'
  end

  # AppKit Extensions
  s.subspec 'AppKit' do |sp|
    sp.source_files  = 'Sources/AppKit/*.swift', 'Sources/Shared/ColorExtensions.swift'
  end

  # CoreGraphics Extensions
  s.subspec 'CoreGraphics' do |sp|
    sp.source_files  = 'Sources/CoreGraphics/*.swift'
  end

  # CoreLocation Extensions
  s.subspec 'CoreLocation' do |sp|
    sp.source_files  = 'Sources/CoreLocation/*.swift'
  end

  # MapKit Extensions
  s.subspec 'MapKit' do |sp|
    sp.source_files = 'Sources/MapKit/*.swift'
  end

  # SpriteKit Extensions
  s.subspec 'SpriteKit' do |sp|
    sp.source_files = 'Sources/SpriteKit/*.swift'
  end

end
