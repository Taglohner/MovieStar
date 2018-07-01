
import Foundation

class MoviesTypePopular: MoviesCategoryModel {
    var type: MoviesCategory {
        return .popular
    }
    
    var sectionTitle: String {
        return "Popular Movies"
    }
    
    var rowCount: Int {
        return 1
    }
    
    var numberOfItems: Int {
        return movies.count
    }
    
    var movies: [Movie]
    
    init(movies: [Movie]) {
        self.movies = movies
    }
}

class MoviesTypeNowPlaying: MoviesCategoryModel {
    var type: MoviesCategory {
        return .nowPlaying
    }
    
    var sectionTitle: String {
        return "Now Playing"
    }
    
    var rowCount: Int {
        return 1
    }
    
    var numberOfItems: Int {
        return movies.count
    }
    
    var movies: [Movie]
    
    init(movies: [Movie]) {
        self.movies = movies
    }
}

class MoviesTypeTopRated: MoviesCategoryModel {
    var type: MoviesCategory {
        return .topRated
    }
    
    var sectionTitle: String {
        return "Top Rated"
    }
    
    var rowCount: Int {
        return 1
    }
    
    var numberOfItems: Int {
        return movies.count
    }
    
    var movies: [Movie]
    
    init(movies: [Movie]) {
        self.movies = movies
    }
}

