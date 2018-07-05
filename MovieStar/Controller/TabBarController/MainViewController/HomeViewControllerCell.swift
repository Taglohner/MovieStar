//
//  HomeViewControllerCell.swift
//  MovieStar
//
//  Created by Steven Taglohner on 30/06/2018.
//  Copyright © 2018 Steven Taglohner. All rights reserved.
//

import UIKit


class HomeViewControllerCell: UICollectionViewCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    var homeViewController: HomeViewController?
    
    var unwrappedMovies: MoviesCategoryModel!
    var movies: MoviesCategoryModel? {
        didSet {
            guard let movies = movies else { return }
            unwrappedMovies = movies
            collectionView.reloadData()
        }
    }
    
    let styleOneHorizontalViewControllerCell = "styleOneHorizontalViewControllerCell"
    let seeMoreMoviesViewControllerCell = "seeMoreMoviesViewControllerCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .darkGray
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = true
        collectionView.showsVerticalScrollIndicator = false
        //        collectionView.decelerationRate = UIScrollViewDecelerationRateFast
        return collectionView
    }()
    
    //MARK: DataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return unwrappedMovies.numberOfItems + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row < unwrappedMovies.numberOfItems {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: styleOneHorizontalViewControllerCell, for: indexPath) as!
            StyleOneHorizontalViewControllerCell
            
            switch unwrappedMovies.type {
                
            case .nowPlaying:
                if let movieAtIndexPath = movies as? MoviesTypeNowPlaying {
                    cell.movie = movieAtIndexPath.movies[indexPath.item]
                }
            case .popular:
                if let movieAtIndexPath = movies as? MoviesTypePopular {
                    cell.movie = movieAtIndexPath.movies[indexPath.item]
                }
            case .topRated:
                if let movieAtIndexPath = movies as? MoviesTypeTopRated {
                    cell.movie = movieAtIndexPath.movies[indexPath.item]
                }
            }
            return cell
            
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: seeMoreMoviesViewControllerCell, for: indexPath) as! SeeMoreMoviesViewControllerCell
            return cell
        }
    }
    
    // MARK: Delegate
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 156, height: self.frame.size.height - 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(10, 10, 10, 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row < unwrappedMovies.numberOfItems {
            
            var movie: Movie?
            
            switch unwrappedMovies.type {
                
            case .nowPlaying:
                if let movieAtIndexPath = movies as? MoviesTypeNowPlaying {
                    movie = movieAtIndexPath.movies[indexPath.item]
                }
            case .popular:
                if let movieAtIndexPath = movies as? MoviesTypePopular {
                    movie = movieAtIndexPath.movies[indexPath.item]
                }
            case .topRated:
                if let movieAtIndexPath = movies as? MoviesTypeTopRated {
                    movie = movieAtIndexPath.movies[indexPath.item]
                }
            }
            
            if let movie = movie {
                homeViewController?.showMovieDetailsViewController(movie)
            }
        } else {
            print("See more movies!")
        }
    }
    
    //MARK: Supporting Methods
    
    func setupViews() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(StyleOneHorizontalViewControllerCell.self, forCellWithReuseIdentifier: styleOneHorizontalViewControllerCell)
        collectionView.register(SeeMoreMoviesViewControllerCell.self, forCellWithReuseIdentifier: seeMoreMoviesViewControllerCell)
        addSubview(collectionView)
        collectionView.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
    }
}

class SeeMoreMoviesViewControllerCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let movieCover: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "cover_placeholder")
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .darkGray
        return imageView
    }()
    
    func setupViews() {
        [movieCover].forEach({ addSubview($0)})
        movieCover.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: 34, right: 0))
    }
}

class StyleOneHorizontalViewControllerCell: UICollectionViewCell {
    
    var networkManager = NetworkManager.sharedInstance()
    
    var movie: Movie? {
        didSet {
            guard let movie = movie else {
                return
            }
            
            movieName.text = movie.title
            
            networkManager.getImageDataFrom("https://image.tmdb.org/t/p/w300/\(movie.posterPath)") { (data, error) in
                if error == nil {
                    DispatchQueue.main.async {
                        guard let data = data else { return }
                        self.movieCover.image = UIImage(data: data)
                    }
                }
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let movieCover: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "cover_placeholder")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let movieName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        //        label.backgroundColor = .red
        label.textAlignment = .center
        label.textColor = .white
        label.font = .systemFont(ofSize: 13)
        label.numberOfLines = 2
        label.text = "whatever"
        return label
    }()
    
    func setupViews() {
        [movieCover, movieName].forEach({ addSubview($0)})
        movieCover.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: 34, right: 0))
        movieName.anchor(top: movieCover.bottomAnchor, leading: movieCover.leadingAnchor, bottom: bottomAnchor, trailing: movieCover.trailingAnchor)
    }
}


