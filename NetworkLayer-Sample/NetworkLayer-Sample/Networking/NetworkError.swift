//
//  NetworkError.swift
//  NetworkLayer-Sample
//
//  Created by Leonardo  on 26/03/22.
//

import Foundation

public enum NetworkError: String, Error {
  case parametersNil = "Parameters were nil."
  case encodingFailed = "Parameters encoding failed."
  case missingURL = "URL is nil."
}
