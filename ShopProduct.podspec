Pod::Spec.new do |s|
  s.name             = 'ShopProduct'
  s.version          = '1.0.0'
  s.summary          = 'Feature component providing product detail page for the Shop app.'
  s.description      = 'ShopProduct provides ProductDetailViewController, ProductDetailViewModel, route registration, and Target_Product for cross-component access via CTMediator.'
  s.homepage         = 'https://github.com/inhua/ShopProduct'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'inhua' => 'dev@inhua.com' }
  s.source           = { :git => 'https://github.com/inhua/ShopProduct.git', :tag => s.version.to_s }

  s.ios.deployment_target = '18.1'
  s.swift_version = '5.0'

  s.source_files = 'Sources/**/*.swift'

  s.dependency 'ShopBase'
  s.dependency 'ShopRouter'
  s.dependency 'ShopMediator'
end
