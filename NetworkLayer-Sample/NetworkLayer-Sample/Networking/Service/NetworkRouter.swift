//
//  NetworkRouter.swift
//  NetworkLayer-Sample
//
//  Created by Leonardo  on 27/03/22.
//

import Foundation

public typealias NetworkRouterCompletion = (_ data: Data?, _ response: URLResponse?, _ error: Error?) -> ()

protocol NetworkRouter {
  associatedtype EndPoint: EndpointType
  func request(_ route: EndPoint, completion: @escaping NetworkRouterCompletion)
  func cancel()
}
