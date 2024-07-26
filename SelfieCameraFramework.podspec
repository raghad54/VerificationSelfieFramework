
Pod::Spec.new do |s|
  s.name             = 'SelfieCameraFramework'
  s.version          = '0.2.0'
  s.summary          = 'A framework for capturing selfies with face detection.'
  s.description      = <<-DESC
                        SelfieCameraFramework provides a selfie camera screen with capture functionality. 
                        It includes face detection to ensure that a face is present before capturing the image.
                      DESC
  s.homepage         = 'https://github.com/raghad54/VerificationSelfieFramework'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Raghad Soliman' => 'raghad.ali.5495@gmail.com' }
  s.source           = { :git => 'https://github.com/raghad54/VerificationSelfieFramework.git', :tag => s.version.to_s }

  s.source_files     = 'Core/**/*.{h,m,swift}', 'Module/**/*.{h,m,swift}'
  s.public_header_files = 'Header/**/*.h'

  s.frameworks       = 'UIKit', 'AVFoundation', 'Vision'
  s.requires_arc     = true
  s.swift_version    = '5.0'
  s.ios.deployment_target = '12.0'
  s.osx.deployment_target = '10.13'
end
