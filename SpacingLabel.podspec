Pod::Spec.new do |s|

  # ―――  Spec Metadata  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

  s.name         = "SpacingLabel"
  s.version      = "0.0.1"
  s.summary      = "Subclass of UILabel enabling better compliance with graphic charts in terms of space between text and other elements"

  s.description  = <<-DESC
                   The SpacingLabel simply retrieve the font of the first line of text and the font of the last line of text to remove extra space on top of the first font cap height and the last font descender.
                   DESC

  s.homepage     = "https://github.com/cyrilchandelier/SpacingLabel"
  s.screenshots  = "https://raw.githubusercontent.com/cyrilchandelier/SpacingLabel/master/Assets/with_spacing_label.png"


  # ―――  Spec License  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

  s.license      = { :type => "MIT", :file => "LICENSE" }


  # ――― Author Metadata  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

  s.author             = { "Cyril Chandelier" => "cyril.chandelier@gmail.com" }

  # ――― Platform Specifics ――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

  s.platform     = :ios, "7.0"

  # ――― Source Location ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

  s.source       = { :git => "https://github.com/cyrilchandelier/SpacingLabel.git", :tag => "0.0.1" }

  # ――― Source Code ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

  s.source_files  = "*.{h,m}"

  # ――― Project Settings ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

  s.requires_arc = true

end
