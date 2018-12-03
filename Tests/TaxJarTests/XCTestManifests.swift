import XCTest

#if !os(macOS)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(TaxJarTests.allTests),
        testCase(EnvironmentTests.allTests),
    ]
}
#endif
