//
//  Tools.swift
//  DemoMusicListMVVM
//
//  Created by PujieLee on 2023/1/12.
//

import UIKit

let SCREEN_WIDTH = UIScreen.main.bounds.size.width

func setViewMatchParent(vi:UIView) -> Void{
    
    guard vi.superview != nil else { return }
    
    vi.translatesAutoresizingMaskIntoConstraints = false
    
    vi.superview?.addConstraint(NSLayoutConstraint.init(item: vi,
                                                        attribute: .leading,
                                                        relatedBy: .equal,
                                                        toItem: vi.superview,
                                                        attribute: .leading,
                                                        multiplier: 1.0,
                                                        constant: 0))
    
    vi.superview?.addConstraint(NSLayoutConstraint.init(item: vi,
                                                        attribute: .trailing,
                                                        relatedBy: .equal,
                                                        toItem: vi.superview,
                                                        attribute: .trailing,
                                                        multiplier: 1.0,
                                                        constant: 0))
    
    vi.superview?.addConstraint(NSLayoutConstraint.init(item: vi,
                                                        attribute: .top,
                                                        relatedBy: .equal,
                                                        toItem: vi.superview,
                                                        attribute: .top,
                                                        multiplier: 1.0,
                                                        constant: 0))
    
    vi.superview?.addConstraint(NSLayoutConstraint.init(item: vi,
                                                        attribute: .bottom,
                                                        relatedBy: .equal,
                                                        toItem: vi.superview,
                                                        attribute: .bottom,
                                                        multiplier: 1.0,
                                                        constant: 0))
}
