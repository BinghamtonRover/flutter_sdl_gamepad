#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint flutter_sdl_gamepad.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'flutter_sdl_gamepad'
  s.version          = '0.0.1'
  s.summary          = 'A new Flutter FFI plugin project.'
  s.description      = <<-DESC
A new Flutter FFI plugin project.
                       DESC
  s.homepage         = 'http://example.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Your Company' => 'email@example.com' }

  # This will ensure the source files in Classes/ are included in the native
  # builds of apps using this FFI plugin. Podspec does not support relative
  # paths, so Classes contains a forwarder C file that relatively imports
  # `../src/*` so that the C sources can be shared among all target platforms.
  s.source           = { :path => '.' }
  s.dependency 'FlutterMacOS'
  s.public_header_files = 'Classes/**/*.h', 'Frameworks/SDL3.framework/Headers/**/*.h'

  # tells cocoapods to include sdl3framework in the pod
  s.source_files     = 'Classes/**/*.{h,c,cc,cpp,swift}', '../../src/**/*.{h,c,cc,cpp}'

  # Include the SDL3 framework
  s.vendored_frameworks = 'Frameworks/SDL3.framework'

  # Specify the frameworks and libraries your plugin depends on
  s.frameworks = 'Cocoa', 'SDL3'

  # Set up compiler and linker flags
  s.compiler_flags = '-fno-objc-arc'

  # Set the header and framework search paths
  s.pod_target_xcconfig = {
    'FRAMEWORK_SEARCH_PATHS' => '"$(inherited)" "$(PODS_TARGET_SRCROOT)/Frameworks"',
    'HEADER_SEARCH_PATHS' => '"$(inherited)" "$(PODS_TARGET_SRCROOT)/Frameworks/SDL3.framework/Headers"',
    'OTHER_LDFLAGS' => '$(inherited) -framework SDL3',
    'DEFINES_MODULE' => 'YES'
  }

  s.platform = :osx, '10.11'
  s.swift_version = '5.0'
  s.requires_arc = false

end
