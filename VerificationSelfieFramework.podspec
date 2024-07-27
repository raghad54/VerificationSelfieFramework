Pod::Spec.new do |spec|
  spec.name         = 'VerificationSelfieFramework'
  spec.version      = '0.1.1'
  spec.license      = { :type => 'MIT' }
  spec.homepage     = 'https://github.com/raghad54/VerificationSelfieFramework'
  spec.authors      = { 'Raghad Soliman' => 'raghad.ali.5495@gmail.com' }
  spec.summary      = 'A framework for capturing selfies with face detection.'
  spec.source       = { :git => 'https://github.com/raghad54/VerificationSelfieFramework.git', :tag => 'v0.1.1' }

  # Source files
  spec.source_files = 'VerificationSelfieFramework/Core/**/*.{h,m,swift}', 'VerificationSelfieFramework/Headers/*.h'

  # Framework dependencies
  spec.frameworks = ['UIKit', 'AVFoundation', 'Vision']

  # ARC requirement
  spec.requires_arc = true
  spec.swift_versions = '5.0'

  # Deployment targets
  spec.ios.deployment_target = '12.0'
end
