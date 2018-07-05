//
//  MovieDetailsViewController.swift
//  MovieStar
//
//  Created by Steven Taglohner on 01/07/2018.
//  Copyright © 2018 Steven Taglohner. All rights reserved.
//

import UIKit

class MovieDetailsViewController: UIViewController {
    
    var networkManager = NetworkManager.sharedInstance()
    
    var movie: Movie? {
        didSet {
            guard let movie = movie else {
                return
            }
            
            networkManager.getImageDataFrom("https://image.tmdb.org/t/p/w780\(movie.backdrop)") { (data, error) in
                if error == nil {
                    DispatchQueue.main.async {
                        
                        guard let data = data else { return }
                        self.backdrop.image = UIImage(data: data)
                    }
                }
            }
            title = movie.title
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .darkGray
        setupViews()
    }
    
    
    let backdrop: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    func setupViews() {
        [backdrop].forEach({ view.addSubview($0)})
        backdrop.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, size: .init(width: 0, height: 211
            ))
    }
    
    
    //    func scrollViewDidScroll(_ scrollView: UIScrollView) {
    //        let y = 300 - (scrollView.contentOffset.y + 300)
    //        let height = min(max(y, 0), 400)
    //        backdrop.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: height)
    //
    //
    //
    ////        navigationBarBackgroundView.alpha = 0
    //
    ////        var offset = (scrollView.contentOffset.y + 200) / 200
    ////
    ////        if offset > 0.6 {
    ////            offset = 1
    ////            UIView.animate(withDuration: 0.3, animations: {
    ////
    ////            }, completion: nil)
    ////        } else {
    ////            UIView.animate(withDuration: 0.3, animations: {
    ////
    ////            }, completion: nil)
    ////        }
    //    }
    
    
    
}
