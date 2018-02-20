import UIKit
import XCTest

// MARK: - XCTestCase + CALayer Expectation

extension XCTestCase {
    public func expect(_ layer: CALayer, function: String = #function, file: StaticString = #file, line: UInt = #line) -> LayerMatcher {
    let testTarget = TestTarget(
      function: function,
      file: file,
      line: line
    )
    layer.layoutIfNeeded()
    
    return resolver.makeMatcher(
      with: layer,
      isRecording: isRecording,
      tesTarget: testTarget
    )
  }
}
