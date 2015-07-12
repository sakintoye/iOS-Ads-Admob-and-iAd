# iOS-Ads-Admob-and-iAd

Add ads to your iOS apps with this tiny helper. Currently supports Google AdMob and Apple iAd.

##Instruction

- Import Ads.swift into your project.
- For Google AdMob, locate `AdUnitID` in Ads.swift and change it's value to your AdMob ID

##Usage
In your view controller, add the following code to `viewDidLoad()` method

var appAds = Ads()

appAds.vc = self

appAds.initiAdBanner() //loads iAd banner

appAds.initAdMobBanner() //loads AdMob banner
