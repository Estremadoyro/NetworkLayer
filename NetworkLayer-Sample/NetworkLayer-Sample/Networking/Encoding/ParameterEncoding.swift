//
//  ParameterEncoding.swift
//  NetworkLayer-Sample
//
//  Created by Leonardo  on 26/03/22.
//

import Foundation

// Convention for refering to Parameters
public typealias Parameters = [String: Any]

protocol ParameterEncoder {
  /// # `INOUT` defines parameters as `Reference Parameter`. Usually, parameters are passed as `value types`, but with `inout` you can make them `reference types` (So it's value can update inside the function)

  /// # Encodes parameters, this action can `fail` (May throw an error)
  static func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws
}
