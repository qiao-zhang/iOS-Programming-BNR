//
//  DrawView.swift
//  iOS-BigNerdRanch
//
//  Created by Qiao Zhang on 12/15/16.
//  Copyright © 2016 Qiao Zhang. All rights reserved.
//

import UIKit

class DrawView: UIView {
  // MARK: Properties
  var currentLines = [NSValue: Line]()
  var finishedLines = [Line]()
  
  @IBInspectable var finishedLineColor: UIColor = UIColor.black {
    didSet {
      setNeedsDisplay()
    }
  }
  
  @IBInspectable var currentLineColor: UIColor = UIColor.red {
    didSet {
      setNeedsDisplay()
    }
  }
  
  @IBInspectable var lineThickness: CGFloat = 10 {
    didSet {
      setNeedsDisplay()
    }
  }
  
  // MARK: Methods
  func stroke(_ line: Line) {
    let path = UIBezierPath()
    path.lineWidth = lineThickness
    path.lineCapStyle = .round
    
    path.move(to: line.begin)
    path.addLine(to: line.end)
    path.stroke()
  }
  
  override func draw(_ rect: CGRect) {
    finishedLineColor.setStroke()
    finishedLines.forEach(stroke)
    currentLineColor.setStroke()
    for (_, line) in currentLines {
      stroke(line)
    }
  }

// MARK: UIResponder Methods

  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    print(#function)
    for touch in touches {
      let location = touch.location(in: self)
      let newLine = Line(begin: location, end: location)
      let key = NSValue(nonretainedObject: touch)
      currentLines[key] = newLine
    }
    setNeedsDisplay()
  }
  
  override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    print(#function)
    for touch in touches {
      let key = NSValue(nonretainedObject: touch)
      currentLines[key]?.end = touch.location(in: self)
    }
    setNeedsDisplay()
  }
  
  override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    print(#function)
    for touch in touches {
      let key = NSValue(nonretainedObject: touch)
      if var line = currentLines[key] {
        line.end = touch.location(in: self)
        currentLines.removeValue(forKey: key)
        finishedLines.append(line)
      }
    }
    setNeedsDisplay()
  }
  
  override func touchesCancelled(_ touches: Set<UITouch>,
                                 with event: UIEvent?) {
    print(#function)
    currentLines.removeAll()
    setNeedsDisplay()
  }
}
