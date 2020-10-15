# Build_Framwork
## Add dependency for framework
## Point to dependency in App

# Install
## Cocoapods:
### Podfile
```swift
# Uncomment the next line to define a global platform for your project
platform :ios, '11.0'

source 'https://cdn.cocoapods.org/'
source 'https://github.com/baonguyena1/Build_Framwork.git'

target 'Project_Targer' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Project_Tager
  pod 'FruitBasket', '~> 1.0'

end
```
### Carthage
```
git "https://github.com/baonguyena1/Build_Framwork.git"
```