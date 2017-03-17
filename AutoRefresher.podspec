

Pod::Spec.new do |s|
    s.name         = "AutoRefresher"
    s.version      = "0.1.3"
    s.summary      = "A lib to auto refresh data and notify the page to update data."

    s.homepage     = "https://github.com/kdjfqk/AutoRefresher"
    s.license      = "MIT"

    s.author             = { "kdjfqk" => "kdjfqk@126.com" }

    s.source       = { :git => "https://github.com/kdjfqk/AutoRefresher.git", :tag => "#{s.version}" }
    s.source_files = 'AutoRefresher/Classes/**/*'

    s.pod_target_xcconfig = {
        'SWIFT_VERSION' => '3.0',
    }

    s.platform = :ios

    s.dependency 'Aspects'
end
