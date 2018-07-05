//
//  HomeViewController.swift
//  MovieStar
//
//  Created by Steven Taglohner on 30/06/2018.
//  Copyright © 2018 Steven Taglohner. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    // MARK: Properties
    
    var collectionView: UICollectionView!
    var networkManager = NetworkManager.sharedInstance()
    
    let homeViewControllerCell = "homeViewControllerCell"
    let styleOneHeaderIdentifier = "styleOneHeaderIdentifier"
    let styleOneFooterIdentifier = "styleOneFooterIdentifier"
    
    var moviesCategory = [MoviesCategoryModel]() {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Home"

        fetchMovies()
        setupCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if let navigationBar = self.navigationController?.navigationBar {
            navigationBar.setupDefaultNavigationBar()
        }
    }
    
    func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        collectionView = UICollectionView(frame: view.frame, collectionViewLayout: layout)
        collectionView.contentInset = UIEdgeInsetsMake(0, 0, 68, 0)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .darkGray
        //        collectionView.backgroundView = UIView()
        collectionView.register(StyleOneHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: styleOneHeaderIdentifier)
        collectionView.register(StyleOneFooter.self, forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: styleOneFooterIdentifier)
        collectionView.register(HomeViewControllerCell.self, forCellWithReuseIdentifier: homeViewControllerCell)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        view.addSubview(collectionView)
    }
    
    func fetchMovies() {

        networkManager.getNowPlaying(page: 1) { movies, error in
            guard error == nil else {
                return print(error ?? "")
            }

            guard let movies = movies else {
                return print("error occurred fetching movies")
            }
            self.moviesCategory.append(MoviesTypeNowPlaying(movies: movies))
        }

        networkManager.getPopularMovies(page: 1) { movies, error in
            guard error == nil else {
                return print(error ?? "")
            }

            guard let movies = movies else {
                return print("error occurred fetching movies")
            }

            self.moviesCategory.append(MoviesTypePopular(movies: movies))
        }
        
        networkManager.getTopRated(page: 1) { movies, error in
            guard error == nil else {
                return print(error ?? "")
            }
            
            guard let movies = movies else {
                return print("error occurred fetching movies")
            }
            
            self.moviesCategory.append(MoviesTypeTopRated(movies: movies))
        }
    }
    
    func showMovieDetailsViewController(_ movie: Movie) {
        let movieDetailsViewController = MovieDetailsViewController()
        movieDetailsViewController.movie = movie
        self.navigationController?.pushViewController(movieDetailsViewController, animated: true)
    }
        
}
