//
//  HTTPTask.swift
//  NetworkLayer-Sample
//
//  Created by Leonardo  on 26/03/22.
//

import Foundation

// Typealias for dictionary
public typealias HTTPHeaders = [String: String]

/// # Configuring paramteres for a specific `EndPoint`
/// Where request refers to GET
public enum HTTPTask {
  case request
  case requestParameters(bodyParameters: Parameters?, urlParameters: Parameters?)
  case requestParametersAndHeaders(bodyParameters: Parameters?, urlParameters: Parameters?, additionHeaders: HTTPHeaders?)

  // case upload, download, etc
}
