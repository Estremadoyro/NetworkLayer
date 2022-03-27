//
//  HomeVC.swift
//  NetworkLayer-Sample
//
//  Created by Leonardo  on 26/03/22.
//

import UIKit

class HomeVC: UIViewController {
  var networkManager: NetworkManager

  init(networkManager: NetworkManager) {
    self.networkManager = networkManager
    super.init(nibName: Nibs.home, bundle: Bundle.main)
  }

  @available(*, unavailable)
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension HomeVC {
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = UIColor.systemIndigo
    networkManager.getMovies(page: 1) { movies, error in
      guard let movies = movies else {
        print("Errror: \(error ?? "")")
        return
      }
      print("Movies: \(movies)")
    }
  }
}
