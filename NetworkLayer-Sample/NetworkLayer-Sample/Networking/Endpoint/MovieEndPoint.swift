//
//  MovieEndPoint.swift
//  NetworkLayer-Sample
//
//  Created by Leonardo  on 27/03/22.
//

import Foundation

enum NetworkEnvironment {
  case qa
  case production
  case staging
}

public enum MovieApi {
  case recommended(id: Int)
  case popular(page: Int)
  case newMovies(page: Int)
  case video(id: Int)
}

extension MovieApi: EndpointType {
  var environmentBaseURL: String {
    switch NetworkManager.environment {
      case .production: return "https://api.themoviedb.org/3/movie/"
      // These are referential only, they don't exist
      case .qa: return "https://qa.themoviedb.org/3/movie/"
      case .staging: return "https://staging.themoviedb.org/3/movie/"
    }
  }

  var baseURL: URL {
    guard let url = URL(string: environmentBaseURL) else { fatalError("Base URL could not be encoded") }
    return url
  }

  var path: String {
    switch self {
      case .recommended(let id):
        return "\(id)/recommendations"
      // Not using the page parameter, as they are Request Parameters, and not URL
      case .popular:
        return "popular"
      case .newMovies:
        return "now_playing"
      case .video(let id):
        return "\(id)/videos"
    }
  }

  var httpMethod: HTTPMethod {
    return .get
  }

  var task: HTTPTask {
    switch self {
      case .newMovies(let page), .popular(let page):
        return .requestParameters(bodyParameters: nil, urlParameters:
          ["page": page, "api_key": NetworkManager.MovieApiKey])
      default:
        return .requestParameters(bodyParameters: nil, urlParameters:
          ["api_key": NetworkManager.MovieApiKey])
    }
  }

  var headers: HTTPHeaders? {
    return nil
  }
}
