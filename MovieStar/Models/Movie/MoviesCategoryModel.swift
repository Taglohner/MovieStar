
import Foundation

protocol MoviesCategoryModel {
    var type: MoviesCategory { get }
    var sectionTitle: String { get }
    var rowCount: Int { get }
    var numberOfItems: Int { get }
}

extension MoviesCategoryModel {
    var rowCount: Int {
        return 0
    }
}

enum MoviesCategory {
    case popular
    case nowPlaying
    case topRated
}
