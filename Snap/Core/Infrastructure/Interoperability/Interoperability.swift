import UIKit
import XCTest

public extension XCTestCase {
    public func verify(view: UIView, function: String = #function, file: StaticString = #file, line: UInt = #line) {
        let testTarget = TestTarget(
            function: function,
            file: file,
            line: line
        )
        return resolver.makeMatcher(
            with: view,
            isRecording: isRecording,
            tesTarget: testTarget
            ).toMatchSnapshot()
    }

    public func verify(layer: CALayer, function: String = #function, file: StaticString = #file, line: UInt = #line) {
        let testTarget = TestTarget(
            function: function,
            file: file,
            line: line
        )
        return resolver.makeMatcher(
            with: layer,
            isRecording: isRecording,
            tesTarget: testTarget
            ).toMatchSnapshot()
    }
}
