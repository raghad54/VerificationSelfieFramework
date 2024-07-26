Pod::Spec.new do |spec|
  spec.name         = 'VerificationSelfieFramework'
  spec.version      = '0.1.0'
  spec.license      = { :type => 'MIT' }
  spec.homepage     = 'https://github.com/raghad54/VerificationSelfieFramework'
  spec.authors      = { 'Raghad Soliman' => 'raghad.ali.5495@gmail.com' }
  spec.summary      = 'A framework for capturing selfies with face detection.'
  spec.source       = { :git => 'https://github.com/raghad54/VerificationSelfieFramework.git', :tag => 'v0.1.0' }
  
  # Source files
  spec.source_files = [
    'VerificationSelfieFramework/Headers/**/*.{h,m,swift}',
    'VerificationSelfieFramework/Core/**/*.{h,m,swift}',
    'VerificationSelfieFramework/Modules/**/*.{h,m,swift}',
    'VerificationSelfieFramework/Extension/**/*.{h,m,swift}'
  ]
  
  # Public headers
  spec.public_header_files = 'VerificationSelfieFramework/Headers/**/*.h'
  
  # Resources
  
  # Framework dependencies
  spec.frameworks   = ['UIKit', 'AVFoundation', 'Vision']
  
  # ARC requirement
  spec.requires_arc = true
  
  # Swift version
  spec.swift_versions = ['5.0']
  
  # Deployment targets
  spec.ios.deployment_target = '12.0'
  
  # Script to copy Info.plist
  spec.pod_target_xcconfig = {
    'INFOPLIST_FILE' => '$(PODS_TARGET_SRCROOT)/VerificationSelfieFramework/Supporting Files/Info.plist'
  }
end
