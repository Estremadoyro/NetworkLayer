//
//  NetworkManager.swift
//  NetworkLayer-Sample
//
//  Created by Leonardo  on 27/03/22.
//

import Foundation

enum NetworkResponse: String {
  case success
  case authenticationError = "You need to be authenticated first."
  case badRequest = "Bad request"
  case outdated = "The url you requested is outdated."
  case failed = "Network request failed."
  case noData = "Response returned with no data to decode."
  case unableToDecode = "We could not decode the response."
  case errorFound = "Request error found"
}

enum Result<T: StringProtocol> {
  case success
  case failure(msg: T)
}

struct NetworkManager {
  static let environment: NetworkEnvironment = .production
  static let MovieApiKey = Keys.apiKey

  typealias MoviesCompletion = (_ movies: [Movie]?, _ error: String?) -> ()

  let router = Router<MovieApi>()

  func getMovies(page: Int, completion: @escaping MoviesCompletion) {
    router.request(.newMovies(page: page)) { data, response, error in
      if error != nil {
        completion(nil, NetworkResponse.errorFound.rawValue)
      }

      if let response = response as? HTTPURLResponse {
        let result = handleNetworkResponse(response)
        switch result {
          case .success:
            guard let responseData = data else {
              completion(nil, NetworkResponse.noData.rawValue)
              return
            }
            do {
              print("Response data: \(responseData)")
              let jsonData = try JSONSerialization.jsonObject(with: responseData, options: .mutableContainers)
              print("json data: \(jsonData)")
              let apiResponse = try JSONDecoder().decode(MovieApiResponse.self, from: responseData)
              completion(apiResponse.movies, nil)
            } catch {
              print("Error decoding: \(error)")
              completion(nil, NetworkResponse.unableToDecode.rawValue)
            }
          case .failure(let networkFailureError):
            completion(nil, networkFailureError)
        }
      }
    }
  }
}

private extension NetworkManager {
  func handleNetworkResponse(_ response: HTTPURLResponse) -> Result<String> {
    switch response.statusCode {
      case 200 ... 299: return .success
      case 401 ... 500: return .failure(msg: NetworkResponse.authenticationError.rawValue)
      case 501 ... 599: return .failure(msg: NetworkResponse.badRequest.rawValue)
      case 600: return .failure(msg: NetworkResponse.outdated.rawValue)
      default: return .failure(msg: NetworkResponse.failed.rawValue)
    }
  }
}
