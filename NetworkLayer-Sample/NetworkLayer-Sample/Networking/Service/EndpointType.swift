//
//  EndpointType.swift
//  NetworkLayer-Sample
//
//  Created by Leonardo  on 26/03/22.
//

import Foundation

/// # All information necessary to configure an `EndPoint`
protocol EndpointType {
  var baseURL: URL { get }
  var path: String { get }
  // HTTP Protocols
  var httpMethod: HTTPMethod { get }
  var task: HTTPTask { get }
  var headers: HTTPHeaders? { get }
}
