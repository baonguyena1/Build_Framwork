Pod::Spec.new do |spec|
    spec.name = "FruitBasket"
    spec.version = "1.0.5"
    spec.summary = "Sample framework FruitBasket."
    spec.homepage = "https://github.com/baonguyena1/Build_Framwork"
    spec.license = { type: 'MIT', file: 'LICENSE' }
    spec.authors = { "Bao Nguyen" => 'baonguyena1@gmail.com' }
    spec.social_media_url = "https://facebook.com/baonguyena1"

    spec.framework = "UIKit"
  
    spec.platform = :ios, "11.0"
    spec.requires_arc = true
    spec.source = { git: "https://github.com/baonguyena1/Build_Framwork.git", tag: "v#{spec.version}", submodules: true }
    spec.source_files = "FruitBasket/**/*.{h,swift}"
  
    spec.dependency "SwiftDate", "~> 6.0"

    spec.swift_version = "5.0"
  end
