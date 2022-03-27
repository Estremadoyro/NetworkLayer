//
//  Router.swift
//  NetworkLayer-Sample
//
//  Created by Leonardo  on 27/03/22.
//

import Foundation

class Router<EndPoint: EndpointType>: NetworkRouter {
  private var task: URLSessionTask?

  // Create request with buildRequest and giving it a route which is an EndPoint
  func request(_ route: EndPoint, completion: @escaping NetworkRouterCompletion) {
    let session = URLSession.shared
    do {
      let request = try buildRequest(from: route)
      task = session.dataTask(with: request, completionHandler: { data, response, error in
        completion(data, response, error)
      })
    } catch {
      completion(nil, nil, error)
    }
    task?.resume()
  }

  func cancel() {
    task?.cancel()
  }
}

extension Router {
  // Convert EndpointType into a Request, then pass it to a session,
  func buildRequest(from route: EndPoint) throws -> URLRequest {
    var request = URLRequest(url: route.baseURL.appendingPathComponent(route.path), cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 10.0)
    request.httpMethod = route.httpMethod.rawValue
    do {
      switch route.task {
        case .request:
          request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        case .requestParameters(let bodyParameters, let urlParameters):
          try configureParameters(bodyParameters: bodyParameters, urlParameters: urlParameters, request: &request)
        case .requestParametersAndHeaders(let bodyParameters, let urlParameters, let additionHeaders):
          try configureParameters(bodyParameters: bodyParameters, urlParameters: urlParameters, request: &request)
          // As it adds now (instead of setting before configureParameters does), should be after configureParameters
          addAditionalHeaders(additionHeaders, request: &request)
      }
      return request
    } catch {
      throw error
    }
  }
}

private extension Router {
  // Encoding parameters, should have an encoder Enum if the API has different encoding styles
  // bodyParameters -> JSON
  // urlParameters  -> URL Encoded
  func configureParameters(bodyParameters: Parameters?, urlParameters: Parameters?, request: inout URLRequest) throws {
    do {
      if let bodyParameters = bodyParameters {
        try JSONParameterEncoder.encode(urlRequest: &request, with: bodyParameters)
      }
      if let urlParameters = urlParameters {
        try URLParameterEncoder.encode(urlRequest: &request, with: urlParameters)
      }
    } catch {
      throw error
    }
  }
}

private extension Router {
  func addAditionalHeaders(_ additionalHeaders: HTTPHeaders?, request: inout URLRequest) {
    guard let headers = additionalHeaders else { return }
    for (key, value) in headers {
      // Sould be add, and not set
      // request.setValue(value, forHTTPHeaderField: key)
      request.addValue(value, forHTTPHeaderField: key)
    }
  }
}
