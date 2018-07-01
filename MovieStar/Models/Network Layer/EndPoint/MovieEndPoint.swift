
import Foundation

enum NetworkEnvironment {
    case qa
    case production
    case staging
}

public enum MovieApi {
    case recommended(id:Int)
    case popular(page:Int)
    case nowPlaying(page:Int)
    case topRated(page: Int)
    case video(id:Int)
}

extension MovieApi: EndPointType {
    
    var environmentBaseURL : String {
        switch NetworkManager.environment {
        case .production: return "https://api.themoviedb.org/3/movie/"
        case .qa: return "https://qa.themoviedb.org/3/movie/"
        case .staging: return "https://staging.themoviedb.org/3/movie/"
        }
    }
    
    var baseURL: URL {
        guard let url = URL(string: environmentBaseURL) else { fatalError("baseURL could not be configured.")}
        return url
    }
    
    var path: String {
        switch self {
        case .recommended(let id):
            return "\(id)/recommendations"
        case .popular:
            return "popular"
        case .nowPlaying:
            return "now_playing"
        case .topRated:
            return "top_rated"
        case .video(let id):
            return "\(id)/videos"
        }
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
    
    var task: HTTPTask {
        switch self {
        case .nowPlaying(let page):
            return .requestParameters(bodyParameters: nil, urlParameters: ["page":page, "api_key":NetworkManager.APIKey])
        case .popular(let page):
            return .requestParameters(bodyParameters: nil, urlParameters: ["page":page, "api_key":NetworkManager.APIKey])
        case .topRated(let page):
            return .requestParameters(bodyParameters: nil, urlParameters: ["page": page, "api_key":NetworkManager.APIKey])
        default:
            return .request
        }
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
}
