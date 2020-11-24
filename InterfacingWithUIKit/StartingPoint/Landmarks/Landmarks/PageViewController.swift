//
//  PageViewController.swift
//  Landmarks
//
//  Created by Stat.So on 2020/10/24.
//  Copyright © 2020 Apple. All rights reserved.
//

import SwiftUI
import UIKit

struct PageViewController: UIViewControllerRepresentable {
  var controllers: [UIViewController]
  func makeCoordinator() -> Coordintor {
    Coordintor(self)
  }
  func makeUIViewController(context: Context) -> UIPageViewController {
    let pageViewController = UIPageViewController(transitionStyle: .scroll,
                                                  navigationOrientation: .horizontal)
    pageViewController.dataSource = context.coordinator
    return pageViewController
  }
  func updateUIViewController(_ pageViewController: UIPageViewController,
                              context: Context) {
    pageViewController.setViewControllers([controllers[0]],
                                          direction: .forward,
                                          animated: true)
  }
  class Coordintor: NSObject, UIPageViewControllerDataSource {
    var parent: PageViewController
    init(_ pageViewController: PageViewController) {
      self.parent = pageViewController
    }
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerBefore viewController: UIViewController) -> UIViewController? {
      guard let index = parent.controllers.firstIndex(of: viewController) else { return nil }
      if index == 0 {
        return parent.controllers.last
      }
      return parent.controllers[index - 1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerAfter viewController: UIViewController) -> UIViewController? {
      guard let index = parent.controllers.firstIndex(of: viewController) else { return nil }
      if index + 1 == parent.controllers.count {
        return parent.controllers.first
      }
      return parent.controllers[index + 1]
    }
  }
}
