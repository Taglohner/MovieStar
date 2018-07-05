//
//  Extensions.swift
//  MovieStar
//
//  Created by Steven Taglohner on 30/06/2018.
//  Copyright © 2018 Steven Taglohner. All rights reserved.
//


import UIKit

extension UIView {
    
    func anchor(top: NSLayoutYAxisAnchor?, leading: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, trailing: NSLayoutXAxisAnchor?, padding: UIEdgeInsets = .zero, size: CGSize = .zero) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: padding.top).isActive = true
        }
        
        if let leading = leading {
            leadingAnchor.constraint(equalTo: leading, constant: padding.left).isActive = true
        }
        
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -padding.bottom).isActive = true
        }
        
        if let trailing = trailing {
            trailingAnchor.constraint(equalTo: trailing, constant: -padding.right).isActive = true
        }
        
        if size.width != 0 {
            widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }
        
        if size.height != 0 {
            heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
    }
    
    func anchorSize(to view: UIView) {
        widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
    }
}

extension UINavigationBar {
    func setupDefaultNavigationBar() {
        backgroundColor = .black
        isTranslucent = false
        tintColor = .white
        shadowImage = UIImage()
        barStyle = .blackTranslucent
        prefersLargeTitles = true
    }
    
    func setTranslucentNavigationBarStyle() {
        setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        tintColor = .white
        backgroundColor = .clear
        shadowImage = UIImage()
        isTranslucent = true
        prefersLargeTitles = true
    }
}

extension UIViewController {
    
    func setStatusBarView(color: UIColor, tag: Int) {
        let statusBarView: UIView = {
            let view = UIView()
            view.backgroundColor = color
            view.frame = UIApplication.shared.statusBarFrame
            view.translatesAutoresizingMaskIntoConstraints = false
            view.tag = tag
            return view
        }()
        
        if let window = UIApplication.shared.keyWindow {
            window.addSubview(statusBarView)
        }
    }
    
    func removeStatusBarViewWith(tag: Int) {
        if let statusBarView = UIApplication.shared.keyWindow?.viewWithTag(tag) {
            statusBarView.removeFromSuperview()
        }
    }
    
    func removeViewFromNavigationBarWith( tag: Int) {
        if let view = navigationController?.navigationBar.viewWithTag(tag) {
            view.removeFromSuperview()
        }
    }
}

extension UIColor {
    
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat, alpha: CGFloat) {
        self.init(red: r/255, green: g/255, blue: b/255, alpha: alpha)
    }
    
    static var movieRed: UIColor {
        return UIColor(r: 255, g: 40, b: 0, alpha: 1)
    }
    
}

