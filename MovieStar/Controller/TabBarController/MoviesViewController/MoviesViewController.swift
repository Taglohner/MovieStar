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
        
        if let navigationBar = self.navigationController?.navigationBar {
            navigationBar.setupNavigationBar()
        }
        
        view.backgroundColor = .darkGray
    }
}


