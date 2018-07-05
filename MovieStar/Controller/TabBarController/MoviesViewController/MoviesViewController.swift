//
//  MoviesViewController.swift
//  MovieStar
//
//  Created by Steven Taglohner on 01/07/2018.
//  Copyright © 2018 Steven Taglohner. All rights reserved.
//

import UIKit

class MoviesViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .darkGray
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let navigationBar = self.navigationController?.navigationBar {
            navigationBar.setupDefaultNavigationBar()
        }
    }
}


