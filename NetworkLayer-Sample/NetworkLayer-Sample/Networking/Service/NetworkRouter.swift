//
//  NetworkRouter.swift
//  NetworkLayer-Sample
//
//  Created by Leonardo  on 27/03/22.
//

import Foundation

public typealias NetworkRouterCompletion = (_ data: Data?, _ response: URLResponse?, _ error: Error?) -> ()

/// # Create requests and once the request is made, it passes the response to the completion
protocol NetworkRouter {
  associatedtype EndPoint: EndpointType
  // Can handle any Endpoint type
  func request(_ route: EndPoint, completion: @escaping NetworkRouterCompletion)
  func cancel()
}
