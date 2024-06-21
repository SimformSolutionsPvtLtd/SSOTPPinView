#
#  Be sure to run `pod spec lint SSOTPPinView.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://guides.cocoapods.org/syntax/podspec.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |spec|

  # ―――  Spec Metadata  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  These will help people to find your library, and whilst it
  #  can feel like a chore to fill in it's definitely to your advantage. The
  #  summary should be tweet-length, and the description more in depth.
  #

  spec.name         = "SSOTPPinView"
  spec.version      = "1.0.0"
  spec.summary      = "A custom view to enter a code usually used in authentication."

  # ―――  Description ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #   This description is used to generate tags and improve search results.
  #     * Think: What does it do? Why did you write it? What is the focus?
  #     * Try to keep it short, snappy and to the point.
  #     * Write the description between the DESC delimiters below.
  #     * Finally, don't worry about the indent, CocoaPods strips it!
  spec.description  = <<-DESC
  [TODO]: Add long description
                   DESC
                   
  # ―――  Spec Homepage ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

  spec.homepage     = "https://github.com/SimformSolutionsPvtLtd/SSOTPPinView"

  # ―――  Spec License  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Licensing your code is important. See https://choosealicense.com for more info.
  #  CocoaPods will detect a license file if there is a named LICENSE*
  #  Popular ones are 'MIT', 'BSD' and 'Apache License, Version 2.0'.
  #

  spec.license      = { :type => "MIT", :file => "LICENSE" }


  # ――― Author Metadata  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Specify the authors of the library, with email addresses. Email addresses
  #  of the authors are extracted from the SCM log. E.g. $ git log. CocoaPods also
  #  accepts just a name if you'd rather not provide an email address.
  #
  #  Specify a social_media_url where others can refer to, for example a twitter
  #  profile URL.
  #

  spec.author             = { "Vraj Shah" => "vraj.s@simformsolutions.com" }


  # ――― Source Location ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Specify the location from where the source should be retrieved.
  #  Supports git, hg, bzr, svn and HTTP.
  #

  spec.source       = { :git => "https://github.com/SimformSolutionsPvtLtd/SSOTPPinView.git", :tag => spec.version.to_spec }


  # ――― Source Code ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  CocoaPods is smart about how it includes source code. For source files
  #  giving a folder will include any swift, h, m, mm, c & cpp files.
  #  For header files it will include any header in the folder.
  #  Not including the public_header_files will make all headers public.
  #

  spec.source_files  = 'SSOTPPinView/Source/*.swift'


  # ――― Project Linking ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Link your library with frameworks, or libraries. Libraries do not include
  #  the lib prefix of their name.
  #

  spec.framework  = "UIKit"

end
