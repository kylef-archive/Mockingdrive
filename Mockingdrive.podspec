Pod::Spec.new do |spec|
  spec.name = 'Mockingdrive'
  spec.version = '0.1.0'
  spec.summary = 'Testing framework for stubbing Hypermedia HTTP requests'
  spec.homepage = 'https://github.com/kylef/Mockingdrive'
  spec.license = { :type => 'MIT', :file => 'LICENSE' }
  spec.author = { 'Kyle Fuller' => 'kyle@fuller.li' }
  spec.social_media_url = 'http://twitter.com/kylefuller'
  spec.source = { :git => 'https://github.com/kylef/Mockingdrive.git', :tag => spec.version }
  spec.source_files = 'Mockingdrive/*.{h,swift}'
  spec.frameworks = 'XCTest'
  spec.ios.deployment_target = '8.0'
  spec.osx.deployment_target = '10.9'
  spec.requires_arc = true
  spec.dependency 'Representor'
  spec.dependency 'Mockingjay', '~> 1.0'
end

