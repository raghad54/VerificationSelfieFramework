Pod::Spec.new do |s|
  s.name             = 'SelfieCameraFramework'
  s.version          = '0.1.0'
  s.summary         = 'A framework for capturing selfies with face detection.'
  s.description     = <<-DESC
                        SelfieCameraFramework provides a selfie camera screen with capture functionality. 
                        It includes face detection to ensure that a face is present before capturing the image.
                      DESC
  s.homepage        = 'https://github.com/YourUsername/SelfieCameraFramework'
  s.license         = { :type => 'MIT', :file => 'LICENSE' }
  s.author          = { 'Raghad Soliman' => 'raghad.ali.5495@gmail.com' }
  s.source          = { :git => 'https://github.com/raghad54/VerificationSelfieFramework', :tag => s.version.to_s }
  s.source_files    = 'SelfieCameraFramework/Classes/**/*'
  s.public_header_files = 'SelfieCameraFramework/Classes/**/*.h'
  s.frameworks      = 'UIKit', 'AVFoundation', 'Vision'
  s.requires_arc    = true
end
