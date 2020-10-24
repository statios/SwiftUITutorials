//
//  BadgeBackground.swift
//  Landmarks
//
//  Created by Stat.So on 2020/10/24.
//  Copyright © 2020 Apple. All rights reserved.
//

import SwiftUI

struct BadgeBackground: View {
  static let gradientStart = Color(red: 239.0 / 255, green: 120.0 / 255, blue: 221.0 / 255)
  static let gradientEnd = Color(red: 239.0 / 255, green: 172.0 / 255, blue: 120.0 / 255)
  
  var body: some View {
    GeometryReader { geometry in
      Path { path in
        var width: CGFloat = min(geometry.size.width, geometry.size.height)
        let height = width
        let xScale: CGFloat = 0.832
        let xOffset = (width * (1.0 - xScale)) / 2.0
        width *= xScale
        let startingPoint = CGPoint(
          x: xOffset + width * 0.95,
          y: height * (0.20 + HexagonParameters.adjustment)
        )
        path.move(to: startingPoint)
        HexagonParameters.points.forEach {
          let lineDestination = CGPoint(x: xOffset + width * $0.useWidth.0 * $0.xFactors.0,
                                        y: height * $0.useHeight.0 * $0.yFactors.0)
          let quadCurveDestinaiton = CGPoint(x: xOffset + width * $0.useWidth.1 * $0.xFactors.1,
                                             y: height * $0.useHeight.1 * $0.yFactors.1)
          let quadCurveControl = CGPoint(x: xOffset + width * $0.useWidth.2 * $0.xFactors.2,
                                         y: height * $0.useHeight.2 * $0.yFactors.2)
          path.addLine(to: lineDestination)
          path.addQuadCurve(to: quadCurveDestinaiton, control: quadCurveControl)
        }
      }
      .fill(LinearGradient(
        gradient: Gradient(colors: [Self.gradientStart, Self.gradientEnd]),
        startPoint: UnitPoint(x: 0.5, y: 0.0),
        endPoint: UnitPoint(x: 0.5, y: 0.6)
      ))
      .aspectRatio(1, contentMode: .fit)
    }
  }
}

struct BadgeBackground_Previews: PreviewProvider {
  static var previews: some View {
    BadgeBackground()
  }
}
