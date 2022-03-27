//
//  JSONParameterEncoder.swift
//  NetworkLayer-Sample
//
//  Created by Leonardo  on 27/03/22.
//

import Foundation

public struct JSONParameterEncoder: ParameterEncoder {
  // Encode parameters to JSON and add headers (For senging data)
  static func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws {
    do {
      // JSON parameters as data
      let jsonAsData = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
      urlRequest.httpBody = jsonAsData
      if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
      }
    } catch {
      throw NetworkError.encodingFailed
    }
  }
}
