#
# Be sure to run `pod lib lint SSOTPPinView.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
    s.name              = 'SSOTPPinView'
    s.version           = '1.0.1'
    s.summary           = 'A custom view to enter a code usually used in authentication.'
    s.description       = <<-DESC
    SSOTPPinView is a comprehensive library for iOS projects, designed to streamline the creation and customization of OTP (One Time Password) input views. With support for custom keyboards, extensive OTP view customization, and seamless integration with SwiftUI, SSOTPPinView provides a complete solution for secure and user-friendly OTP entry.
                DESC
    s.homepage          = 'https://github.com/SimformSolutionsPvtLtd/SSOTPPinView.git'
    s.license           = { :type => 'MIT', :file => 'LICENSE' }
    s.author            = { 'Pranay Patel' => 'pranay.p@simformsolutions.com' }
    s.source            = { :git => 'https://github.com/SimformSolutionsPvtLtd/SSOTPPinView.git', :tag => s.version.to_s }
    s.platform = :ios, "16.0"
    s.ios.deployment_target = '15.0'
    s.swift_version = '5.0'
    s.source_files      = 'Source/**/*.{swift}'
    s.resource = "Source/Resources/PrivacyInfo.xcprivacy"

end


