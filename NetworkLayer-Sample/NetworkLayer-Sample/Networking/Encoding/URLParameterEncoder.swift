//
//  URLParameterEncoder.swift
//  NetworkLayer-Sample
//
//  Created by Leonardo  on 26/03/22.
//

import Foundation

public struct URLParameterEncoder: ParameterEncoder {
  /// # Takes parameters and makes them safe to be passed as `URL parameters`
  /// As some characters are forbidden in URLs
  static func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws {
    guard let url = urlRequest.url else { throw NetworkError.missingURL }
    if var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false), !parameters.isEmpty {
      // Must be in order of appearance in the url
      urlComponents.queryItems = [URLQueryItem]()
      for (key, value) in parameters {
        // Replaces not allowed URL Characters with percent encoded characters (i.e.: %20 for spaces)
        let queryItem = URLQueryItem(name: key, value: "\(value)".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed))
        urlComponents.queryItems?.append(queryItem)
      }
      // New URL with query items added with correct encoded characters
      urlRequest.url = urlComponents.url
      print("URL with encoded characters: \(String(describing: urlRequest.url))")
    }
    // Specifies the ContentType header value if not set yet
    if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
      urlRequest.setValue("application/x-www-form-urlencoded; charset=utf-8", forHTTPHeaderField: "Content-Type")
    }
  }
}
