//
//  AppAds.swift
//  Created by Sunkanmi Akintoye Ola on 7/12/15

import Foundation
import UIKit

import iAd
import GoogleMobileAds
class Ads: UIView, GADBannerViewDelegate, ADBannerViewDelegate {
    let AdUnitID = "ca-app-pub-your-admob-ID"
    var vc: UIViewController!
    
    var iAdBannerView = ADBannerView()
    var adMobBannerView = GADBannerView()
  
    
    // Initialize Apple iAd banner
    func initiAdBanner() {
        iAdBannerView = ADBannerView(frame: CGRectMake(0, self.vc.view.frame.size.height, 0, 0) )
        iAdBannerView.delegate = self
        iAdBannerView.hidden = true
        vc.view.addSubview(iAdBannerView)
        bannerViewWillLoadAd(iAdBannerView)
    }
    
    // Initialize Google AdMob banner
    func initAdMobBanner() {
        if UIDevice.currentDevice().userInterfaceIdiom == UIUserInterfaceIdiom.Pad {
            // iPad banner
            adMobBannerView.adSize =  GADAdSizeFromCGSize(CGSizeMake(728, 90))
            adMobBannerView.frame = CGRectMake(0, self.vc.view.frame.size.height, 728, 90)
            
        } else {
            // iPhone banner
            adMobBannerView.adSize =  GADAdSizeFromCGSize(CGSizeMake(320, 50))
            adMobBannerView.frame = CGRectMake(0, self.vc.view.frame.size.height, 320, 50)
        }
        
        adMobBannerView.adUnitID = AdUnitID
        adMobBannerView.rootViewController = self.vc
        adMobBannerView.delegate = self
        //adMobBannerView.hidden = false
        vc.view.addSubview(adMobBannerView)
        
        var request = GADRequest()
        adMobBannerView.loadRequest(request)
        
        adViewDidReceiveAd(adMobBannerView)
    }
    
    
    // Hide the banner
    func hideBanner(banner: UIView) {
        if banner.hidden == false {
            UIView.beginAnimations("hideBanner", context: nil)
            // Hide the banner moving it below the bottom of the screen
            banner.frame = CGRectMake(0, self.vc.view.frame.size.height, banner.frame.size.width, banner.frame.size.height)
            UIView.commitAnimations()
            banner.hidden = true
        }
    }
    
    // Show the banner
    func showBanner(banner: UIView) {
        UIView.beginAnimations("showBanner", context: nil)
        // Move the banner on the bottom of the screen
        banner.frame = CGRectMake(0, self.vc.view.frame.size.height - banner.frame.size.height,
            banner.frame.size.width, banner.frame.size.height);
        UIView.commitAnimations()
        banner.hidden = false
    }
    
    // iAd banner available
    func bannerViewWillLoadAd(banner: ADBannerView!) {
        hideBanner(adMobBannerView)
        showBanner(iAdBannerView)

    }
    
    // NO iAd banner available
    func bannerView(banner: ADBannerView!, didFailToReceiveAdWithError error: NSError!) {
        println("iAd can't load ads right now, they'll be available later")
        hideBanner(iAdBannerView)
        var request = GADRequest()
        adMobBannerView.loadRequest(request)
    }
    
    
    // AdMob banner available
    func adViewDidReceiveAd(view: GADBannerView!) {
        println("AdMob loaded!")
        hideBanner(iAdBannerView)
        showBanner(adMobBannerView)
    }
    
    // NO AdMob banner available
    func adView(view: GADBannerView!, didFailToReceiveAdWithError error: GADRequestError!) {
        println("AdMob Can't load ads right now, they'll be available later \n\(error)")
        hideBanner(adMobBannerView)
    }
}
