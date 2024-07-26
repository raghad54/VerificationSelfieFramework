Pod::Spec.new do |spec|
  spec.name         = 'VerificationSelfieFramework'
  spec.version      = '0.1.0'
  spec.license      = { :type => 'MIT' }
  spec.homepage     = 'https://github.com/raghad54/VerificationSelfieFramework'
  spec.authors      = { 'Raghad Soliman' => 'raghad.ali.5495@gmail.com' }
  spec.summary      = 'A framework for capturing selfies with face detection.'
  spec.source       = { :git => 'https://github.com/raghad54/VerificationSelfieFramework.git', :tag => 'v0.1.0' }
  
  # Source files
  spec.source_files = 
    'VerificationSelfieFramework/Core/**/*.{h,m,swift}'
  spec.framework    = 'AvFoundation'
      
  # Swift version
  
  # Deployment targets
  spec.ios.deployment_target = '14.0'


end
