platform :ios, '10'

#[!] Your project does not explicitly specify the CocoaPods master specs repo. Since CDN is now used as the default, you may safely remove it from your repos directory via `pod repo remove master`. To suppress this warning please add `warn_for_unused_master_specs_repo => false` to your Podfile.
install! 'cocoapods',
:warn_for_unused_master_specs_repo => false

inhibit_all_warnings! # 关闭所有警告

target 'SwiftLIB' do
    pod 'SnapKit'
    pod 'HandyJSON'
end
