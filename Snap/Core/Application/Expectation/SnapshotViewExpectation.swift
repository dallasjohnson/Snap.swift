import UIKit
import XCTest

// MARK: - XCTestCase + View Expectation

extension UIImage {

    public var removingStatusBar: UIImage {
        guard let cgImage = cgImage else {
            fatalError("Should always have an cgImage")
        }

        let yOffset = 22 * scale // status bar height on standard devices (not iPhoneX)
        let rect = CGRect(
            x: 0,
            y: Int(yOffset),
            width: cgImage.width,
            height: cgImage.height - Int(yOffset)
        )

        guard let croppedCGImage = cgImage.cropping(to: rect) else {
            fatalError("Should always have an cgImage after cropping")
        }
        return UIImage(cgImage: croppedCGImage, scale: scale, orientation: imageOrientation)
    }
}

extension XCTestCase {
    public func expect(_ view: UIView,
                       function: String = #function,
                       file: StaticString = #file,
                       line: UInt = #line,
                       identifier: String?) -> ViewMatcher {

        let testTarget = TestTarget(
            function: function,
            file: file,
            line: line,
            named: identifier
        )
        view.layoutIfNeeded()

        return resolver.makeMatcher(
            with: view,
            isRecording: isRecording,
            tesTarget: testTarget
        )
    }

    public func expect(_ viewController: UIViewController,
                       function: String = #function,
                       file: StaticString = #file,
                       identifier: String? = nil) -> ViewMatcher {
        return self.expect(viewController.view, function: function, file: file, identifier: identifier)
    }

    /// Verify a screenshot of the app at this point matches and expected screenshot that
    /// was previously captured with `isREcordingEnabled = true`
    ///
    /// - Parameters:
    ///   - identifier: unique identifer for the assertion and to name the captured screenshots. If nil the identifer will be based on the file and line number where this was called.
    ///   - file: default to the current file
    ///   - function: default to the current function
    ///   - line: default to the current line
    public func verifyView(app: XCUIApplication,
                           identifier: String?,
                           file: StaticString = #file,
                           function: String = #function,
                           line: UInt = #line) {

        let croppedImage = app.screenshot().image.removingStatusBar
        expect(UIImageView(image: croppedImage),
               function: "\(function)-line\(line)",
               file: file,
               line: line,
               identifier: identifier).toMatchSnapshot(named: identifier)
    }
}
