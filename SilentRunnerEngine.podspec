Pod::Spec.new do |s|
  s.name         = "SilentRunnerEngine"
  s.version      = "0.0.9"
  s.summary      = "SilentRunnerEngine"

  s.homepage     = "https://github.com/HouseOfRisingSun/SilentRunner"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = { "andrewBatutin" => "abatutin@gmail.com" }

  s.source       = { :git => "https://github.com/HouseOfRisingSun/SilentRunner.git", :tag => s.version }
  s.source_files = 'SilentRunner/SilentRunnerEngine/**/*'
  s.framework    = 'Foundation'


  s.ios.deployment_target = '9.0'
  s.requires_arc = true

  s.dependency 'JSONRPCom'
  s.dependency 'SocketRocket'
  s.dependency 'OCMockito'



end
